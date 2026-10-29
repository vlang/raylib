#!/usr/bin/env python3
"""Check that every member of every `pub struct C.X` in a V binding is spelled as in the C header.

V reads `mesh.triangleCount` as the C member `triangleCount`, so a binding that spells it
`triangle_count` compiles in V and fails in the C compiler (vlang/raylib#32).

    python3 scripts/check_struct_fields.py raylib.c.v ../raylib/src/raylib.h
"""
import re
import sys


def header_structs(path: str) -> dict[str, list[str]]:
	text = open(path, errors="replace").read()
	text = re.sub(r"/\*.*?\*/", "", text, flags=re.S)
	text = re.sub(r"//[^\n]*", "", text)
	structs = {}
	for m in re.finditer(r"typedef struct (\w+)\s*\{(.*?)\}\s*(\w+)\s*;", text, re.S):
		members = []
		for stmt in m.group(2).split(";"):
			stmt = stmt.strip()
			if not stmt:
				continue
			# `float x, y;` declares several members; `int params[4]` and `char *name` one each
			head = re.sub(r"\[[^\]]*\]", "", stmt)
			head = head.replace("*", " ")
			words = head.split()
			names = [w for w in re.split(r"[,\s]+", " ".join(words[1:])) if w] if "," in head else [words[-1]]
			if "," in head:
				first = re.split(r",", head)[0].split()[-1]
				names = [first] + [n.strip() for n in head.split(",")[1:]]
			members += names
		structs[m.group(3)] = members
	return structs


def binding_structs(path: str) -> dict[str, list[str]]:
	text = open(path).read()
	out = {}
	for m in re.finditer(r"^pub struct C\.(\w+)\s*\{\n(.*?)^\}", text, re.M | re.S):
		names = []
		for line in m.group(2).split("\n"):
			line = line.strip()
			if not line or line.startswith("//") or line in ("pub mut:", "pub:", "mut:"):
				continue
			names.append(line.split()[0].removeprefix("@"))
		out[m.group(1)] = names
	return out


def main():
	binding, header = sys.argv[1], sys.argv[2]
	want, have = header_structs(header), binding_structs(binding)
	bad = 0
	for name, fields in sorted(have.items()):
		if name not in want:
			continue
		wrong = [(f, None) for f in fields if f not in want[name]]
		if wrong:
			bad += 1
			print(f"  {name}: " + ", ".join(f for f, _ in wrong) + f"   (header: {', '.join(want[name])})")
	print(f"{binding}: {len(have)} structs, {bad} with a member the header does not have")
	sys.exit(1 if bad else 0)


main()
