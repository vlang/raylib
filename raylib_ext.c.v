// These are manually-made bindings for parts of the library that do not need
// or validate custom handling for.
// Functions that use strings get bindings here so that I can allow them to use
// V-strings as arguments/return types instead of C-strings

module raylib

#flag linux -lraylib -lGL -lm -lpthread -ldl -lrt -lX11

#flag darwin -lraylib -lm -framework Foundation -framework AppKit -framework OpenGL -framework CoreVideo

#flag windows -DNOUSER -DNOSHOWWINDOW -DNOGDI
#flag windows -lraylib@START_LIBS
#flag windows -lgdi32 -lwinmm

// test	
#flag android -llog
#flag android -landroid
#flag android -lEGL
#flag android -lGLESv2
#flag android -lOpenSLES
#flag android -lm
#flag android -DPLATFORM_ANDROID
#flag android -DGRAPHICS_API_OPENGL_ES2
#flag android -Wno-implicit-const-int-float-conversion
#flag android -I@VMODROOT/android-ext/native_app_glue
#flag android -L@VMODROOT/raylib/src
#flag android -I@VMODROOT/raylib/src
#flag android -l:libraylib.a
$if android {
    #include "android_native_app_glue.c"
}



// See https://github.com/raysan5/raylib/wiki/Working-for-Web-(HTML5) for instructions on how to build/compile
// programs targeting browsers, using the emscripten toolchain. The options here are 
#flag wasm32_emscripten -sUSE_GLFW=3
#flag wasm32_emscripten -sASYNCIFY
#flag wasm32_emscripten -sEXPORTED_RUNTIME_METHODS=ccall
#flag wasm32_emscripten -sGL_ENABLE_GET_PROC_ADDRESS=1
// Allow customisation of the include/library location, by passing `-d RAYLIB_WASM_FOLDER=/some/path`
// See also https://github.com/raysan5/raylib/releases/download/5.5/raylib-5.5_webassembly.zip for how to get an older version.
// Note: that .zip file contains `libraylib.a`, but more recent raylib builds (5.6),
// have that renamed to `libraylib.web.a`, which allows you to have a non conflicting
// libraylib.a for your current platform too.
#flag wasm32_emscripten -I $d('RAYLIB_WASM_FOLDER', '.')
#flag wasm32_emscripten -L $d('RAYLIB_WASM_FOLDER', '.')
#flag wasm32_emscripten -I $d('RAYLIB_WASM_FOLDER', '.')/include
#flag wasm32_emscripten -L $d('RAYLIB_WASM_FOLDER', '.')/lib
#flag wasm32_emscripten -I @VMODROOT/emscripten
#flag wasm32_emscripten -L @VMODROOT/emscripten
#flag wasm32_emscripten -lraylib.web

#include <raylib.h>

@[typedef]
pub struct C.va_list {}

pub struct C.rAudioBuffer {}

pub struct C.rAudioProcessor {}

pub type AudioBuffer = C.rAudioBuffer
pub type AudioProcessor = C.rAudioProcessor

pub const lightgray = Color{200, 200, 200, 255}
pub const gray = Color{130, 130, 130, 255}
pub const darkgray = Color{80, 80, 80, 255}
pub const yellow = Color{253, 249, 0, 255}
pub const gold = Color{255, 203, 0, 255}
pub const orange = Color{255, 161, 0, 255}
pub const pink = Color{255, 109, 194, 255}
pub const red = Color{230, 41, 55, 255}
pub const maroon = Color{190, 33, 55, 255}
pub const green = Color{0, 228, 48, 255}
pub const lime = Color{0, 158, 47, 255}
pub const darkgreen = Color{0, 117, 44, 255}
pub const skyblue = Color{102, 191, 255, 255}
pub const blue = Color{0, 121, 241, 255}
pub const darkblue = Color{0, 82, 172, 255}
pub const purple = Color{200, 122, 255, 255}
pub const violet = Color{135, 60, 190, 255}
pub const darkpurple = Color{112, 31, 126, 255}
pub const beige = Color{211, 176, 131, 255}
pub const brown = Color{127, 106, 79, 255}
pub const darkbrown = Color{76, 63, 47, 255}

pub const white = Color{255, 255, 255, 255}
pub const black = Color{0, 0, 0, 255}
pub const blank = Color{0, 0, 0, 0}
pub const magenta = Color{255, 0, 255, 255}
pub const raywhite = Color{245, 245, 245, 255}

pub const camera_perspective = 0
pub const camera_orthographic = 1

pub const camera_free = 1
pub const camera_orbital = 2
pub const camera_first_person = 3
pub const camera_third_person = 4

// Keyboard related

// vis_key_pressed allows you to pass a `KeyboardKey` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_key_pressed(key KeyboardKey) bool {
	return is_key_pressed(int(key))
}

// vis_key_pressed_repeat allows you to pass a `KeyboardKey` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_key_pressed_repeat(key KeyboardKey) bool {
	return is_key_pressed_repeat(int(key))
}

// vis_key_down allows you to pass a `KeyboardKey` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_key_down(key KeyboardKey) bool {
	return is_key_down(int(key))
}

// vis_key_up allows you to pass a `KeyboardKey` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_key_up(key KeyboardKey) bool {
	return is_key_up(int(key))
}

// vis_key_released allows you to pass a `KeyboardKey` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_key_released(key KeyboardKey) bool {
	return is_key_released(int(key))
}

// vset_exit_key allows you to pass a `KeyboardKey` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vset_exit_key(key KeyboardKey) {
	set_exit_key(int(key))
}

// log level

// vset_trace_log_level allows you to pass a `TraceLogLevel` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vset_trace_log_level(log_level TraceLogLevel) {
	set_trace_log_level(int(log_level))
}

// Mouse button related

// vis_mouse_button_pressed allows you to pass a `MouseButton` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_mouse_button_pressed(button MouseButton) bool {
	return is_mouse_button_pressed(int(button))
}

// vis_mouse_button_down allows you to pass a `MouseButton` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_mouse_button_down(button MouseButton) bool {
	return is_mouse_button_down(int(button))
}

// vis_mouse_button_released allows you to pass a `MouseButton` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_mouse_button_released(button MouseButton) bool {
	return is_mouse_button_released(int(button))
}

// vis_mouse_button_up allows you to pass a `MouseButton` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_mouse_button_up(button MouseButton) bool {
	return is_mouse_button_up(int(button))
}

// GamePad related

//  vis_gamepad_aviable allows you to pass a `GamepadButton` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_gamepad_aviable(gamepad GamepadButton) bool {
	return is_gamepad_available(int(gamepad))
}

//  vis_gamepad_button_pressed allows you to pass a `GamepadButton` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_gamepad_button_pressed(gamepad int, button GamepadButton) bool {
	return is_gamepad_button_pressed(gamepad, int(button))
}

//  vis_gamepad_button_down allows you to pass a `GamepadButton` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_gamepad_button_down(gamepad int, button GamepadButton) bool {
	return is_gamepad_button_down(gamepad, int(button))
}

//  vis_gamepad_button_released allows you to pass a `GamepadButton` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_gamepad_button_released(gamepad int, button GamepadButton) bool {
	return is_gamepad_button_released(gamepad, int(button))
}

//  vis_gamepad_button_up allows you to pass a `GamepadButton` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_gamepad_button_up(gamepad int, button GamepadButton) bool {
	return is_gamepad_button_up(gamepad, int(button))
}

//  vget_gamepad_axis_movement allows you to pass a `GamepadAxis` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vget_gamepad_axis_movement(gamepad int, axis GamepadAxis) f32 {
	return get_gamepad_axis_movement(gamepad, int(axis))
}

//  vis_gesture_detected allows you to pass a `Gesture` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_gesture_detected(gesture Gesture) bool {
	return is_gesture_detected(u32(gesture))
}
