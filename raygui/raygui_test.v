module main

import raylib
import raygui
import raymath

fn test_raygui() {
	raylib.init_window(800, 600, 'Raygui Example')
	raylib.set_target_fps(60)

	mut show_message_box := false
	mut value := 0

	for !raylib.window_should_close() {
		raylib.begin_drawing()
		raylib.clear_background(raylib.raywhite)

		if raygui.gui_button(raylib.Rectangle{ 24, 24, 120, 30 }, "#191#Show Message") > 0 {
			show_message_box = true
		} else if raygui.gui_button(raylib.Rectangle{ 24, 62, 120, 30 }, "++") > 0 {
			value = int(raymath.clamp(value + 1, 0, 10))
		} else if raygui.gui_button(raylib.Rectangle{ 24, 92, 120, 30 }, "--") > 0 {
			value = int(raymath.clamp(value - 1, 0, 10))
		}

		// raygui.gui_label(raylib.Rectangle{ 24, 100, 120, 30 }, value.str())
		raylib.draw_text(value.str(), 24, 130, 20, raylib.blue)

		if show_message_box {
			result := raygui.gui_message_box(raylib.Rectangle{ 85, 70, 250, 100 }, "#191#Message Box", "Hi! This is a message!", "Nice;Cool")

			if result >= 0 {
				show_message_box = false
			}
		}

		raylib.end_drawing()
	}

	raylib.close_window()
}
