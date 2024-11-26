# This script will clone Raylib on a specific commit, then use Raylib's parser
# to generate JSON files for the Raylib and Raymath APIs.

import os

RAYLIB_VERSION = "c1ab645" # Latest version of v5.5
RAYGUI_VERSION = "1e03efc" # Latest version as of Sep 24, 2024

if not os.path.exists("external"):
	os.mkdir("external")

if not os.path.exists("external/raylib"):
	os.system(f"git clone https://github.com/raysan5/raylib external/raylib &&\
		cd raylib &&\
		git reset --hard {RAYLIB_VERSION}")

if not os.path.exists("external/raygui"):
	os.system(f"git clone https://github.com/raysan5/raygui external/raygui &&\
		cd raygui &&\
		git reset --hard {RAYGUI_VERSION}")

os.system("cd external/raylib/parser && make clean raylib_parser")
os.system("cd external/raylib/parser && ./raylib_parser -i ../src/raylib.h -o raylib_api.json -f JSON -d RLAPI")
os.system("cd external/raylib/parser && ./raylib_parser -i ../src/raymath.h -o raymath_api.json -f JSON -d RMAPI")
os.system("cd external/raylib/parser && ./raylib_parser -i ../../raygui/src/raygui.h -o raygui_api.json -f JSON -d RAYGUIAPI -t \"RAYGUI IMPLEMENTATION\"")
