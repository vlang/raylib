#!/usr/bin/env python3
"""Check every `fn C.X(...)` line of the V bindings against the prototype in the C header.

The check reads the header text itself (RLAPI / RMAPI / RAYGUIAPI lines), not the rlparser JSON that
raygen.py uses, and has its own table of C type -> V type, so a mistake in the generator is not
repeated here. Exit status 1 when any declaration disagrees.

    python3 scripts/check_prototypes.py raylib.c.v ../raylib/src/raylib.h RLAPI
    python3 scripts/check_prototypes.py raymath/raymath.c.v ../raylib/src/raymath.h RMAPI
    python3 scripts/check_prototypes.py raygui/raygui.c.v raygui/raygui.h RAYGUIAPI
"""
import re
import sys

# What a V declaration may spell for one C type. Pointers add `&` per `*`. Scalars `int` and
# `unsigned int` may also be spelled as an enum type the binding introduces for flag arguments.
SCALAR = {
	"void": [""], "bool": ["bool"], "char": ["char", "u8"], "float": ["f32"], "double": ["f64"],
	"int": ["int", "i32"], "unsigned int": ["u32", "int"], "short": ["i16"], "unsigned short": ["u16"],
	"unsigned char": ["u8"], "long": ["i64"], "size_t": ["C.size_t"], "va_list": ["C.va_list"],
	"rAudioBuffer": ["AudioBuffer"], "rAudioProcessor": ["AudioProcessor"],
	"float3": ["Float3"], "float16": ["Float16"],
}
# What C reads and writes through a pointer: the C width, never V's 8-byte `int`.
POINTEE = {"int": ["i32"], "unsigned int": ["u32"], "short": ["i16"], "unsigned short": ["u16"], "long": ["i64"]}


def expected_v_types(c_type: str, enums: set[str]) -> list[str]:
	c_type = c_type.strip()
	if c_type == "...":
		return ["..."]
	c_type = re.sub(r"\s+", " ", c_type)
	array = ""
	m = re.match(r"^(.*?)\s*((?:\[\d*\])+)$", c_type)
	if m:
		c_type, dims = m.group(1), m.group(2)
		array = "".join(f"[{d}]" for d in re.findall(r"\[(\d*)\]", dims))
	stars = c_type.count("*")
	base = c_type.replace("*", "").replace("const ", "").strip()
	if base == "void" and stars:
		return ["&" * (stars - 1) + "voidptr"] if stars == 1 else ["&" * (stars - 1) + "voidptr"]
	if stars or array:
		names = POINTEE.get(base) or SCALAR.get(base) or [base]
	else:
		names = SCALAR.get(base) or [base]
	out = []
	for n in names:
		out.append(array + "&" * stars + n)
	if not stars and not array and base in ("int", "unsigned int"):
		out += sorted(enums)
	return out


def split_params(text: str) -> list[str]:
	text = text.strip()
	if text in ("", "void"):
		return []
	parts, depth, cur = [], 0, ""
	for ch in text:
		if ch in "([":
			depth += 1
		if ch in ")]":
			depth -= 1
		if ch == "," and depth == 0:
			parts.append(cur)
			cur = ""
		else:
			cur += ch
	parts.append(cur)
	return parts


def param_type(param: str) -> str:
	"""`const char *text` -> `const char *`, `int codepoints[4]` -> `int [4]`."""
	param = param.strip()
	if param == "...":
		return param
	m = re.match(r"^(.*?)(\w+)\s*((?:\[\d*\])*)$", param)
	if not m:
		return param
	return (m.group(1) + (" " + m.group(3) if m.group(3) else "")).strip()


def read_header(path: str, macro: str):
	protos = {}
	rx = re.compile(r"^" + macro + r"\s+(.+?)\s*\b(\w+)\s*\((.*)\)\s*(?:;|\{|$)")
	for line in open(path, errors="replace"):
		line = re.sub(r"/\*.*?\*/", "", line)
		line = line.split("//")[0].strip()
		if not line.startswith(macro + " "):
			continue
		m = rx.match(line)
		if not m:
			continue
		ret, name, params = m.group(1), m.group(2), m.group(3)
		if name.startswith("rl"):
			continue
		# `RLAPI Color *LoadImageColors(...)`: the `*` sits against the name
		ret = ret.strip()
		stars = ""
		m2 = re.match(r"^(.*?)(\*+)$", ret)
		if m2:
			ret, stars = m2.group(1).strip(), m2.group(2)
		m3 = re.match(r"^(.*?)\s*\b\w+$", name)
		protos[name] = (ret + (" " + stars if stars else ""), [param_type(p) for p in split_params(params)])
	return protos


def read_binding(path: str):
	text = open(path).read()
	enums = set(re.findall(r"^pub enum (\w+)", text, re.M))
	decls = {}
	for m in re.finditer(r"^fn C\.(\w+)\((.*)\)[ \t]*(.*)$", text, re.M):
		decls[m.group(1)] = ([p.strip() for p in split_params(m.group(2))], m.group(3).strip())
	return decls, enums


def main():
	binding, header, macro = sys.argv[1], sys.argv[2], sys.argv[3]
	protos = read_header(header, macro)
	decls, enums = read_binding(binding)
	bad = []
	for name, (vparams, vret) in sorted(decls.items()):
		if name not in protos:
			bad.append((name, "not in the header"))
			continue
		cret, cparams = protos[name]
		if len(vparams) != len(cparams):
			bad.append((name, f"{len(vparams)} parameters, the header has {len(cparams)}"))
			continue
		for i, (vp, cp) in enumerate(zip(vparams, cparams)):
			ok = expected_v_types(cp, enums)
			# a declaration may omit parameter names: `fn C.X(&int)` or name them: `fn C.X(name &int)`
			vt = vp if " " not in vp or vp.startswith(("&", "[", "...", "C.")) and " " not in vp else vp.split(" ", 1)[1]
			if vt.startswith("..."):
				vt = "..."
			if vt not in ok:
				bad.append((name, f"parameter {i + 1}: V `{vt}`, C `{cp}` (accepts {ok[:3]})"))
		exp_ret = expected_v_types(cret, enums)
		if vret not in exp_ret and not (vret == "" and cret == "void"):
			bad.append((name, f"returns V `{vret}`, C `{cret}` (accepts {exp_ret[:3]})"))
	print(f"{binding}: {len(decls)} fn C. lines, {len(protos)} prototypes in {header}")
	missing = sorted(set(protos) - set(decls))
	if missing:
		print(f"  not bound ({len(missing)}): {' '.join(missing)}")
	for name, why in bad:
		print(f"  MISMATCH {name}: {why}")
	print(f"  {len(bad)} mismatches")
	sys.exit(1 if bad else 0)


main()
