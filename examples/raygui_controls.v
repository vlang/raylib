module main

import raylib
import raygui

const screen_width = 1100
const screen_height = 650

fn rec(x f32, y f32, width f32, height f32) raylib.Rectangle {
	return raylib.Rectangle{x, y, width, height}
}

fn writable_buffer(size int, initial string) []u8 {
	mut buffer := []u8{len: size, init: 0}
	bytes := initial.bytes()
	count := if bytes.len < size - 1 { bytes.len } else { size - 1 }
	for i in 0 .. count {
		buffer[i] = bytes[i]
	}
	return buffer
}

fn buffer_string(buffer []u8) string {
	unsafe {
		return (&u8(buffer.data)).vstring()
	}
}

fn main() {
	raylib.init_window(screen_width, screen_height, 'raygui controls test suite')
	defer {
		raylib.close_window()
	}
	raylib.set_target_fps(60)

	mut dropdown_a := 0
	mut dropdown_b := 0
	mut dropdown_a_edit := false
	mut dropdown_b_edit := false
	mut combo_active := 0
	mut checked := false
	mut spinner_value := 0
	mut spinner_edit := false
	mut int_value := 0
	mut int_value_edit := false

	mut text_box := writable_buffer(64, 'Text box')
	mut text_box_edit := false
	mut float_text := writable_buffer(64, '12.50')
	mut float_value := f32(12.5)
	mut float_edit := false
	mut input_text := writable_buffer(256, '')
	mut secret_view_active := false
	mut show_input_box := false
	mut show_message_box := false

	mut multiline := writable_buffer(1024,
		'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\nThis mutable buffer also exercises GuiTextBox with a large capacity. Edit this text to verify insertion, deletion and wrapping.')
	mut multiline_edit := false

	mut list_scroll := 0
	mut list_active := -1
	mut toggle_group := 0
	mut toggle_slider := 0
	mut color := raylib.red
	mut slider := f32(50)
	mut slider_bar := f32(60)
	mut progress := f32(0.35)
	mut alpha := f32(0.5)
	mut view_scroll := raylib.Vector2{0, 0}
	mut view := raylib.Rectangle{}
	mut mouse_cell := raylib.Vector2{}

	for !raylib.window_should_close() {
		if raylib.is_key_pressed(int(raylib.KeyboardKey.key_escape)) {
			show_message_box = !show_message_box
		}
		if raylib.is_key_pressed(int(raylib.KeyboardKey.key_left)) {
			progress -= 0.1
		}
		if raylib.is_key_pressed(int(raylib.KeyboardKey.key_right)) {
			progress += 0.1
		}
		if progress < 0 {
			progress = 0
		}
		if progress > 1 {
			progress = 1
		}

		raylib.begin_drawing()
		raylib.clear_background(raylib.raywhite)

		if dropdown_a_edit || dropdown_b_edit || show_input_box || show_message_box {
			raygui.gui_lock()
		}

		raygui.gui_group_box(rec(15, 15, 185, 575), 'BASIC CONTROLS')
		if dropdown_a_edit || dropdown_b_edit {
			raygui.gui_unlock()
		}
		if raygui.gui_dropdown_box(rec(30, 45, 155, 30), 'ONE;TWO;THREE', &dropdown_a,
			dropdown_a_edit) != 0 {
			dropdown_a_edit = !dropdown_a_edit
		}
		if raygui.gui_dropdown_box(rec(30, 85, 155, 30), 'ALPHA;BETA;GAMMA;DELTA', &dropdown_b,
			dropdown_b_edit) != 0 {
			dropdown_b_edit = !dropdown_b_edit
		}
		if !(dropdown_a_edit || dropdown_b_edit) && !show_input_box && !show_message_box {
			raygui.gui_unlock()
		}

		raygui.gui_check_box(rec(30, 130, 18, 18), 'CHECK ME', &checked)
		raygui.gui_combo_box(rec(75, 125, 110, 30), 'ZERO;ONE;TWO', &combo_active)
		if raygui.gui_spinner(rec(30, 165, 155, 30), '', &spinner_value, 0, 100, spinner_edit) != 0 {
			spinner_edit = !spinner_edit
		}
		if raygui.gui_value_box(rec(30, 205, 155, 30), '', &int_value, 0, 100, int_value_edit) != 0 {
			int_value_edit = !int_value_edit
		}

		if raygui.gui_text_box(rec(30, 245, 155, 30), &u8(text_box.data), text_box.len - 1,
			text_box_edit) != 0 {
			text_box_edit = !text_box_edit
		}

		if raygui.gui_value_box_float(rec(30, 285, 155, 30), 'float', &u8(float_text.data),
			&float_value, float_edit) != 0 {
			float_edit = !float_edit
		}

		if raygui.gui_button(rec(30, 330, 155, 30), '#6#Open text input') != 0 {
			show_input_box = true
		}
		raygui.gui_label(rec(30, 375, 155, 20), 'text: ${buffer_string(text_box)}')
		raygui.gui_label(rec(30, 400, 155, 20), 'float text: ${buffer_string(float_text)}')
		raygui.gui_label(rec(30, 425, 155, 20), 'float value: ${float_value:.2f}')
		raygui.gui_label(rec(30, 450, 155, 20), 'input: ${buffer_string(input_text)}')

		raygui.gui_group_box(rec(215, 15, 210, 575), 'LISTS / TOGGLES')
		raygui.gui_list_view(rec(230, 45, 180, 180),
			'Charmander;Bulbasaur;#18#Squirtle;Pikachu;Eevee;Pidgey', &list_scroll, &list_active)
		raygui.gui_toggle_group(rec(230, 245, 180, 25), 'ONE\nTWO\nTHREE', &toggle_group)
		raygui.gui_toggle_slider(rec(230, 350, 180, 30), 'ON;OFF', &toggle_slider)
		raygui.gui_panel(rec(230, 405, 180, 120), 'Panel')
		raygui.gui_label(rec(245, 440, 150, 20), 'list active: ${list_active}')
		raygui.gui_label(rec(245, 465, 150, 20), 'toggle: ${toggle_group}')

		raygui.gui_group_box(rec(440, 15, 255, 575), 'COLOR / VALUES')
		raygui.gui_color_picker(rec(460, 45, 200, 190), '', &color)
		raygui.gui_slider(rec(475, 270, 185, 20), 'slider', '${slider:.2f}', &slider, -50, 100)
		raygui.gui_slider_bar(rec(460, 310, 200, 20), '', '${int(slider_bar)}', &slider_bar, 0, 100)
		raygui.gui_progress_bar(rec(460, 350, 200, 20), '', '${int(progress * 100)}%', &progress,
			0, 1)
		raygui.gui_color_bar_alpha(rec(460, 395, 200, 30), '', &alpha)
		raygui.gui_scroll_panel(rec(460, 455, 100, 100), '', rec(460, 455, 280, 700), &view_scroll,
			&view)
		raygui.gui_grid(rec(575, 455, 100, 100), '', 20, 3, &mouse_cell)

		raygui.gui_group_box(rec(710, 15, 375, 575), 'MULTILINE MUTABLE TEXT')
		if raygui.gui_text_box(rec(725, 45, 345, 450), &u8(multiline.data), multiline.len - 1,
			multiline_edit) != 0 {
			multiline_edit = !multiline_edit
		}
		raygui.gui_status_bar(rec(725, 520, 345, 25),
			'bytes: ${buffer_string(multiline).len}/${multiline.len - 1}')

		if show_input_box {
			raygui.gui_unlock()
			raylib.draw_rectangle(0, 0, screen_width, screen_height, raylib.Color{
				r: 245
				g: 245
				b: 245
				a: 220
			})
			result := raygui.gui_text_input_box(rec(410, 245, 280, 160), 'Mutable input',
				'Type text and press OK', 'OK;Cancel', &u8(input_text.data), input_text.len - 1,
				&secret_view_active)
			if result == 1 || result == 2 || result == 0 {
				show_input_box = false
			}
		}
		if show_message_box {
			raygui.gui_unlock()
			raylib.draw_rectangle(0, 0, screen_width, screen_height, raylib.Color{
				r: 245
				g: 245
				b: 245
				a: 220
			})
			result := raygui.gui_message_box(rec(425, 270, 250, 120), 'Message box',
				'ESC toggles this dialog', 'Close')
			if result >= 0 {
				show_message_box = false
			}
		}

		raygui.gui_status_bar(rec(0, screen_height - 25, screen_width, 25),
			'edit text, float and modal input | ESC: message box | arrows: progress')
		raylib.end_drawing()
	}
}
