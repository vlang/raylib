module raygui

import raylib { Rectangle }

#flag -I @VMODROOT/raygui/
#define RAYGUI_IMPLEMENTATION
#include "raygui.h"

// Minimum buffer size for gui_value_box_float: RAYGUI_VALUEBOX_MAX_CHARS (32) plus the terminator.
pub const value_box_float_buf_len = 33

// text_buf returns a zero-filled, writable buffer of `size` bytes holding `text`,
// truncated (by bytes) if needed so the terminator still fits.
pub fn text_buf(text string, size int) []u8 {
	assert size > 0
	mut buf := []u8{len: size}
	n := if text.len < size { text.len } else { size - 1 }
	copy(mut buf, text[..n].bytes())
	return buf
}

// text_buf_str returns a copy of the text in `buf`, up to its first NUL.
pub fn text_buf_str(buf []u8) string {
	end := buf.index(0)
	return buf[..if end < 0 { buf.len } else { end }].bytestr()
}

// gui_text_box_buf is gui_text_box with the whole of `buf` as the text buffer.
pub fn gui_text_box_buf(bounds Rectangle, mut buf []u8, edit_mode bool) int {
	assert u8(0) in buf
	return gui_text_box(bounds, &u8(buf.data), buf.len, edit_mode)
}

// gui_text_input_box_buf is gui_text_input_box with the whole of `buf` as the text buffer.
pub fn gui_text_input_box_buf(bounds Rectangle, title string, message string, buttons string, mut buf []u8, secret_view_active &bool) int {
	assert u8(0) in buf
	return gui_text_input_box(bounds, title, message, buttons, &u8(buf.data), buf.len,
		secret_view_active)
}

// gui_value_box_float_buf is gui_value_box_float with `buf` as the text buffer.
// raygui appends without re-terminating and the bytes after the text must stay zero;
// buffers from text_buf satisfy that and raygui keeps it true while editing.
pub fn gui_value_box_float_buf(bounds Rectangle, text string, mut buf []u8, value &f32, edit_mode bool) int {
	assert buf.len >= value_box_float_buf_len
	assert u8(0) in buf
	return gui_value_box_float(bounds, text, &u8(buf.data), value, edit_mode)
}
