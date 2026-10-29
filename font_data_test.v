module main

import os
import raylib

// vlang/raylib#34: a C `int *` is a pointer to 4-byte slots. The binding declared it `&int`, and on
// V master `int` is 8 bytes, so a `[]int` handed to raylib arrived interleaved with zeros: every
// glyph past the first was the wrong codepoint (and drawn as `?`). Pointers to C ints are `&i32`.
//
// `LoadFontData` needs no window or GL context, only a TrueType file: set RAYLIB_TEST_FONT to one,
// or the test uses the first of the usual system fonts it finds.

fn find_test_font() ?string {
	env := os.getenv('RAYLIB_TEST_FONT')
	candidates := [
		env,
		'/usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf',
		'/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',
		'/usr/share/fonts/TTF/DejaVuSans.ttf',
		'/Library/Fonts/Arial.ttf',
		'/System/Library/Fonts/Supplemental/Arial.ttf',
		'C:/Windows/Fonts/arial.ttf',
	]
	for path in candidates {
		if path != '' && os.is_file(path) {
			return path
		}
	}
	return none
}

fn test_load_font_data_gets_every_codepoint() {
	path := find_test_font() or {
		eprintln('skipped: no TrueType font found; set RAYLIB_TEST_FONT')
		return
	}
	bytes := os.read_bytes(path)!
	// A string with letters past `Q`: the ones the #34 repro lost.
	codepoints := 'AQRWaz?'.runes().map(i32(it))
	mut glyph_count := i32(-1)
	glyphs := raylib.load_font_data(bytes.data, bytes.len, 32, codepoints.data, codepoints.len,
		0, &glyph_count)
	assert !isnil(glyphs)
	// raylib 6.0 reports the number of glyphs through the seventh parameter, an `int *`.
	assert glyph_count == codepoints.len
	for i, codepoint in codepoints {
		glyph := unsafe { glyphs[i] }
		assert glyph.value == codepoint, 'glyph ${i}: got ${glyph.value}, want ${codepoint}'
	}
	raylib.unload_font_data(glyphs, int(glyph_count))
}

fn test_load_codepoints_returns_a_c_int_array() {
	mut count := i32(-1)
	codepoints := raylib.load_codepoints('Rwaz', &count)
	assert count == 4
	got := [unsafe { codepoints[0] }, unsafe { codepoints[1] }, unsafe { codepoints[2] },
		unsafe { codepoints[3] }]
	assert got == 'Rwaz'.runes().map(i32(it))
	raylib.unload_codepoints(codepoints)
}
