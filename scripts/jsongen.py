# This script clones raylib and raygui at the versions below, builds raylib's header parser
# (tools/rlparser, called raylib_parser before raylib 6.0) and uses it to write the JSON files
# that scripts/raygen.py turns into the bindings:
#
#   python3 scripts/jsongen.py            # writes external/json/*.json
#   V=/path/to/v python3 scripts/raygen.py --json-dir external/json
#
# RAYLIB_DIR and RAYGUI_DIR point at existing checkouts and skip the clone.

import os
import shutil
import subprocess

RAYLIB_VERSION = "6.0"  # tag
RAYGUI_VERSION = "1e03efc"  # latest as of Sep 24, 2024: the raygui.h bundled in raygui/ (raylib 6.0 does not need a newer one)

root = "external"
json_dir = os.path.join(root, "json")
os.makedirs(json_dir, exist_ok=True)


def checkout(env_name: str, url: str, name: str, ref: str) -> str:
	path = os.environ.get(env_name) or os.path.join(root, name)
	if not os.path.exists(path):
		subprocess.run(["git", "clone", url, path], check=True)
		subprocess.run(["git", "-C", path, "checkout", "--detach", ref], check=True)
	return os.path.abspath(path)


raylib = checkout("RAYLIB_DIR", "https://github.com/raysan5/raylib", "raylib", RAYLIB_VERSION)
raygui = checkout("RAYGUI_DIR", "https://github.com/raysan5/raygui", "raygui", RAYGUI_VERSION)

parser_dir = os.path.join(raylib, "tools", "rlparser")
subprocess.run(["make", "clean", "rlparser"], cwd=parser_dir, check=True)
rlparser = os.path.join(parser_dir, "rlparser")


def parse(header: str, out: str, define: str, truncate: str = ""):
	cmd = [rlparser, "-i", header, "-o", os.path.abspath(os.path.join(json_dir, out)), "-f", "JSON", "-d", define]
	if truncate != "":
		cmd += ["-t", truncate]
	subprocess.run(cmd, check=True)


parse(os.path.join(raylib, "src", "raylib.h"), "raylib_api.json", "RLAPI")
parse(os.path.join(raylib, "src", "raymath.h"), "raymath_api.json", "RMAPI")
parse(os.path.join(raygui, "src", "raygui.h"), "raygui_api.json", "RAYGUIAPI", "RAYGUI IMPLEMENTATION")

# The bindings redistribute the raymath and raygui headers (they are not packaged like raylib).
for src, dst in (
	(os.path.join(raylib, "src", "raymath.h"), "raymath/raymath.h"),
	(os.path.join(raylib, "LICENSE"), "raymath/raymath-license"),
	(os.path.join(raygui, "src", "raygui.h"), "raygui/raygui.h"),
	(os.path.join(raygui, "LICENSE"), "raygui/raygui-license"),
):
	os.makedirs(os.path.dirname(dst), exist_ok=True)
	shutil.copyfile(src, dst)
	print(f"copied {src} -> {dst}")
