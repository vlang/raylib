#!/usr/bin/env python3
"""Count what moved between two versions of a generated binding file, by kind.

    git show HEAD:raylib.c.v > /tmp/old.c.v
    python3 scripts/diff_summary.py /tmp/old.c.v raylib.c.v
"""
import re
import sys


def parse(path):
	text = open(path).read()
	d = {}
	d["c_fns"] = {m.group(1): (m.group(2).strip(), m.group(3).strip()) for m in re.finditer(r"^fn C\.(\w+)\((.*)\)[ \t]*(.*)$", text, re.M)}
	d["wrappers"] = {m.group(1): m.group(2).strip() for m in re.finditer(r"^(?:@\[inline\] )?pub fn (\w+)\((.*?)\)[^\n{]*\{", text, re.M)}
	structs = {}
	for m in re.finditer(r"^pub struct C\.(\w+)\s*\{\n(.*?)^\}", text, re.M | re.S):
		fields = {}
		for line in m.group(2).split("\n"):
			line = line.strip()
			if not line or line.startswith("//") or line.endswith(":"):
				continue
			parts = line.split(None, 1)
			fields[parts[0]] = parts[1] if len(parts) > 1 else ""
		structs[m.group(1)] = fields
	d["structs"] = structs
	enums = {}
	for m in re.finditer(r"^pub enum (\w+)[^\n{]*\{\n(.*?)^\}", text, re.M | re.S):
		enums[m.group(1)] = [l.split("//")[0].strip() for l in m.group(2).split("\n") if l.strip() and not l.strip().startswith("//")]
	d["enums"] = enums
	d["callbacks"] = {m.group(1): m.group(2).strip() for m in re.finditer(r"^pub type (\w+) = fn (.*)$", text, re.M)}
	return d


def main():
	a, b = parse(sys.argv[1]), parse(sys.argv[2])
	rows = []

	def block(label, x, y):
		added, removed = sorted(set(y) - set(x)), sorted(set(x) - set(y))
		changed = sorted(k for k in set(x) & set(y) if x[k] != y[k])
		rows.append((label, len(added), len(removed), len(changed)))
		return added, removed, changed

	block("fn C. declarations", a["c_fns"], b["c_fns"])
	ca, cr, cc = block("pub fn wrappers", a["wrappers"], b["wrappers"])
	block("structs", a["structs"], b["structs"])
	renamed = []
	fields_changed = 0
	pointer_fixed = 0
	for name in sorted(set(a["structs"]) & set(b["structs"])):
		old, new = a["structs"][name], b["structs"][name]
		gone, came = sorted(set(old) - set(new)), sorted(set(new) - set(old))
		if gone or came:
			fields_changed += 1
		for g in list(gone):
			cand = [c for c in came if c.lower().replace("_", "") == g.lower().replace("_", "")]
			if cand:
				renamed.append((name, g, cand[0]))
		for f in set(old) & set(new):
			if old[f] != new[f]:
				pointer_fixed += 1
	rows.append(("struct members renamed to the header's spelling", len(renamed), 0, 0))
	block("enums", a["enums"], b["enums"])
	block("callbacks", a["callbacks"], b["callbacks"])
	int_ptr_before = sum(1 for p, _ in a["c_fns"].values() if "&int" in p) + sum(1 for _, r in a["c_fns"].values() if "&int" in r)
	int_ptr_after = sum(1 for p, _ in b["c_fns"].values() if "&int" in p) + sum(1 for _, r in b["c_fns"].values() if "&int" in r)
	i32_after = sum(1 for p, _ in b["c_fns"].values() if "&i32" in p) + sum(1 for _, r in b["c_fns"].values() if "&i32" in r)
	print(f"{'kind':50} {'added':>6} {'removed':>8} {'changed':>8}")
	for label, x, y, z in rows:
		print(f"{label:50} {x:6} {y:8} {z:8}")
	print(f"\nfn C. lines with an `&int` before: {int_ptr_before}, after: {int_ptr_after}; with `&i32` after: {i32_after}")
	print("removed wrappers:", " ".join(cr))
	print("added wrappers:", " ".join(ca))
	print("renamed struct members:")
	for s, g, c in renamed:
		print(f"  {s}.{g} -> {c}")


main()
