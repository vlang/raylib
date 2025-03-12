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

// vis_key_pressed allows you to pass a `KeyboardKey` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vis_key_pressed(key KeyboardKey) bool {
	return is_key_pressed(int(key))
}

// vset_trace_log_level allows you to pass a `TraceLogLevel` enum value in your V programs, instead of a plain int.
@[inline]
pub fn vset_trace_log_level(log_level TraceLogLevel) {
	set_trace_log_level(int(log_level))
}
