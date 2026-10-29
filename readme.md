# Raylib for V

> Up-to-date, auto-generated Raylib (and Raymath) bindings for V

Current Raylib Target: v6.0

Needs V 0.5.2 or a V master of 2026 or later: both are tested. On V master `int` is 8 bytes on 64-bit
targets, which this binding accounts for (see below). Raylib 6.0 itself is not bundled: install it
and its headers where the C compiler finds them.

## Installation

`v install raylib`

## Usage

Barring a small handful of differences, it is the exact same as Raylib's C API.

Differences:
- Functions and parameters are renamed from `PascalCase` to `snake_case`
- The members of C structs keep raylib.h's spelling: `font.glyphCount`, `mesh.vertexCount`,
  `event.@type` (`type` is a V keyword)
- A C `int *` is an `&i32`, an `unsigned int *` an `&u32`: V's `int` is 8 bytes on 64-bit targets, a
  C `int` is not, so pass an `[]i32`'s `.data`, or the address of an `i32` for an out parameter
  (`load_font_ex(path, 32, codepoints.data, codepoints.len)` with `codepoints := []i32{}`).
  A plain `int` argument or return value stays `int`: the C prototype converts it.
- Colours are V constants, not as macros
- Any function that uses or returns a C-string instead uses a V-string

## Why?

There are already a handful of V Raylib bindings, but they almost all are out-of-date or
are poorly maintained. For that reason, I decided to do it myself.

I also wanted to have documentation comments in the bindings, which is not provided by
many Raylib bindings in general as far as I know.

## License

The Raylib headers are licensed under their respective licenses, which is Zlib.

Everything else is dual-licensed under MIT and the Unlicense, use whichever works best
for you! :D

## Regenerating

`raylib.c.v`, `raymath/raymath.c.v` and `raygui/raygui.c.v` are generated from raylib's header parser:

    python3 scripts/jsongen.py                   # clones raylib 6.0, builds tools/rlparser, writes external/json
    V=./v python3 scripts/raygen.py --json-dir external/json
    python3 scripts/check_prototypes.py raylib.c.v external/raylib/src/raylib.h RLAPI
    python3 scripts/check_struct_fields.py raylib.c.v external/raylib/src/raylib.h

`check_prototypes.py` reads the header text itself and exits non-zero when an `fn C.` line disagrees
with its C prototype.

## Changes in 6.0

- Removed (gone from raylib 6.0): `draw_model_points`, `draw_model_points_ex`, `unload_model_animation`,
  `update_model_animation_bones`.
- Changed: `draw_circle_gradient(center, radius, inner, outer)` takes a `Vector2`;
  `update_model_animation`'s frame is an `f32`; `load_font_data` has a seventh parameter, `glyph_count &i32`.
- Renamed: 41 members of 10 C structs now have raylib.h's spelling (`Font.glyph_count` is `Font.glyphCount`).
- Pointer parameters and returns that were `&int` are `&i32`.
