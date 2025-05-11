import raylib { Color, begin_drawing, clear_background, close_window, draw_text, end_drawing, init_window, set_target_fps, window_should_close }

const screen_width = 800
const screen_height = 600
const white = Color{255, 255, 255, 255}
const blue = Color{0, 0, 200, 255}

init_window(screen_width, screen_height, 'Example of using V and Raylib together')
set_target_fps(60)
for !window_should_close() {
	begin_drawing()
	clear_background(white)
	draw_text('Hello from V and Raylib.', 160, 270, 40, blue)
	end_drawing()
}
close_window()
