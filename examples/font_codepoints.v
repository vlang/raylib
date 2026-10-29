// vlang/raylib#34: loads a font with an explicit list of codepoints under a hidden window and
// checks that every glyph asked for is in the font. With `&int` codepoints on V master (8-byte
// `int`) raylib saw the list interleaved with zeros and every letter past `Q` was missing.
//
//   v run examples/font_codepoints.v [path/to/font.ttf]
//
// A window (and an OpenGL context) is needed to load a font as a texture; it stays hidden.
import os
import raylib

fn main() {
	font_path := if os.args.len > 1 {
		os.args[1]
	} else {
		'/usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf'
	}
	text := 'Hello, RAYLIB! QRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'

	// `LoadFontEx` reads a C `int *`: the list is an `[]i32`.
	mut codepoints := []i32{}
	for r in text.runes() {
		codepoints << i32(r)
	}

	raylib.set_config_flags(raylib.ConfigFlags.flag_window_hidden)
	raylib.init_window(64, 64, 'font codepoints')
	defer {
		raylib.close_window()
	}
	font := raylib.load_font_ex(font_path, 32, codepoints.data, codepoints.len)
	defer {
		raylib.unload_font(font)
	}

	mut missing := []string{}
	for r in text.runes() {
		info := raylib.get_glyph_info(font, int(r))
		if info.value != int(r) {
			missing << r.str()
		}
	}
	println('glyphs loaded: ${font.glyphCount}')
	if missing.len > 0 {
		println('MISSING: ${missing.join(' ')}')
		exit(1)
	}
	println('OK: every codepoint of the text is in the font')
}
