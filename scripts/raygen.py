import os
import urllib.request
import json
import re
import sys


pascal_to_snake_re = re.compile(r'(?<!^)(?=[A-Z])')

# Functions with all-caps parts ("FPS", for example) become f_p_s normally, so
# we prevent that by handling each "special case" that occurs in the Raylib API
pascal_to_snake_special_cases = {
	"UTF8":   "_utf8",
	"FPS":    "_fps",
	"DPI":    "_dpi",
	"2D":     "_2d",
	"3D":     "_3d",
	"URL":    "_url",
	"CRC32":  "_crc32",
	"MD5":    "_md5",
	"SHA1":   "_sha1",
	"POT":    "_pot",
	"NN":     "_nn",
	"CW":     "_cw",
	"CCW":    "_ccw",
	"NPatch": "_npatch",
	"HSV":    "_hsv"
}

varaidic_type_translations = {
	"trace_log": "...TraceLogLevel",
	"text_format": "...any"
}

c_to_v_types = {
	"void": "",
	"char": "u8",
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
	"float16": "Float16"
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
	]
}

ignored_aliases = {
	"raymath": [
		"Quaternion",
	]
}

renamed_structs = {
	"raymath": {
		"float3": "Float3",
		"float16": "Float16"
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
	"raygui": "import raylib { Color, Font, Rectangle, Vector2, Vector3 }\n"
}


def pascal_to_snake(pascal: str) -> str:
	for k, v in pascal_to_snake_special_cases.items():
		pascal = pascal.replace(k, v)
	return pascal_to_snake_re.sub('_', pascal).lower()

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

		data = None
		with open(json_path, "r") as json_fp:
			data = json.load(json_fp)
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
				fp.write(f"\t{pascal_to_snake(field["name"])} {c_type_to_v_type(field["type"])}\n")
			fp.write('}\n\n')

		# Translate aliases
		for alias in data.get("aliases", []):
			if alias["description"] != "":
				fp.write(f"// {alias["description"]}\n")
			fp.write(f"pub type {alias["name"]} = C.{alias["type"]}\n")

		# Translate callbacks
		for callback in data.get("callbacks", []):
			params = callback.get("params", [])

			has_params = len(params) > 0
			for param in params:
				param["type"] = c_type_to_v_type(param["type"])
				param["name"] = pascal_to_snake(param["name"])

			c_args = "" if not has_params else ", ".join([p["type"] for p in params])

			if callback["description"] != "":
				fp.write(f"// {callback["description"]}\n")
			fp.write(f"pub type {callback["name"]} = fn ({c_args}) {c_type_to_v_type(callback["returnType"])}\n\n")

		# Translate enums
		for enum in data.get("enums", []):
			if enum["description"] != "":
				fp.write(f"// {enum["description"]}\n")
			fp.write(f"pub enum {enum["name"]} {{\n")
			for value in enum["values"]:
				fp.write(f"\t{value["name"].lower()} = {value["value"]}")
				if value["description"] != "":
					fp.write(f"// {value["description"]}\n")
			fp.write("}\n")

		# Bind functions
		for function in data.get("functions", []):
			c_name = function["name"]
			v_name = pascal_to_snake(function["name"])
			c_return_type = c_type_to_v_type(function["returnType"])
			v_return_type = c_type_to_v_type(function["returnType"])
			comment = function["description"]

			params = function.get("params", [])
			has_params = len(params) > 0
			for param in params:
				param["type"] = c_type_to_v_type(param["type"], v_name)
				param["name"] = pascal_to_snake(param["name"])

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
				if arg["type"] == "&u8":
					call_args[index] = f"{arg["name"]}.str"
					decl_args[index] = decl_args[index].replace("&u8", "string")

			c_args = ", ".join(c_args)
			decl_args = ", ".join(decl_args)
			call_args = ", ".join(call_args)

			if c_return_type == "&u8":
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
	os.system(f"v -w fmt {path}")

if __name__ == "__main__":
	# Generate our Raylib, Raymath, and Raygui bindings
	generate("raylib.c.v", "external/raylib/parser/raylib_api.json", "raylib")
	generate("raymath/raymath.c.v", "external/raylib/parser/raymath_api.json", "raymath")
	generate("raygui/raygui.c.v", "external/raylib/parser/raygui_api.json", "raygui")

	# Raygui and Raymath are not distributed as a package like Raylib is.
	# To use the libraries, we must redistribute their headers.
	os.system("cp external/raygui/src/raygui.h raygui/raygui.h")
	os.system("cp external/raylib/src/raymath.h raymath/raymath.h")
	# We will also copy the licenses to the raygui/ and raymath/ directory
	# since we include a source distribution of them.
	os.system("cp external/raygui/LICENSE raygui/raygui-license")
	os.system("cp external/raylib/LICENSE raymath/raymath-license")
