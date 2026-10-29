module main

import raylib

// vlang/raylib#33: raylib 6.0 changed signatures that no longer compiled against the 5.5
// declarations (DrawCircleGradient, LoadFontData), changed a parameter type (UpdateModelAnimation's
// frame is a float), added functions and removed four. These tests need no window.

fn test_draw_circle_gradient_takes_a_center_vector() {
	// Assigning to a function value of the expected type is checked at compile time.
	mut gradient := fn (center raylib.Vector2, radius f32, inner raylib.Color, outer raylib.Color) {}
	gradient = raylib.draw_circle_gradient
	_ = gradient
}

fn test_update_model_animation_frame_is_a_float() {
	mut update := fn (model raylib.Model, anim raylib.ModelAnimation, frame f32) {}
	update = raylib.update_model_animation
	_ = update
}

fn test_load_font_data_has_the_glyph_count_parameter() {
	mut load := fn (file_data &u8, data_size int, font_size int, codepoints &i32, codepoint_count int, typ int, glyph_count &i32) &raylib.GlyphInfo {
		return unsafe { nil }
	}
	load = raylib.load_font_data
	_ = load
}

fn test_new_text_functions() {
	assert raylib.text_remove_spaces('a b  c d') == 'abcd'
	assert raylib.get_text_between('name=[value]', '[', ']') == 'value'
	assert raylib.text_replace_between('name=[value]', '[', ']', 'x') == 'name=[x]'
}

fn test_compute_sha256_of_abc() {
	digest := raylib.compute_sha256(c'abc'.vbytes(3).data, 3)
	words := [unsafe { digest[0] }, unsafe { digest[1] }, unsafe { digest[7] }]
	// SHA-256("abc") = ba7816bf 8f01cfea 414140de 5dae2223 b00361a3 96177a9c b410ff61 f20015ad
	assert words == [u32(0xba7816bf), 0x8f01cfea, 0xf20015ad]
}
