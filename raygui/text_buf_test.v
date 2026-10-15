module main

import raygui

fn test_text_buf_keeps_terminator_when_truncating() {
	buf := raygui.text_buf('abcdef', 4)
	assert buf == [u8(`a`), `b`, `c`, 0]
	assert raygui.text_buf_str(buf) == 'abc'
}

fn test_text_buf_zero_fills_tail() {
	buf := raygui.text_buf('1.5', raygui.value_box_float_buf_len)
	assert buf.len == raygui.value_box_float_buf_len
	assert buf[3..].all(it == 0)
}

fn test_text_buf_str_stops_at_buffer_end_without_terminator() {
	assert raygui.text_buf_str([u8(`h`), `i`]) == 'hi'
}
