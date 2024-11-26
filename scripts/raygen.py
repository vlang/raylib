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
	"va_list": "C.va_list",
	"rAudioBuffer": "AudioBuffer",
	"rAudioProcessor": "AudioProcessor",
	"ma_context": "C.ma_context",
	"ma_device": "C.ma_device",
	"ma_mutex": "C.ma_mutex",
	"size_t": "C.size_t",
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

def generate(path: str, json_path: str, lib: str, include: str):
	if not os.path.exists(json_path):
		raise RuntimeError(f"{json_path} does not exist. You can generate it with scripts/jsongen.py")

	folder = "/".join(path.split("/")[:-1])
	if folder != "":
		os.makedirs(folder, exist_ok = True)

	raylib_module = path.removesuffix(".c.v")

	# Parse JSON file and generate raylib.c.v
	with open(path, "w+") as fp:
		fp.write(f"module {lib}\n\n#flag -l{include}\n#include <{include}.h>\n\n")

		data = None
		with open(json_path, "r") as json_fp:
			data = json.load(json_fp)
		if data is None:
			raise RuntimeError(f"Failed to load {json_path}")

		# One of the callbacks uses va_list as a type, so we need to make a
		# binding for it manually.
		fp.write("@[typedef] struct C.va_list {}")

		# Translate structs
		for struct in data.get("structs", []):
			name = struct["name"]
			fields = struct["fields"]

			fp.write(f"pub type {name} = C.{name}\n")
			if struct["description"] != "":
				fp.write(f"// {struct["description"]}\n")
			fp.write(f"struct C.{name} {{\n")
			for field in fields:
				fp.write(f"\t// {field["description"]}\n")
				fp.write(f"\t{field["name"]} {c_type_to_v_type(field["type"])}\n")
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
	# Generate our Raylib bindings
	generate("raylib.c.v", "raylib/parser/raylib_api.json", "raylib", "raylib")
	generate("raymath/raymath.c.v", "raylib/parser/raymath_api.json", "raymath", "raymath")
