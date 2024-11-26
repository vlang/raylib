module raymath

#flag -lraymath
#include <raymath.h>

@[typedef]
struct C.va_list {}

pub type Vector2 = C.Vector2

// Vector2 type
struct C.Vector2 {
	//
	x f32
	//
	y f32
}

pub type Vector3 = C.Vector3

// Vector3 type
struct C.Vector3 {
	//
	x f32
	//
	y f32
	//
	z f32
}

pub type Vector4 = C.Vector4

// Vector4 type
struct C.Vector4 {
	//
	x f32
	//
	y f32
	//
	z f32
	//
	w f32
}

pub type Matrix = C.Matrix

// Matrix type (OpenGL style 4x4 - right handed, column major)
struct C.Matrix {
	// Matrix first row (4 components)
	m0 f32
	// Matrix first row (4 components)
	m4 f32
	// Matrix first row (4 components)
	m8 f32
	// Matrix first row (4 components)
	m12 f32
	// Matrix second row (4 components)
	m1 f32
	// Matrix second row (4 components)
	m5 f32
	// Matrix second row (4 components)
	m9 f32
	// Matrix second row (4 components)
	m13 f32
	// Matrix third row (4 components)
	m2 f32
	// Matrix third row (4 components)
	m6 f32
	// Matrix third row (4 components)
	m10 f32
	// Matrix third row (4 components)
	m14 f32
	// Matrix fourth row (4 components)
	m3 f32
	// Matrix fourth row (4 components)
	m7 f32
	// Matrix fourth row (4 components)
	m11 f32
	// Matrix fourth row (4 components)
	m15 f32
}

pub type float3 = C.float3

// NOTE: Helper types to be used instead of array return types for *ToFloat functions
struct C.float3 {
	//
	v [3]f32
}

pub type float16 = C.float16

struct C.float16 {
	//
	v [16]f32
}

// Quaternion type
pub type Quaternion = C.Vector4
