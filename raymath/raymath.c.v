module raymath

import raylib { Matrix, Vector2, Vector3, Vector4 }

pub type Float3 = C.float3

// NOTE: Helper types to be used instead of array return types for *ToFloat functions
pub struct C.float3 {
	v [3]f32
}

pub type Float16 = C.float16

pub struct C.float16 {
	v [16]f32
}

// Quaternion type
pub type Quaternion = C.Vector4

fn C.Clamp(f32, f32, f32) f32
@[inline]
pub fn clamp(value f32, min f32, max f32) f32 {
	return C.Clamp(value, min, max)
}

fn C.Lerp(f32, f32, f32) f32
@[inline]
pub fn lerp(start f32, end f32, amount f32) f32 {
	return C.Lerp(start, end, amount)
}

fn C.Normalize(f32, f32, f32) f32
@[inline]
pub fn normalize(value f32, start f32, end f32) f32 {
	return C.Normalize(value, start, end)
}

fn C.Remap(f32, f32, f32, f32, f32) f32
@[inline]
pub fn remap(value f32, input_start f32, input_end f32, output_start f32, output_end f32) f32 {
	return C.Remap(value, input_start, input_end, output_start, output_end)
}

fn C.Wrap(f32, f32, f32) f32
@[inline]
pub fn wrap(value f32, min f32, max f32) f32 {
	return C.Wrap(value, min, max)
}

fn C.FloatEquals(f32, f32) int
@[inline]
pub fn float_equals(x f32, y f32) int {
	return C.FloatEquals(x, y)
}

fn C.Vector2Zero() Vector2
@[inline]
pub fn vector2_zero() Vector2 {
	return C.Vector2Zero()
}

fn C.Vector2One() Vector2
@[inline]
pub fn vector2_one() Vector2 {
	return C.Vector2One()
}

fn C.Vector2Add(Vector2, Vector2) Vector2
@[inline]
pub fn vector2_add(v1 Vector2, v2 Vector2) Vector2 {
	return C.Vector2Add(v1, v2)
}

fn C.Vector2AddValue(Vector2, f32) Vector2
@[inline]
pub fn vector2_add_value(v Vector2, add f32) Vector2 {
	return C.Vector2AddValue(v, add)
}

fn C.Vector2Subtract(Vector2, Vector2) Vector2
@[inline]
pub fn vector2_subtract(v1 Vector2, v2 Vector2) Vector2 {
	return C.Vector2Subtract(v1, v2)
}

fn C.Vector2SubtractValue(Vector2, f32) Vector2
@[inline]
pub fn vector2_subtract_value(v Vector2, sub f32) Vector2 {
	return C.Vector2SubtractValue(v, sub)
}

fn C.Vector2Length(Vector2) f32
@[inline]
pub fn vector2_length(v Vector2) f32 {
	return C.Vector2Length(v)
}

fn C.Vector2LengthSqr(Vector2) f32
@[inline]
pub fn vector2_length_sqr(v Vector2) f32 {
	return C.Vector2LengthSqr(v)
}

fn C.Vector2DotProduct(Vector2, Vector2) f32
@[inline]
pub fn vector_2dot_product(v1 Vector2, v2 Vector2) f32 {
	return C.Vector2DotProduct(v1, v2)
}

fn C.Vector2CrossProduct(Vector2, Vector2) f32
@[inline]
pub fn vector2_cross_product(v1 Vector2, v2 Vector2) f32 {
	return C.Vector2CrossProduct(v1, v2)
}

fn C.Vector2Distance(Vector2, Vector2) f32
@[inline]
pub fn vector_2distance(v1 Vector2, v2 Vector2) f32 {
	return C.Vector2Distance(v1, v2)
}

fn C.Vector2DistanceSqr(Vector2, Vector2) f32
@[inline]
pub fn vector_2distance_sqr(v1 Vector2, v2 Vector2) f32 {
	return C.Vector2DistanceSqr(v1, v2)
}

fn C.Vector2Angle(Vector2, Vector2) f32
@[inline]
pub fn vector2_angle(v1 Vector2, v2 Vector2) f32 {
	return C.Vector2Angle(v1, v2)
}

fn C.Vector2LineAngle(Vector2, Vector2) f32
@[inline]
pub fn vector2_line_angle(start Vector2, end Vector2) f32 {
	return C.Vector2LineAngle(start, end)
}

fn C.Vector2Scale(Vector2, f32) Vector2
@[inline]
pub fn vector2_scale(v Vector2, scale f32) Vector2 {
	return C.Vector2Scale(v, scale)
}

fn C.Vector2Multiply(Vector2, Vector2) Vector2
@[inline]
pub fn vector2_multiply(v1 Vector2, v2 Vector2) Vector2 {
	return C.Vector2Multiply(v1, v2)
}

fn C.Vector2Negate(Vector2) Vector2
@[inline]
pub fn vector2_negate(v Vector2) Vector2 {
	return C.Vector2Negate(v)
}

fn C.Vector2Divide(Vector2, Vector2) Vector2
@[inline]
pub fn vector_2divide(v1 Vector2, v2 Vector2) Vector2 {
	return C.Vector2Divide(v1, v2)
}

fn C.Vector2Normalize(Vector2) Vector2
@[inline]
pub fn vector2_normalize(v Vector2) Vector2 {
	return C.Vector2Normalize(v)
}

fn C.Vector2Transform(Vector2, Matrix) Vector2
@[inline]
pub fn vector2_transform(v Vector2, mat Matrix) Vector2 {
	return C.Vector2Transform(v, mat)
}

fn C.Vector2Lerp(Vector2, Vector2, f32) Vector2
@[inline]
pub fn vector2_lerp(v1 Vector2, v2 Vector2, amount f32) Vector2 {
	return C.Vector2Lerp(v1, v2, amount)
}

fn C.Vector2Reflect(Vector2, Vector2) Vector2
@[inline]
pub fn vector2_reflect(v Vector2, normal Vector2) Vector2 {
	return C.Vector2Reflect(v, normal)
}

fn C.Vector2Min(Vector2, Vector2) Vector2
@[inline]
pub fn vector2_min(v1 Vector2, v2 Vector2) Vector2 {
	return C.Vector2Min(v1, v2)
}

fn C.Vector2Max(Vector2, Vector2) Vector2
@[inline]
pub fn vector2_max(v1 Vector2, v2 Vector2) Vector2 {
	return C.Vector2Max(v1, v2)
}

fn C.Vector2Rotate(Vector2, f32) Vector2
@[inline]
pub fn vector2_rotate(v Vector2, angle f32) Vector2 {
	return C.Vector2Rotate(v, angle)
}

fn C.Vector2MoveTowards(Vector2, Vector2, f32) Vector2
@[inline]
pub fn vector2_move_towards(v Vector2, target Vector2, max_distance f32) Vector2 {
	return C.Vector2MoveTowards(v, target, max_distance)
}

fn C.Vector2Invert(Vector2) Vector2
@[inline]
pub fn vector2_invert(v Vector2) Vector2 {
	return C.Vector2Invert(v)
}

fn C.Vector2Clamp(Vector2, Vector2, Vector2) Vector2
@[inline]
pub fn vector2_clamp(v Vector2, min Vector2, max Vector2) Vector2 {
	return C.Vector2Clamp(v, min, max)
}

fn C.Vector2ClampValue(Vector2, f32, f32) Vector2
@[inline]
pub fn vector2_clamp_value(v Vector2, min f32, max f32) Vector2 {
	return C.Vector2ClampValue(v, min, max)
}

fn C.Vector2Equals(Vector2, Vector2) int
@[inline]
pub fn vector2_equals(p Vector2, q Vector2) int {
	return C.Vector2Equals(p, q)
}

fn C.Vector2Refract(Vector2, Vector2, f32) Vector2
@[inline]
pub fn vector2_refract(v Vector2, n Vector2, r f32) Vector2 {
	return C.Vector2Refract(v, n, r)
}

fn C.Vector3Zero() Vector3
@[inline]
pub fn vector3_zero() Vector3 {
	return C.Vector3Zero()
}

fn C.Vector3One() Vector3
@[inline]
pub fn vector3_one() Vector3 {
	return C.Vector3One()
}

fn C.Vector3Add(Vector3, Vector3) Vector3
@[inline]
pub fn vector3_add(v1 Vector3, v2 Vector3) Vector3 {
	return C.Vector3Add(v1, v2)
}

fn C.Vector3AddValue(Vector3, f32) Vector3
@[inline]
pub fn vector3_add_value(v Vector3, add f32) Vector3 {
	return C.Vector3AddValue(v, add)
}

fn C.Vector3Subtract(Vector3, Vector3) Vector3
@[inline]
pub fn vector3_subtract(v1 Vector3, v2 Vector3) Vector3 {
	return C.Vector3Subtract(v1, v2)
}

fn C.Vector3SubtractValue(Vector3, f32) Vector3
@[inline]
pub fn vector3_subtract_value(v Vector3, sub f32) Vector3 {
	return C.Vector3SubtractValue(v, sub)
}

fn C.Vector3Scale(Vector3, f32) Vector3
@[inline]
pub fn vector3_scale(v Vector3, scalar f32) Vector3 {
	return C.Vector3Scale(v, scalar)
}

fn C.Vector3Multiply(Vector3, Vector3) Vector3
@[inline]
pub fn vector3_multiply(v1 Vector3, v2 Vector3) Vector3 {
	return C.Vector3Multiply(v1, v2)
}

fn C.Vector3CrossProduct(Vector3, Vector3) Vector3
@[inline]
pub fn vector3_cross_product(v1 Vector3, v2 Vector3) Vector3 {
	return C.Vector3CrossProduct(v1, v2)
}

fn C.Vector3Perpendicular(Vector3) Vector3
@[inline]
pub fn vector3_perpendicular(v Vector3) Vector3 {
	return C.Vector3Perpendicular(v)
}

fn C.Vector3Length(Vector3) f32
@[inline]
pub fn vector3_length(v Vector3) f32 {
	return C.Vector3Length(v)
}

fn C.Vector3LengthSqr(Vector3) f32
@[inline]
pub fn vector3_length_sqr(v Vector3) f32 {
	return C.Vector3LengthSqr(v)
}

fn C.Vector3DotProduct(Vector3, Vector3) f32
@[inline]
pub fn vector_3dot_product(v1 Vector3, v2 Vector3) f32 {
	return C.Vector3DotProduct(v1, v2)
}

fn C.Vector3Distance(Vector3, Vector3) f32
@[inline]
pub fn vector_3distance(v1 Vector3, v2 Vector3) f32 {
	return C.Vector3Distance(v1, v2)
}

fn C.Vector3DistanceSqr(Vector3, Vector3) f32
@[inline]
pub fn vector_3distance_sqr(v1 Vector3, v2 Vector3) f32 {
	return C.Vector3DistanceSqr(v1, v2)
}

fn C.Vector3Angle(Vector3, Vector3) f32
@[inline]
pub fn vector3_angle(v1 Vector3, v2 Vector3) f32 {
	return C.Vector3Angle(v1, v2)
}

fn C.Vector3Negate(Vector3) Vector3
@[inline]
pub fn vector3_negate(v Vector3) Vector3 {
	return C.Vector3Negate(v)
}

fn C.Vector3Divide(Vector3, Vector3) Vector3
@[inline]
pub fn vector_3divide(v1 Vector3, v2 Vector3) Vector3 {
	return C.Vector3Divide(v1, v2)
}

fn C.Vector3Normalize(Vector3) Vector3
@[inline]
pub fn vector3_normalize(v Vector3) Vector3 {
	return C.Vector3Normalize(v)
}

fn C.Vector3Project(Vector3, Vector3) Vector3
@[inline]
pub fn vector3_project(v1 Vector3, v2 Vector3) Vector3 {
	return C.Vector3Project(v1, v2)
}

fn C.Vector3Reject(Vector3, Vector3) Vector3
@[inline]
pub fn vector3_reject(v1 Vector3, v2 Vector3) Vector3 {
	return C.Vector3Reject(v1, v2)
}

fn C.Vector3OrthoNormalize(&Vector3, &Vector3)
@[inline]
pub fn vector3_ortho_normalize(v1 &Vector3, v2 &Vector3) {
	C.Vector3OrthoNormalize(v1, v2)
}

fn C.Vector3Transform(Vector3, Matrix) Vector3
@[inline]
pub fn vector3_transform(v Vector3, mat Matrix) Vector3 {
	return C.Vector3Transform(v, mat)
}

fn C.Vector3RotateByQuaternion(Vector3, Quaternion) Vector3
@[inline]
pub fn vector3_rotate_by_quaternion(v Vector3, q Quaternion) Vector3 {
	return C.Vector3RotateByQuaternion(v, q)
}

fn C.Vector3RotateByAxisAngle(Vector3, Vector3, f32) Vector3
@[inline]
pub fn vector3_rotate_by_axis_angle(v Vector3, axis Vector3, angle f32) Vector3 {
	return C.Vector3RotateByAxisAngle(v, axis, angle)
}

fn C.Vector3MoveTowards(Vector3, Vector3, f32) Vector3
@[inline]
pub fn vector3_move_towards(v Vector3, target Vector3, max_distance f32) Vector3 {
	return C.Vector3MoveTowards(v, target, max_distance)
}

fn C.Vector3Lerp(Vector3, Vector3, f32) Vector3
@[inline]
pub fn vector3_lerp(v1 Vector3, v2 Vector3, amount f32) Vector3 {
	return C.Vector3Lerp(v1, v2, amount)
}

fn C.Vector3CubicHermite(Vector3, Vector3, Vector3, Vector3, f32) Vector3
@[inline]
pub fn vector3_cubic_hermite(v1 Vector3, tangent1 Vector3, v2 Vector3, tangent2 Vector3, amount f32) Vector3 {
	return C.Vector3CubicHermite(v1, tangent1, v2, tangent2, amount)
}

fn C.Vector3Reflect(Vector3, Vector3) Vector3
@[inline]
pub fn vector3_reflect(v Vector3, normal Vector3) Vector3 {
	return C.Vector3Reflect(v, normal)
}

fn C.Vector3Min(Vector3, Vector3) Vector3
@[inline]
pub fn vector3_min(v1 Vector3, v2 Vector3) Vector3 {
	return C.Vector3Min(v1, v2)
}

fn C.Vector3Max(Vector3, Vector3) Vector3
@[inline]
pub fn vector3_max(v1 Vector3, v2 Vector3) Vector3 {
	return C.Vector3Max(v1, v2)
}

fn C.Vector3Barycenter(Vector3, Vector3, Vector3, Vector3) Vector3
@[inline]
pub fn vector3_barycenter(p Vector3, a Vector3, b Vector3, c Vector3) Vector3 {
	return C.Vector3Barycenter(p, a, b, c)
}

fn C.Vector3Unproject(Vector3, Matrix, Matrix) Vector3
@[inline]
pub fn vector3_unproject(source Vector3, projection Matrix, view Matrix) Vector3 {
	return C.Vector3Unproject(source, projection, view)
}

fn C.Vector3ToFloatV(Vector3) Float3
@[inline]
pub fn vector3_to_float_v(v Vector3) Float3 {
	return C.Vector3ToFloatV(v)
}

fn C.Vector3Invert(Vector3) Vector3
@[inline]
pub fn vector3_invert(v Vector3) Vector3 {
	return C.Vector3Invert(v)
}

fn C.Vector3Clamp(Vector3, Vector3, Vector3) Vector3
@[inline]
pub fn vector3_clamp(v Vector3, min Vector3, max Vector3) Vector3 {
	return C.Vector3Clamp(v, min, max)
}

fn C.Vector3ClampValue(Vector3, f32, f32) Vector3
@[inline]
pub fn vector3_clamp_value(v Vector3, min f32, max f32) Vector3 {
	return C.Vector3ClampValue(v, min, max)
}

fn C.Vector3Equals(Vector3, Vector3) int
@[inline]
pub fn vector3_equals(p Vector3, q Vector3) int {
	return C.Vector3Equals(p, q)
}

fn C.Vector3Refract(Vector3, Vector3, f32) Vector3
@[inline]
pub fn vector3_refract(v Vector3, n Vector3, r f32) Vector3 {
	return C.Vector3Refract(v, n, r)
}

fn C.Vector4Zero() Vector4
@[inline]
pub fn vector4_zero() Vector4 {
	return C.Vector4Zero()
}

fn C.Vector4One() Vector4
@[inline]
pub fn vector4_one() Vector4 {
	return C.Vector4One()
}

fn C.Vector4Add(Vector4, Vector4) Vector4
@[inline]
pub fn vector4_add(v1 Vector4, v2 Vector4) Vector4 {
	return C.Vector4Add(v1, v2)
}

fn C.Vector4AddValue(Vector4, f32) Vector4
@[inline]
pub fn vector4_add_value(v Vector4, add f32) Vector4 {
	return C.Vector4AddValue(v, add)
}

fn C.Vector4Subtract(Vector4, Vector4) Vector4
@[inline]
pub fn vector4_subtract(v1 Vector4, v2 Vector4) Vector4 {
	return C.Vector4Subtract(v1, v2)
}

fn C.Vector4SubtractValue(Vector4, f32) Vector4
@[inline]
pub fn vector4_subtract_value(v Vector4, add f32) Vector4 {
	return C.Vector4SubtractValue(v, add)
}

fn C.Vector4Length(Vector4) f32
@[inline]
pub fn vector4_length(v Vector4) f32 {
	return C.Vector4Length(v)
}

fn C.Vector4LengthSqr(Vector4) f32
@[inline]
pub fn vector4_length_sqr(v Vector4) f32 {
	return C.Vector4LengthSqr(v)
}

fn C.Vector4DotProduct(Vector4, Vector4) f32
@[inline]
pub fn vector4_dot_product(v1 Vector4, v2 Vector4) f32 {
	return C.Vector4DotProduct(v1, v2)
}

fn C.Vector4Distance(Vector4, Vector4) f32
@[inline]
pub fn vector4_distance(v1 Vector4, v2 Vector4) f32 {
	return C.Vector4Distance(v1, v2)
}

fn C.Vector4DistanceSqr(Vector4, Vector4) f32
@[inline]
pub fn vector4_distance_sqr(v1 Vector4, v2 Vector4) f32 {
	return C.Vector4DistanceSqr(v1, v2)
}

fn C.Vector4Scale(Vector4, f32) Vector4
@[inline]
pub fn vector4_scale(v Vector4, scale f32) Vector4 {
	return C.Vector4Scale(v, scale)
}

fn C.Vector4Multiply(Vector4, Vector4) Vector4
@[inline]
pub fn vector4_multiply(v1 Vector4, v2 Vector4) Vector4 {
	return C.Vector4Multiply(v1, v2)
}

fn C.Vector4Negate(Vector4) Vector4
@[inline]
pub fn vector4_negate(v Vector4) Vector4 {
	return C.Vector4Negate(v)
}

fn C.Vector4Divide(Vector4, Vector4) Vector4
@[inline]
pub fn vector4_divide(v1 Vector4, v2 Vector4) Vector4 {
	return C.Vector4Divide(v1, v2)
}

fn C.Vector4Normalize(Vector4) Vector4
@[inline]
pub fn vector4_normalize(v Vector4) Vector4 {
	return C.Vector4Normalize(v)
}

fn C.Vector4Min(Vector4, Vector4) Vector4
@[inline]
pub fn vector4_min(v1 Vector4, v2 Vector4) Vector4 {
	return C.Vector4Min(v1, v2)
}

fn C.Vector4Max(Vector4, Vector4) Vector4
@[inline]
pub fn vector4_max(v1 Vector4, v2 Vector4) Vector4 {
	return C.Vector4Max(v1, v2)
}

fn C.Vector4Lerp(Vector4, Vector4, f32) Vector4
@[inline]
pub fn vector4_lerp(v1 Vector4, v2 Vector4, amount f32) Vector4 {
	return C.Vector4Lerp(v1, v2, amount)
}

fn C.Vector4MoveTowards(Vector4, Vector4, f32) Vector4
@[inline]
pub fn vector4_move_towards(v Vector4, target Vector4, max_distance f32) Vector4 {
	return C.Vector4MoveTowards(v, target, max_distance)
}

fn C.Vector4Invert(Vector4) Vector4
@[inline]
pub fn vector4_invert(v Vector4) Vector4 {
	return C.Vector4Invert(v)
}

fn C.Vector4Equals(Vector4, Vector4) int
@[inline]
pub fn vector4_equals(p Vector4, q Vector4) int {
	return C.Vector4Equals(p, q)
}

fn C.MatrixDeterminant(Matrix) f32
@[inline]
pub fn matrix_determinant(mat Matrix) f32 {
	return C.MatrixDeterminant(mat)
}

fn C.MatrixTrace(Matrix) f32
@[inline]
pub fn matrix_trace(mat Matrix) f32 {
	return C.MatrixTrace(mat)
}

fn C.MatrixTranspose(Matrix) Matrix
@[inline]
pub fn matrix_transpose(mat Matrix) Matrix {
	return C.MatrixTranspose(mat)
}

fn C.MatrixInvert(Matrix) Matrix
@[inline]
pub fn matrix_invert(mat Matrix) Matrix {
	return C.MatrixInvert(mat)
}

fn C.MatrixIdentity() Matrix
@[inline]
pub fn matrix_identity() Matrix {
	return C.MatrixIdentity()
}

fn C.MatrixAdd(Matrix, Matrix) Matrix
@[inline]
pub fn matrix_add(left Matrix, right Matrix) Matrix {
	return C.MatrixAdd(left, right)
}

fn C.MatrixSubtract(Matrix, Matrix) Matrix
@[inline]
pub fn matrix_subtract(left Matrix, right Matrix) Matrix {
	return C.MatrixSubtract(left, right)
}

fn C.MatrixMultiply(Matrix, Matrix) Matrix
@[inline]
pub fn matrix_multiply(left Matrix, right Matrix) Matrix {
	return C.MatrixMultiply(left, right)
}

fn C.MatrixTranslate(f32, f32, f32) Matrix
@[inline]
pub fn matrix_translate(x f32, y f32, z f32) Matrix {
	return C.MatrixTranslate(x, y, z)
}

fn C.MatrixRotate(Vector3, f32) Matrix
@[inline]
pub fn matrix_rotate(axis Vector3, angle f32) Matrix {
	return C.MatrixRotate(axis, angle)
}

fn C.MatrixRotateX(f32) Matrix
@[inline]
pub fn matrix_rotate_x(angle f32) Matrix {
	return C.MatrixRotateX(angle)
}

fn C.MatrixRotateY(f32) Matrix
@[inline]
pub fn matrix_rotate_y(angle f32) Matrix {
	return C.MatrixRotateY(angle)
}

fn C.MatrixRotateZ(f32) Matrix
@[inline]
pub fn matrix_rotate_z(angle f32) Matrix {
	return C.MatrixRotateZ(angle)
}

fn C.MatrixRotateXYZ(Vector3) Matrix
@[inline]
pub fn matrix_rotate_x_y_z(angle Vector3) Matrix {
	return C.MatrixRotateXYZ(angle)
}

fn C.MatrixRotateZYX(Vector3) Matrix
@[inline]
pub fn matrix_rotate_z_y_x(angle Vector3) Matrix {
	return C.MatrixRotateZYX(angle)
}

fn C.MatrixScale(f32, f32, f32) Matrix
@[inline]
pub fn matrix_scale(x f32, y f32, z f32) Matrix {
	return C.MatrixScale(x, y, z)
}

fn C.MatrixFrustum(f64, f64, f64, f64, f64, f64) Matrix
@[inline]
pub fn matrix_frustum(left f64, right f64, bottom f64, top f64, near_plane f64, far_plane f64) Matrix {
	return C.MatrixFrustum(left, right, bottom, top, near_plane, far_plane)
}

fn C.MatrixPerspective(f64, f64, f64, f64) Matrix
@[inline]
pub fn matrix_perspective(fov_y f64, aspect f64, near_plane f64, far_plane f64) Matrix {
	return C.MatrixPerspective(fov_y, aspect, near_plane, far_plane)
}

fn C.MatrixOrtho(f64, f64, f64, f64, f64, f64) Matrix
@[inline]
pub fn matrix_ortho(left f64, right f64, bottom f64, top f64, near_plane f64, far_plane f64) Matrix {
	return C.MatrixOrtho(left, right, bottom, top, near_plane, far_plane)
}

fn C.MatrixLookAt(Vector3, Vector3, Vector3) Matrix
@[inline]
pub fn matrix_look_at(eye Vector3, target Vector3, up Vector3) Matrix {
	return C.MatrixLookAt(eye, target, up)
}

fn C.MatrixToFloatV(Matrix) Float16
@[inline]
pub fn matrix_to_float_v(mat Matrix) Float16 {
	return C.MatrixToFloatV(mat)
}

fn C.QuaternionAdd(Quaternion, Quaternion) Quaternion
@[inline]
pub fn quaternion_add(q1 Quaternion, q2 Quaternion) Quaternion {
	return C.QuaternionAdd(q1, q2)
}

fn C.QuaternionAddValue(Quaternion, f32) Quaternion
@[inline]
pub fn quaternion_add_value(q Quaternion, add f32) Quaternion {
	return C.QuaternionAddValue(q, add)
}

fn C.QuaternionSubtract(Quaternion, Quaternion) Quaternion
@[inline]
pub fn quaternion_subtract(q1 Quaternion, q2 Quaternion) Quaternion {
	return C.QuaternionSubtract(q1, q2)
}

fn C.QuaternionSubtractValue(Quaternion, f32) Quaternion
@[inline]
pub fn quaternion_subtract_value(q Quaternion, sub f32) Quaternion {
	return C.QuaternionSubtractValue(q, sub)
}

fn C.QuaternionIdentity() Quaternion
@[inline]
pub fn quaternion_identity() Quaternion {
	return C.QuaternionIdentity()
}

fn C.QuaternionLength(Quaternion) f32
@[inline]
pub fn quaternion_length(q Quaternion) f32 {
	return C.QuaternionLength(q)
}

fn C.QuaternionNormalize(Quaternion) Quaternion
@[inline]
pub fn quaternion_normalize(q Quaternion) Quaternion {
	return C.QuaternionNormalize(q)
}

fn C.QuaternionInvert(Quaternion) Quaternion
@[inline]
pub fn quaternion_invert(q Quaternion) Quaternion {
	return C.QuaternionInvert(q)
}

fn C.QuaternionMultiply(Quaternion, Quaternion) Quaternion
@[inline]
pub fn quaternion_multiply(q1 Quaternion, q2 Quaternion) Quaternion {
	return C.QuaternionMultiply(q1, q2)
}

fn C.QuaternionScale(Quaternion, f32) Quaternion
@[inline]
pub fn quaternion_scale(q Quaternion, mul f32) Quaternion {
	return C.QuaternionScale(q, mul)
}

fn C.QuaternionDivide(Quaternion, Quaternion) Quaternion
@[inline]
pub fn quaternion_divide(q1 Quaternion, q2 Quaternion) Quaternion {
	return C.QuaternionDivide(q1, q2)
}

fn C.QuaternionLerp(Quaternion, Quaternion, f32) Quaternion
@[inline]
pub fn quaternion_lerp(q1 Quaternion, q2 Quaternion, amount f32) Quaternion {
	return C.QuaternionLerp(q1, q2, amount)
}

fn C.QuaternionNlerp(Quaternion, Quaternion, f32) Quaternion
@[inline]
pub fn quaternion_nlerp(q1 Quaternion, q2 Quaternion, amount f32) Quaternion {
	return C.QuaternionNlerp(q1, q2, amount)
}

fn C.QuaternionSlerp(Quaternion, Quaternion, f32) Quaternion
@[inline]
pub fn quaternion_slerp(q1 Quaternion, q2 Quaternion, amount f32) Quaternion {
	return C.QuaternionSlerp(q1, q2, amount)
}

fn C.QuaternionCubicHermiteSpline(Quaternion, Quaternion, Quaternion, Quaternion, f32) Quaternion
@[inline]
pub fn quaternion_cubic_hermite_spline(q1 Quaternion, out_tangent1 Quaternion, q2 Quaternion, in_tangent2 Quaternion, t f32) Quaternion {
	return C.QuaternionCubicHermiteSpline(q1, out_tangent1, q2, in_tangent2, t)
}

fn C.QuaternionFromVector3ToVector3(Vector3, Vector3) Quaternion
@[inline]
pub fn quaternion_from_vector3_to_vector3(from Vector3, to Vector3) Quaternion {
	return C.QuaternionFromVector3ToVector3(from, to)
}

fn C.QuaternionFromMatrix(Matrix) Quaternion
@[inline]
pub fn quaternion_from_matrix(mat Matrix) Quaternion {
	return C.QuaternionFromMatrix(mat)
}

fn C.QuaternionToMatrix(Quaternion) Matrix
@[inline]
pub fn quaternion_to_matrix(q Quaternion) Matrix {
	return C.QuaternionToMatrix(q)
}

fn C.QuaternionFromAxisAngle(Vector3, f32) Quaternion
@[inline]
pub fn quaternion_from_axis_angle(axis Vector3, angle f32) Quaternion {
	return C.QuaternionFromAxisAngle(axis, angle)
}

fn C.QuaternionToAxisAngle(Quaternion, &Vector3, &f32)
@[inline]
pub fn quaternion_to_axis_angle(q Quaternion, out_axis &Vector3, out_angle &f32) {
	C.QuaternionToAxisAngle(q, out_axis, out_angle)
}

fn C.QuaternionFromEuler(f32, f32, f32) Quaternion
@[inline]
pub fn quaternion_from_euler(pitch f32, yaw f32, roll f32) Quaternion {
	return C.QuaternionFromEuler(pitch, yaw, roll)
}

fn C.QuaternionToEuler(Quaternion) Vector3
@[inline]
pub fn quaternion_to_euler(q Quaternion) Vector3 {
	return C.QuaternionToEuler(q)
}

fn C.QuaternionTransform(Quaternion, Matrix) Quaternion
@[inline]
pub fn quaternion_transform(q Quaternion, mat Matrix) Quaternion {
	return C.QuaternionTransform(q, mat)
}

fn C.QuaternionEquals(Quaternion, Quaternion) int
@[inline]
pub fn quaternion_equals(p Quaternion, q Quaternion) int {
	return C.QuaternionEquals(p, q)
}

fn C.MatrixDecompose(Matrix, &Vector3, &Quaternion, &Vector3)
@[inline]
pub fn matrix_decompose(mat Matrix, translation &Vector3, rotation &Quaternion, scale &Vector3) {
	C.MatrixDecompose(mat, translation, rotation, scale)
}
