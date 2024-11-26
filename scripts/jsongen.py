# This script will clone Raylib on a specific commit, then use Raylib's parser
# to generate JSON files for the Raylib and Raymath APIs.

import os

RAYLIB_VERSION = 'c1ab645' # Latest version of v5.5

os.system(f"git clone https://github.com/raysan5/raylib &&\
	cd raylib &&\
	git reset --hard {RAYLIB_VERSION}")

os.system("cd raylib/parser && make raylib_parser")
os.system("cd raylib/parser && ./raylib_parser -i ../src/raylib.h -o raylib_api.json -f JSON")
os.system("cd raylib/parser && ./raylib_parser -i ../src/raymath.h -o raymath_api.json -f JSON")
