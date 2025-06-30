module main

import raylib

fn check(flags raylib.ConfigFlags, expected u32) {
	assert u32(flags) == expected, 'flags: ${flags}, actual: ${u32(flags)}, expected: ${expected}'
}

fn test_config_flags_values() {
	check(.flag_fullscreen_mode, 0x00000002)
	check(.flag_window_resizable, 0x00000004)

	check(.flag_fullscreen_mode, 0x00000002)
	check(.flag_window_resizable, 0x00000004)
	check(.flag_window_undecorated, 0x00000008)
	check(.flag_window_transparent, 0x00000010)
	check(.flag_msaa_4x_hint, 0x00000020)
	check(.flag_vsync_hint, 0x00000040)
	check(.flag_window_hidden, 0x00000080)
	check(.flag_window_always_run, 0x00000100)
	check(.flag_window_minimized, 0x00000200)
	check(.flag_window_maximized, 0x00000400)
	check(.flag_window_unfocused, 0x00000800)
	check(.flag_window_topmost, 0x00001000)
	check(.flag_window_highdpi, 0x00002000)
	check(.flag_window_mouse_passthrough, 0x00004000)
	check(.flag_borderless_windowed_mode, 0x00008000)
	check(.flag_interlaced_hint, 0x00010000)
}
