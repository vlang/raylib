import argparse
import os
import json
import re
import sys


def load_api_json(path: str):
	"""Load an rlparser JSON file. rlparser 6.0 does not escape double quotes inside
	descriptions (LoadDirectoryFilesEx, for one), so they are escaped here first."""
	with open(path, "r") as fp:
		text = fp.read()
	rx = re.compile(r'^(\s*"(?:description|value|type|defaultValue)": ")(.*)("\s*,?\s*)$')
	lines = []
	for line in text.split("\n"):
		m = rx.match(line)
		if m:
			line = m.group(1) + re.sub(r'(?<!\\)"', '\\\\"', m.group(2)) + m.group(3)
		lines.append(line)
	return json.loads("\n".join(lines))


translate_identifier_re = re.compile(r'(?<!^)(?=[A-Z])')

# Functions with all-caps parts ("FPS", for example) become f_p_s normally, so
# we prevent that by handling each "special case" that occurs in the Raylib API
translate_identifier_special_cases = {
	"UTF8":   "_utf8",
	"FPS":    "_fps",
	"DPI":    "_dpi",
	"2D":     "_2d",
	"3D":     "_3d",
	"URL":    "_url",
	"CRC32":  "_crc32",
	"MD5":    "_md5",
	"SHA1":   "_sha1",
	"SHA256": "_sha256",
	"POT":    "_pot",
	"NN":     "_nn",
	"CW":     "_cw",
	"CCW":    "_ccw",
	"NPatch": "_npatch",
	"HSV":    "_hsv",
}

# What a pointer to one of these C types points at. V's `int` is 8 bytes on 64-bit targets, so
# `&int` would hand C a pointer to 8-byte slots (vlang/raylib#34). A scalar `int` argument stays
# `int`: the C prototype converts it.
pointee_c_to_v_types = {
	"int": "i32",
	"unsigned int": "u32",
	"short": "i16",
	"unsigned short": "u16",
	"long": "i64",
}

# C calls these callbacks with C values. A V function with an `int` parameter expects 64 bits and
# V master refuses to pass it, so a callback's `int` is an `i32`.
callback_c_to_v_types = {
	"int": "i32",
	"unsigned int": "u32",
}

varaidic_type_translations = {
	"trace_log": "...TraceLogLevel",
	"text_format": "...any",
}

c_to_v_types = {
	"void": "",
	# "char": "u8",
	"float": "f32",
	"double": "f64",
	"unsigned int": "u32",
	"unsigned short": "u16",
	"unsigned char": "u8",
	"long": "i64",
	"size_t": "C.size_t",
	# Used by a trace log callback in raylib.h
	"va_list": "C.va_list",
	# Used in raylib.h to refer to raudio things
	"rAudioBuffer": "AudioBuffer",
	"rAudioProcessor": "AudioProcessor",
	"ma_context": "C.ma_context",
	"ma_device": "C.ma_device",
	"ma_mutex": "C.ma_mutex",
	# From raymath.h
	"float3": "Float3",
	"float16": "Float16",
}

# See the comment rant for `module_imports`. All of that applies here too.
ignored_structs = {
	"raymath": [
		"Vector2",
		"Vector3",
		"Vector4",
		"Matrix",
	],
	"raygui": [
		"Vector2",
		"Vector3",
		"Color",
		"Rectangle",
		"Texture2D",
		"Image",
		"GlyphInfo",
		"Font",
	],
}

ignored_aliases = {
	"raymath": [
		"Quaternion",
	],
}

renamed_structs = {
	"raymath": {
		"float3": "Float3",
		"float16": "Float16",
	},
}

renamed_identifiers = {
	"type": "typ",
	"Type": "typ",
}

enum_types = {
	"raylib": {
		"ConfigFlags": "u32",
		"Gesture": "u32",
	}
}

flag_enums = {
	"raylib": [ "ConfigFlags", "Gesture" ]
}

# Raylib uses integer types for its enum arguments, so we will convert those to
# enum types for ease-of-use in V.
functions_with_enum_args = {
	"raylib": {
		"SetConfigFlags": { "flags": "ConfigFlags" },
		"IsWindowState": { "flag": "ConfigFlags" },
		"SetWindowState": { "flags": "ConfigFlags" },
		"ClearWindowState": { "flags": "ConfigFlags" },
		"SetGesturesEnabled": { "flags": "Gesture" },
	}
}

# Some modules depend on other modules, as expected. However Raylib's likes to
# give all of its modules a "standalone" mode, which allows it to be compiled
# without raylib.h being present. It does this by redefining the structs and
# functions that it uses. This ends up getting clogged in our raylib_parser
# JSONs, which we do not want. To fix this, we ignore the functions/structs/etc
# from the generated bindings, but then we also need to import them from raylib
# so that we can actually use them in the bindings.
#
# This variable stores those needed imports (and whatever other needed
# boilerplate) on a per-module basis.
#
# (Rant over)
module_boilerplates = {
	"raymath": "import raylib { Vector2, Vector3, Vector4, Matrix }\n",
	"raygui": "import raylib { Color, Font, Rectangle, Vector2, Vector3 }\n",
}


def translate_identifier(pascal: str) -> str:
	if pascal in renamed_identifiers:
		return renamed_identifiers[pascal]
	for k, v in translate_identifier_special_cases.items():
		pascal = pascal.replace(k, v)
	return translate_identifier_re.sub('_', pascal).lower()

v_keywords = {
	"as", "asm", "assert", "atomic", "break", "const", "continue", "defer", "else", "enum", "false",
	"fn", "for", "go", "goto", "if", "implements", "import", "in", "interface", "is", "isreftype",
	"lock", "match", "module", "mut", "none", "or", "pub", "return", "rlock", "select", "shared",
	"sizeof", "static", "struct", "true", "type", "typeof", "union", "unsafe", "volatile",
	"__global", "__offsetof",
}

def struct_field_name(c_name: str) -> str:
	# `type` is a V keyword; `@type` names the C member `type`.
	return "@" + c_name if c_name in v_keywords else c_name

def c_type_to_v_type(c_type: str, method_name: str = None) -> str:
	# Varaidic args are a pain because C does not declare types for them,
	# meaning we need to handle them manually based on the method's name.
	# Luckily, there are only **2** methods in the entire API that use
	# varaidic arguments!
	if c_type == "...":
		return varaidic_type_translations[method_name]
	# We handle void here because it can be ambigious between no/ return
	# value or a void pointer.
	elif c_type == "void *" or c_type == "const void *":
		return "voidptr"

	# The final annoying thing we have to deal with are fixed-size array
	# types.
	sizes = []
	if "[" in c_type:
		dimensions = c_type.count("[")
		sizes = c_type.replace("]", "").split("[")[1:]
		c_type = c_type.split("[")[0]

	pointers = c_type.count("*")
	c_type = c_type.removeprefix("const ").replace("*", "").strip()
	# C reads and writes the pointee, and the elements of an array member, with C's own width:
	# `int *` is `&i32` and `int params[4]` is `[4]i32`, not `&int` and `[4]int`.
	if (pointers > 0 or len(sizes) > 0) and c_type in pointee_c_to_v_types:
		c_type = pointee_c_to_v_types[c_type]
	else:
		c_type = c_to_v_types.get(c_type, c_type)
	c_type = ("&" * pointers) + c_type
	c_type = c_type.strip()

	# If we are an array, we will add that to the V type
	if len(sizes) > 0:
		c_type = "".join([f"[{s}]" for s in sizes]) + c_type

	return c_type

def generate(path: str, json_path: str, lib: str):
	if not os.path.exists(json_path):
		raise RuntimeError(f"{json_path} does not exist. You can generate it with scripts/jsongen.py")

	folder = "/".join(path.split("/")[:-1])
	if folder != "":
		os.makedirs(folder, exist_ok = True)

	raylib_module = path.split("/")[-1].removesuffix(".c.v")

	# Parse JSON file and generate raylib.c.v
	with open(path, "w+") as fp:
		fp.write(f"module {lib}\n")

		if raylib_module in module_boilerplates:
			fp.write(module_boilerplates[raylib_module])

		data = load_api_json(json_path)
		if data is None:
			raise RuntimeError(f"Failed to load {json_path}")

		# Translate structs
		for struct in data.get("structs", []):
			c_name = struct["name"]

			if raylib_module in ignored_structs and c_name in ignored_structs[raylib_module]:
				continue

			v_name = struct["name"]
			if raylib_module in renamed_structs and c_name in renamed_structs[raylib_module]:
				v_name = renamed_structs[raylib_module][c_name]

			fields = struct["fields"]

			fp.write(f"pub type {v_name} = C.{c_name}\n")
			if struct["description"] != "":
				fp.write(f"// {struct["description"]}\n")
			fp.write(f"pub struct C.{c_name} {{\n")
			for field in fields:
				if field["description"] != "":
					fp.write(f"\t// {field["description"]}\n")
				# A C struct's members keep raylib.h's spelling (vlang/raylib#32): V reads
				# `mesh.triangleCount` as the C member `triangleCount`. A snake_case name
				# would be a different C member and fail in the C compiler.
				fp.write(f"\t{struct_field_name(field["name"])} {c_type_to_v_type(field["type"])}\n")
			fp.write('}\n\n')

		# Translate aliases
		for alias in data.get("aliases", []):
			if alias["description"] != "":
				fp.write(f"// {alias["description"]}\n")
			if alias["name"].startswith("*"):
				# `typedef Transform *ModelAnimPose;` (raylib 6.0): rlparser keeps the `*` in the name.
				fp.write(f"pub type {alias["name"].removeprefix("*")} = &C.{alias["type"]}\n")
			else:
				fp.write(f"pub type {alias["name"]} = C.{alias["type"]}\n")

		# Translate callbacks
		for callback in data.get("callbacks", []):
			params = callback.get("params", [])

			has_params = len(params) > 0
			for param in params:
				param["type"] = c_type_to_v_type(param["type"])
				param["type"] = callback_c_to_v_types.get(param["type"], param["type"])
				param["name"] = translate_identifier(param["name"])

			c_args = "" if not has_params else ", ".join([p["type"] for p in params])

			callback_return = c_type_to_v_type(callback["returnType"])
			callback_return = callback_c_to_v_types.get(callback_return, callback_return)

			if callback["description"] != "":
				fp.write(f"// {callback["description"]}\n")
			fp.write(f"pub type {callback["name"]} = fn ({c_args}) {callback_return}\n\n")

		# Translate enums
		for enum in data.get("enums", []):
			is_flag_enum = raylib_module in flag_enums and enum["name"] in flag_enums[raylib_module]

			if enum["description"] != "":
				fp.write(f"// {enum["description"]}\n")
			if is_flag_enum:
				fp.write("@[flag]\n")
			fp.write(f"pub enum {enum["name"]}")
			if raylib_module in enum_types and enum["name"] in enum_types[raylib_module]:
				fp.write(f" as {enum_types[raylib_module][enum["name"]]}")
			fp.write(" {\n")
			if is_flag_enum:
				# A V `@[flag]` enum gives its n-th member the value 1 << n, whatever the C header
				# says. So the members go in bit order, a bit raylib.h does not use gets a
				# placeholder, and a zero member (GESTURE_NONE) is left out: its value is "no flag".
				by_bit = {}
				for value in enum["values"]:
					number = int(value["value"])
					if number == 0:
						continue
					if number & (number - 1) != 0:
						raise RuntimeError(f"{enum["name"]}.{value["name"]} = {number} is not a single bit")
					by_bit[number.bit_length() - 1] = value
				prefix = next(iter(by_bit.values()))["name"].lower().split("_")[0]
				for bit in range(max(by_bit) + 1):
					if bit not in by_bit:
						fp.write(f"\t{prefix}_unused_{1 << bit} // 0x{1 << bit:08x}\n")
						continue
					value = by_bit[bit]
					comment = value["description"]
					comment = (comment + ", " if comment != "" else "") + f"0x{1 << bit:08x}"
					fp.write(f"\t{value["name"].lower()} // {comment}\n")
			else:
				for value in enum["values"]:
					fp.write(f"\t{value["name"].lower()} = {value["value"]}")
					if value["description"] != "":
						fp.write(f" // {value["description"]}")
					fp.write("\n")
			fp.write("}\n")

		# Bind functions
		for function in data.get("functions", []):
			c_name = function["name"]
			v_name = translate_identifier(function["name"])
			c_return_type = c_type_to_v_type(function["returnType"])
			v_return_type = c_type_to_v_type(function["returnType"])
			comment = function["description"]

			params = function.get("params", [])
			has_params = len(params) > 0
			for param in params:
				# If this arg represents an enum flag, then we
				# should use that instead of an int type. We
				# handle them here because we need more info
				# than is provided to the c_type_to_v_type
				# function.
				if (
					raylib_module in functions_with_enum_args and
					c_name in functions_with_enum_args[raylib_module] and
					param["name"] in functions_with_enum_args[raylib_module][c_name]
				):
					param["type"] = functions_with_enum_args[raylib_module][c_name][param["name"]]
				else:
					param["type"] = c_type_to_v_type(param["type"], v_name)

				param["name"] = translate_identifier(param["name"])

			c_args = [p["type"] for p in params]
			decl_args = [f"{p["name"]} {p["type"]}" for p in params]

			call_args = []
			if has_params:
				call_args = params
				# If our function has a varaidic argument, we need to
				# specify that when calling the C function
				for arg in call_args:
					if arg["type"].startswith("..."):
						arg["name"] = "..." + arg["name"]
				call_args = [arg["name"] for arg in call_args]

			# Convert C-string arguments to V-strings to make the DX better :D
			for index, arg in enumerate(params):
				if arg["type"] == "&char":
					call_args[index] = f"{arg["name"]}.str"
					decl_args[index] = decl_args[index].replace("&char", "string")

			c_args = ", ".join(c_args)
			decl_args = ", ".join(decl_args)
			call_args = ", ".join(call_args)

			if c_return_type == "&char":
				v_return_type = "string"

			# Now we write the binding to the file
			fp.write(f"fn C.{c_name}({c_args}) {c_return_type}\n")
			if comment != "":
				fp.write(f"// {comment}\n")
			fp.write(f"@[inline] pub fn {v_name}({decl_args}) {v_return_type} {{\n")
			if v_return_type == "string":
				fp.write("\tunsafe {")
				fp.write(f"\t\treturn C.{c_name}({call_args}).vstring()")
				fp.write("\t}")
			elif v_return_type != "":
				fp.write(f"\treturn C.{c_name}({call_args})\n")
			else:
				fp.write(f"\tC.{c_name}({call_args})\n")
			fp.write('}\n')

	# Run v fmt
	os.system(f"{V_EXE} fmt -w {path}")

V_EXE = os.environ.get("V", "v")

if __name__ == "__main__":
	parser = argparse.ArgumentParser(description="Generate the raylib, raymath and raygui V bindings from rlparser JSON.")
	parser.add_argument("--json-dir", default="external/raylib/parser",
		help="directory with raylib_api.json, raymath_api.json and raygui_api.json (see scripts/jsongen.py)")
	parser.add_argument("--out-dir", default=".", help="repository root to write raylib.c.v, raymath/ and raygui/ into")
	parser.add_argument("--only", choices=["raylib", "raymath", "raygui"], action="append",
		help="generate only these modules (default: all three)")
	args = parser.parse_args()
	only = args.only or ["raylib", "raymath", "raygui"]

	# Generate our Raylib, Raymath, and Raygui bindings
	if "raylib" in only:
		generate(os.path.join(args.out_dir, "raylib.c.v"), os.path.join(args.json_dir, "raylib_api.json"), "raylib")
	if "raymath" in only:
		generate(os.path.join(args.out_dir, "raymath/raymath.c.v"), os.path.join(args.json_dir, "raymath_api.json"), "raymath")
	if "raygui" in only:
		generate(os.path.join(args.out_dir, "raygui/raygui.c.v"), os.path.join(args.json_dir, "raygui_api.json"), "raygui")
