module main

import raylib

fn test_raylib() {
	raylib.set_config_flags(raylib.ConfigFlags.flag_window_resizable)
	raylib.init_window(800, 600, 'Hello, World!')
	raylib.set_target_fps(30)

	for !raylib.window_should_close() {
		raylib.begin_drawing()
		raylib.clear_background(raylib.white)
		raylib.draw_fps(raylib.get_screen_width() / 2, raylib.get_screen_height() / 2)
		raylib.end_drawing()
	}

	raylib.close_window()
}

