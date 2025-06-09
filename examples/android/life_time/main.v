module main

import raylib as rl

const screen_width = 800
const screen_height = 600
const white = rl.Color{255, 255, 255, 255}
const blue = rl.Color{0, 0, 200, 255}

@[export: 'android_run']
fn run(){
	rl.set_trace_log_level(int(rl.TraceLogLevel.log_all))
	mut counter := 0
	println("ordinary V")
	rl.init_window(screen_width, screen_height, 'Example of using V and Raylib together on android but runable for pc')
	rl.set_target_fps(60)
	for !rl.window_should_close() {
		rl.begin_drawing()
		rl.clear_background(white)
		$if android{
			rl.draw_text('look logcat.', 160, 270, 40, blue)
			counter++
			if counter == 120{
				counter = 0
				println('[V] main')
    			//rl.trace_log(0, '[V] main', rl.TraceLogLevel.log_all)
			}
		}
		$else{
			rl.draw_text('Hello from V and Raylib on PC.', 160, 270, 40, blue)
		}
		rl.end_drawing()
	}
	rl.close_window()
}

fn main(){
	run()
}
