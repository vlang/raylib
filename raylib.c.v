module raylib

pub type Vector2 = C.Vector2

// Vector2, 2 components
pub struct C.Vector2 {
	// Vector x component
	x f32
	// Vector y component
	y f32
}

pub type Vector3 = C.Vector3

// Vector3, 3 components
pub struct C.Vector3 {
	// Vector x component
	x f32
	// Vector y component
	y f32
	// Vector z component
	z f32
}

pub type Vector4 = C.Vector4

// Vector4, 4 components
pub struct C.Vector4 {
	// Vector x component
	x f32
	// Vector y component
	y f32
	// Vector z component
	z f32
	// Vector w component
	w f32
}

pub type Matrix = C.Matrix

// Matrix, 4x4 components, column major, OpenGL style, right-handed
pub struct C.Matrix {
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

pub type Color = C.Color

// Color, 4 components, R8G8B8A8 (32bit)
pub struct C.Color {
	// Color red value
	r u8
	// Color green value
	g u8
	// Color blue value
	b u8
	// Color alpha value
	a u8
}

pub type Rectangle = C.Rectangle

// Rectangle, 4 components
pub struct C.Rectangle {
	// Rectangle top-left corner position x
	x f32
	// Rectangle top-left corner position y
	y f32
	// Rectangle width
	width f32
	// Rectangle height
	height f32
}

pub type Image = C.Image

// Image, pixel data stored in CPU memory (RAM)
pub struct C.Image {
	// Image raw data
	data voidptr
	// Image base width
	width int
	// Image base height
	height int
	// Mipmap levels, 1 by default
	mipmaps int
	// Data format (PixelFormat type)
	format int
}

pub type Texture = C.Texture

// Texture, tex data stored in GPU memory (VRAM)
pub struct C.Texture {
	// OpenGL texture id
	id u32
	// Texture base width
	width int
	// Texture base height
	height int
	// Mipmap levels, 1 by default
	mipmaps int
	// Data format (PixelFormat type)
	format int
}

pub type RenderTexture = C.RenderTexture

// RenderTexture, fbo for texture rendering
pub struct C.RenderTexture {
	// OpenGL framebuffer object id
	id u32
	// Color buffer attachment texture
	texture Texture
	// Depth buffer attachment texture
	depth Texture
}

pub type NPatchInfo = C.NPatchInfo

// NPatchInfo, n-patch layout info
pub struct C.NPatchInfo {
	// Texture source rectangle
	source Rectangle
	// Left border offset
	left int
	// Top border offset
	top int
	// Right border offset
	right int
	// Bottom border offset
	bottom int
	// Layout of the n-patch: 3x3, 1x3 or 3x1
	layout int
}

pub type GlyphInfo = C.GlyphInfo

// GlyphInfo, font characters glyphs info
pub struct C.GlyphInfo {
	// Character value (Unicode)
	value int
	// Character offset X when drawing
	offset_x int
	// Character offset Y when drawing
	offset_y int
	// Character advance position X
	advance_x int
	// Character image data
	image Image
}

pub type Font = C.Font

// Font, font texture and GlyphInfo array data
pub struct C.Font {
	// Base size (default chars height)
	base_size int
	// Number of glyph characters
	glyph_count int
	// Padding around the glyph characters
	glyph_padding int
	// Texture atlas containing the glyphs
	texture Texture2D
	// Rectangles in texture for the glyphs
	recs &Rectangle
	// Glyphs info data
	glyphs &GlyphInfo
}

pub type Camera3D = C.Camera3D

// Camera, defines position/orientation in 3d space
pub struct C.Camera3D {
	// Camera position
	position Vector3
	// Camera target it looks-at
	target Vector3
	// Camera up vector (rotation over its axis)
	up Vector3
	// Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic
	fovy f32
	// Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
	projection int
}

pub type Camera2D = C.Camera2D

// Camera2D, defines position/orientation in 2d space
pub struct C.Camera2D {
	// Camera offset (displacement from target)
	offset Vector2
	// Camera target (rotation and zoom origin)
	target Vector2
	// Camera rotation in degrees
	rotation f32
	// Camera zoom (scaling), should be 1.0f by default
	zoom f32
}

pub type Mesh = C.Mesh

// Mesh, vertex data and vao/vbo
pub struct C.Mesh {
	// Number of vertices stored in arrays
	vertex_count int
	// Number of triangles stored (indexed or not)
	triangle_count int
	// Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
	vertices &f32
	// Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
	texcoords &f32
	// Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
	texcoords2 &f32
	// Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
	normals &f32
	// Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
	tangents &f32
	// Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
	colors &u8
	// Vertex indices (in case vertex data comes indexed)
	indices &u16
	// Animated vertex positions (after bones transformations)
	anim_vertices &f32
	// Animated normals (after bones transformations)
	anim_normals &f32
	// Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning) (shader-location = 6)
	bone_ids &u8
	// Vertex bone weight, up to 4 bones influence by vertex (skinning) (shader-location = 7)
	bone_weights &f32
	// Bones animated transformation matrices
	bone_matrices &Matrix
	// Number of bones
	bone_count int
	// OpenGL Vertex Array Object id
	vao_id u32
	// OpenGL Vertex Buffer Objects id (default vertex data)
	vbo_id &u32
}

pub type Shader = C.Shader

// Shader
pub struct C.Shader {
	// Shader program id
	id u32
	// Shader locations array (RL_MAX_SHADER_LOCATIONS)
	locs &int
}

pub type MaterialMap = C.MaterialMap

// MaterialMap
pub struct C.MaterialMap {
	// Material map texture
	texture Texture2D
	// Material map color
	color Color
	// Material map value
	value f32
}

pub type Material = C.Material

// Material, includes shader and maps
pub struct C.Material {
	// Material shader
	shader Shader
	// Material maps array (MAX_MATERIAL_MAPS)
	maps &MaterialMap
	// Material generic parameters (if required)
	params [4]f32
}

pub type Transform = C.Transform

// Transform, vertex transformation data
pub struct C.Transform {
	// Translation
	translation Vector3
	// Rotation
	rotation Quaternion
	// Scale
	scale Vector3
}

pub type BoneInfo = C.BoneInfo

// Bone, skeletal animation bone
pub struct C.BoneInfo {
	// Bone name
	name [32]char
	// Bone parent
	parent int
}

pub type Model = C.Model

// Model, meshes, materials and animation data
pub struct C.Model {
	// Local transform matrix
	transform Matrix
	// Number of meshes
	mesh_count int
	// Number of materials
	material_count int
	// Meshes array
	meshes &Mesh
	// Materials array
	materials &Material
	// Mesh material number
	mesh_material &int
	// Number of bones
	bone_count int
	// Bones information (skeleton)
	bones &BoneInfo
	// Bones base transformation (pose)
	bind_pose &Transform
}

pub type ModelAnimation = C.ModelAnimation

// ModelAnimation
pub struct C.ModelAnimation {
	// Number of bones
	bone_count int
	// Number of animation frames
	frame_count int
	// Bones information (skeleton)
	bones &BoneInfo
	// Poses array by frame
	frame_poses &&Transform
	// Animation name
	name [32]char
}

pub type Ray = C.Ray

// Ray, ray for raycasting
pub struct C.Ray {
	// Ray position (origin)
	position Vector3
	// Ray direction (normalized)
	direction Vector3
}

pub type RayCollision = C.RayCollision

// RayCollision, ray hit information
pub struct C.RayCollision {
	// Did the ray hit something?
	hit bool
	// Distance to the nearest hit
	distance f32
	// Point of the nearest hit
	point Vector3
	// Surface normal of hit
	normal Vector3
}

pub type BoundingBox = C.BoundingBox

// BoundingBox
pub struct C.BoundingBox {
	// Minimum vertex box-corner
	min Vector3
	// Maximum vertex box-corner
	max Vector3
}

pub type Wave = C.Wave

// Wave, audio wave data
pub struct C.Wave {
	// Total number of frames (considering channels)
	frame_count u32
	// Frequency (samples per second)
	sample_rate u32
	// Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	sample_size u32
	// Number of channels (1-mono, 2-stereo, ...)
	channels u32
	// Buffer data pointer
	data voidptr
}

pub type AudioStream = C.AudioStream

// AudioStream, custom audio stream
pub struct C.AudioStream {
	// Pointer to internal data used by the audio system
	buffer &AudioBuffer
	// Pointer to internal data processor, useful for audio effects
	processor &AudioProcessor
	// Frequency (samples per second)
	sample_rate u32
	// Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	sample_size u32
	// Number of channels (1-mono, 2-stereo, ...)
	channels u32
}

pub type Sound = C.Sound

// Sound
pub struct C.Sound {
	// Audio stream
	stream AudioStream
	// Total number of frames (considering channels)
	frame_count u32
}

pub type Music = C.Music

// Music, audio stream, anything longer than ~10 seconds should be streamed
pub struct C.Music {
	// Audio stream
	stream AudioStream
	// Total number of frames (considering channels)
	frame_count u32
	// Music looping enable
	looping bool
	// Type of music context (audio filetype)
	ctx_type int
	// Audio context data, depends on type
	ctx_data voidptr
}

pub type VrDeviceInfo = C.VrDeviceInfo

// VrDeviceInfo, Head-Mounted-Display device parameters
pub struct C.VrDeviceInfo {
	// Horizontal resolution in pixels
	h_resolution int
	// Vertical resolution in pixels
	v_resolution int
	// Horizontal size in meters
	h_screen_size f32
	// Vertical size in meters
	v_screen_size f32
	// Distance between eye and display in meters
	eye_to_screen_distance f32
	// Lens separation distance in meters
	lens_separation_distance f32
	// IPD (distance between pupils) in meters
	interpupillary_distance f32
	// Lens distortion constant parameters
	lens_distortion_values [4]f32
	// Chromatic aberration correction parameters
	chroma_ab_correction [4]f32
}

pub type VrStereoConfig = C.VrStereoConfig

// VrStereoConfig, VR stereo rendering configuration for simulator
pub struct C.VrStereoConfig {
	// VR projection matrices (per eye)
	projection [2]Matrix
	// VR view offset matrices (per eye)
	view_offset [2]Matrix
	// VR left lens center
	left_lens_center [2]f32
	// VR right lens center
	right_lens_center [2]f32
	// VR left screen center
	left_screen_center [2]f32
	// VR right screen center
	right_screen_center [2]f32
	// VR distortion scale
	scale [2]f32
	// VR distortion scale in
	scale_in [2]f32
}

pub type FilePathList = C.FilePathList

// File path list
pub struct C.FilePathList {
	// Filepaths max entries
	capacity u32
	// Filepaths entries count
	count u32
	// Filepaths entries
	paths &&char
}

pub type AutomationEvent = C.AutomationEvent

// Automation event
pub struct C.AutomationEvent {
	// Event frame
	frame u32
	// Event type (AutomationEventType)
	typ u32
	// Event parameters (if required)
	params [4]int
}

pub type AutomationEventList = C.AutomationEventList

// Automation event list
pub struct C.AutomationEventList {
	// Events max entries (MAX_AUTOMATION_EVENTS)
	capacity u32
	// Events entries count
	count u32
	// Events entries
	events &AutomationEvent
}

// Quaternion, 4 components (Vector4 alias)
pub type Quaternion = C.Vector4

// Texture2D, same as Texture
pub type Texture2D = C.Texture

// TextureCubemap, same as Texture
pub type TextureCubemap = C.Texture

// RenderTexture2D, same as RenderTexture
pub type RenderTexture2D = C.RenderTexture

// Camera type fallback, defaults to Camera3D
pub type Camera = C.Camera3D

// Logging: Redirect trace log messages
pub type TraceLogCallback = fn (int, &char, C.va_list)

// FileIO: Load binary data
pub type LoadFileDataCallback = fn (&char, &int) &u8

// FileIO: Save binary data
pub type SaveFileDataCallback = fn (&char, voidptr, int) bool

// FileIO: Load text data
pub type LoadFileTextCallback = fn (&char) &char

// FileIO: Save text data
pub type SaveFileTextCallback = fn (&char, &char) bool

pub type AudioCallback = fn (voidptr, u32)

// System/Window config flags
@[flag]
pub enum ConfigFlags as u32 {
	flag_vsync_hint               // Set to try enabling V-Sync on GPU
	flag_fullscreen_mode          // Set to run program in fullscreen
	flag_window_resizable         // Set to allow resizable window
	flag_window_undecorated       // Set to disable window decoration (frame and buttons)
	flag_window_hidden            // Set to hide window
	flag_window_minimized         // Set to minimize window (iconify)
	flag_window_maximized         // Set to maximize window (expanded to monitor)
	flag_window_unfocused         // Set to window non focused
	flag_window_topmost           // Set to window always on top
	flag_window_always_run        // Set to allow windows running while minimized
	flag_window_transparent       // Set to allow transparent framebuffer
	flag_window_highdpi           // Set to support HighDPI
	flag_window_mouse_passthrough // Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
	flag_borderless_windowed_mode // Set to run program in borderless windowed mode
	flag_msaa_4x_hint             // Set to try enabling MSAA 4X
	flag_interlaced_hint          // Set to try enabling interlaced video format (for V3D)
}

// Trace log level
pub enum TraceLogLevel {
	log_all     = 0 // Display all logs
	log_trace   = 1 // Trace logging, intended for internal use only
	log_debug   = 2 // Debug logging, used for internal debugging, it should be disabled on release builds
	log_info    = 3 // Info logging, used for program execution info
	log_warning = 4 // Warning logging, used on recoverable failures
	log_error   = 5 // Error logging, used on unrecoverable failures
	log_fatal   = 6 // Fatal logging, used to abort program: exit(EXIT_FAILURE)
	log_none    = 7 // Disable logging
}

// Keyboard keys (US keyboard layout)
pub enum KeyboardKey {
	key_null          = 0   // Key: NULL, used for no key pressed
	key_apostrophe    = 39  // Key: '
	key_comma         = 44  // Key: ,
	key_minus         = 45  // Key: -
	key_period        = 46  // Key: .
	key_slash         = 47  // Key: /
	key_zero          = 48  // Key: 0
	key_one           = 49  // Key: 1
	key_two           = 50  // Key: 2
	key_three         = 51  // Key: 3
	key_four          = 52  // Key: 4
	key_five          = 53  // Key: 5
	key_six           = 54  // Key: 6
	key_seven         = 55  // Key: 7
	key_eight         = 56  // Key: 8
	key_nine          = 57  // Key: 9
	key_semicolon     = 59  // Key: ;
	key_equal         = 61  // Key: =
	key_a             = 65  // Key: A | a
	key_b             = 66  // Key: B | b
	key_c             = 67  // Key: C | c
	key_d             = 68  // Key: D | d
	key_e             = 69  // Key: E | e
	key_f             = 70  // Key: F | f
	key_g             = 71  // Key: G | g
	key_h             = 72  // Key: H | h
	key_i             = 73  // Key: I | i
	key_j             = 74  // Key: J | j
	key_k             = 75  // Key: K | k
	key_l             = 76  // Key: L | l
	key_m             = 77  // Key: M | m
	key_n             = 78  // Key: N | n
	key_o             = 79  // Key: O | o
	key_p             = 80  // Key: P | p
	key_q             = 81  // Key: Q | q
	key_r             = 82  // Key: R | r
	key_s             = 83  // Key: S | s
	key_t             = 84  // Key: T | t
	key_u             = 85  // Key: U | u
	key_v             = 86  // Key: V | v
	key_w             = 87  // Key: W | w
	key_x             = 88  // Key: X | x
	key_y             = 89  // Key: Y | y
	key_z             = 90  // Key: Z | z
	key_left_bracket  = 91  // Key: [
	key_backslash     = 92  // Key: '\'
	key_right_bracket = 93  // Key: ]
	key_grave         = 96  // Key: `
	key_space         = 32  // Key: Space
	key_escape        = 256 // Key: Esc
	key_enter         = 257 // Key: Enter
	key_tab           = 258 // Key: Tab
	key_backspace     = 259 // Key: Backspace
	key_insert        = 260 // Key: Ins
	key_delete        = 261 // Key: Del
	key_right         = 262 // Key: Cursor right
	key_left          = 263 // Key: Cursor left
	key_down          = 264 // Key: Cursor down
	key_up            = 265 // Key: Cursor up
	key_page_up       = 266 // Key: Page up
	key_page_down     = 267 // Key: Page down
	key_home          = 268 // Key: Home
	key_end           = 269 // Key: End
	key_caps_lock     = 280 // Key: Caps lock
	key_scroll_lock   = 281 // Key: Scroll down
	key_num_lock      = 282 // Key: Num lock
	key_print_screen  = 283 // Key: Print screen
	key_pause         = 284 // Key: Pause
	key_f1            = 290 // Key: F1
	key_f2            = 291 // Key: F2
	key_f3            = 292 // Key: F3
	key_f4            = 293 // Key: F4
	key_f5            = 294 // Key: F5
	key_f6            = 295 // Key: F6
	key_f7            = 296 // Key: F7
	key_f8            = 297 // Key: F8
	key_f9            = 298 // Key: F9
	key_f10           = 299 // Key: F10
	key_f11           = 300 // Key: F11
	key_f12           = 301 // Key: F12
	key_left_shift    = 340 // Key: Shift left
	key_left_control  = 341 // Key: Control left
	key_left_alt      = 342 // Key: Alt left
	key_left_super    = 343 // Key: Super left
	key_right_shift   = 344 // Key: Shift right
	key_right_control = 345 // Key: Control right
	key_right_alt     = 346 // Key: Alt right
	key_right_super   = 347 // Key: Super right
	key_kb_menu       = 348 // Key: KB menu
	key_kp_0          = 320 // Key: Keypad 0
	key_kp_1          = 321 // Key: Keypad 1
	key_kp_2          = 322 // Key: Keypad 2
	key_kp_3          = 323 // Key: Keypad 3
	key_kp_4          = 324 // Key: Keypad 4
	key_kp_5          = 325 // Key: Keypad 5
	key_kp_6          = 326 // Key: Keypad 6
	key_kp_7          = 327 // Key: Keypad 7
	key_kp_8          = 328 // Key: Keypad 8
	key_kp_9          = 329 // Key: Keypad 9
	key_kp_decimal    = 330 // Key: Keypad .
	key_kp_divide     = 331 // Key: Keypad /
	key_kp_multiply   = 332 // Key: Keypad *
	key_kp_subtract   = 333 // Key: Keypad -
	key_kp_add        = 334 // Key: Keypad +
	key_kp_enter      = 335 // Key: Keypad Enter
	key_kp_equal      = 336 // Key: Keypad =
	key_back          = 4   // Key: Android back button
	key_menu          = 5   // Key: Android menu button
	key_volume_up     = 24  // Key: Android volume up button
	key_volume_down   = 25  // Key: Android volume down button
}

// Mouse buttons
pub enum MouseButton {
	mouse_button_left    = 0 // Mouse button left
	mouse_button_right   = 1 // Mouse button right
	mouse_button_middle  = 2 // Mouse button middle (pressed wheel)
	mouse_button_side    = 3 // Mouse button side (advanced mouse device)
	mouse_button_extra   = 4 // Mouse button extra (advanced mouse device)
	mouse_button_forward = 5 // Mouse button forward (advanced mouse device)
	mouse_button_back    = 6 // Mouse button back (advanced mouse device)
}

// Mouse cursor
pub enum MouseCursor {
	mouse_cursor_default       = 0  // Default pointer shape
	mouse_cursor_arrow         = 1  // Arrow shape
	mouse_cursor_ibeam         = 2  // Text writing cursor shape
	mouse_cursor_crosshair     = 3  // Cross shape
	mouse_cursor_pointing_hand = 4  // Pointing hand cursor
	mouse_cursor_resize_ew     = 5  // Horizontal resize/move arrow shape
	mouse_cursor_resize_ns     = 6  // Vertical resize/move arrow shape
	mouse_cursor_resize_nwse   = 7  // Top-left to bottom-right diagonal resize/move arrow shape
	mouse_cursor_resize_nesw   = 8  // The top-right to bottom-left diagonal resize/move arrow shape
	mouse_cursor_resize_all    = 9  // The omnidirectional resize/move cursor shape
	mouse_cursor_not_allowed   = 10 // The operation-not-allowed shape
}

// Gamepad buttons
pub enum GamepadButton {
	gamepad_button_unknown          = 0  // Unknown button, just for error checking
	gamepad_button_left_face_up     = 1  // Gamepad left DPAD up button
	gamepad_button_left_face_right  = 2  // Gamepad left DPAD right button
	gamepad_button_left_face_down   = 3  // Gamepad left DPAD down button
	gamepad_button_left_face_left   = 4  // Gamepad left DPAD left button
	gamepad_button_right_face_up    = 5  // Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
	gamepad_button_right_face_right = 6  // Gamepad right button right (i.e. PS3: Circle, Xbox: B)
	gamepad_button_right_face_down  = 7  // Gamepad right button down (i.e. PS3: Cross, Xbox: A)
	gamepad_button_right_face_left  = 8  // Gamepad right button left (i.e. PS3: Square, Xbox: X)
	gamepad_button_left_trigger_1   = 9  // Gamepad top/back trigger left (first), it could be a trailing button
	gamepad_button_left_trigger_2   = 10 // Gamepad top/back trigger left (second), it could be a trailing button
	gamepad_button_right_trigger_1  = 11 // Gamepad top/back trigger right (first), it could be a trailing button
	gamepad_button_right_trigger_2  = 12 // Gamepad top/back trigger right (second), it could be a trailing button
	gamepad_button_middle_left      = 13 // Gamepad center buttons, left one (i.e. PS3: Select)
	gamepad_button_middle           = 14 // Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
	gamepad_button_middle_right     = 15 // Gamepad center buttons, right one (i.e. PS3: Start)
	gamepad_button_left_thumb       = 16 // Gamepad joystick pressed button left
	gamepad_button_right_thumb      = 17 // Gamepad joystick pressed button right
}

// Gamepad axis
pub enum GamepadAxis {
	gamepad_axis_left_x        = 0 // Gamepad left stick X axis
	gamepad_axis_left_y        = 1 // Gamepad left stick Y axis
	gamepad_axis_right_x       = 2 // Gamepad right stick X axis
	gamepad_axis_right_y       = 3 // Gamepad right stick Y axis
	gamepad_axis_left_trigger  = 4 // Gamepad back trigger left, pressure level: [1..-1]
	gamepad_axis_right_trigger = 5 // Gamepad back trigger right, pressure level: [1..-1]
}

// Material map index
pub enum MaterialMapIndex {
	material_map_albedo     = 0  // Albedo material (same as: MATERIAL_MAP_DIFFUSE)
	material_map_metalness  = 1  // Metalness material (same as: MATERIAL_MAP_SPECULAR)
	material_map_normal     = 2  // Normal material
	material_map_roughness  = 3  // Roughness material
	material_map_occlusion  = 4  // Ambient occlusion material
	material_map_emission   = 5  // Emission material
	material_map_height     = 6  // Heightmap material
	material_map_cubemap    = 7  // Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
	material_map_irradiance = 8  // Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
	material_map_prefilter  = 9  // Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
	material_map_brdf       = 10 // Brdf material
}

// Shader location index
pub enum ShaderLocationIndex {
	shader_loc_vertex_position    = 0  // Shader location: vertex attribute: position
	shader_loc_vertex_texcoord01  = 1  // Shader location: vertex attribute: texcoord01
	shader_loc_vertex_texcoord02  = 2  // Shader location: vertex attribute: texcoord02
	shader_loc_vertex_normal      = 3  // Shader location: vertex attribute: normal
	shader_loc_vertex_tangent     = 4  // Shader location: vertex attribute: tangent
	shader_loc_vertex_color       = 5  // Shader location: vertex attribute: color
	shader_loc_matrix_mvp         = 6  // Shader location: matrix uniform: model-view-projection
	shader_loc_matrix_view        = 7  // Shader location: matrix uniform: view (camera transform)
	shader_loc_matrix_projection  = 8  // Shader location: matrix uniform: projection
	shader_loc_matrix_model       = 9  // Shader location: matrix uniform: model (transform)
	shader_loc_matrix_normal      = 10 // Shader location: matrix uniform: normal
	shader_loc_vector_view        = 11 // Shader location: vector uniform: view
	shader_loc_color_diffuse      = 12 // Shader location: vector uniform: diffuse color
	shader_loc_color_specular     = 13 // Shader location: vector uniform: specular color
	shader_loc_color_ambient      = 14 // Shader location: vector uniform: ambient color
	shader_loc_map_albedo         = 15 // Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
	shader_loc_map_metalness      = 16 // Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
	shader_loc_map_normal         = 17 // Shader location: sampler2d texture: normal
	shader_loc_map_roughness      = 18 // Shader location: sampler2d texture: roughness
	shader_loc_map_occlusion      = 19 // Shader location: sampler2d texture: occlusion
	shader_loc_map_emission       = 20 // Shader location: sampler2d texture: emission
	shader_loc_map_height         = 21 // Shader location: sampler2d texture: height
	shader_loc_map_cubemap        = 22 // Shader location: samplerCube texture: cubemap
	shader_loc_map_irradiance     = 23 // Shader location: samplerCube texture: irradiance
	shader_loc_map_prefilter      = 24 // Shader location: samplerCube texture: prefilter
	shader_loc_map_brdf           = 25 // Shader location: sampler2d texture: brdf
	shader_loc_vertex_boneids     = 26 // Shader location: vertex attribute: boneIds
	shader_loc_vertex_boneweights = 27 // Shader location: vertex attribute: boneWeights
	shader_loc_bone_matrices      = 28 // Shader location: array of matrices uniform: boneMatrices
}

// Shader uniform data type
pub enum ShaderUniformDataType {
	shader_uniform_float     = 0 // Shader uniform type: float
	shader_uniform_vec2      = 1 // Shader uniform type: vec2 (2 float)
	shader_uniform_vec3      = 2 // Shader uniform type: vec3 (3 float)
	shader_uniform_vec4      = 3 // Shader uniform type: vec4 (4 float)
	shader_uniform_int       = 4 // Shader uniform type: int
	shader_uniform_ivec2     = 5 // Shader uniform type: ivec2 (2 int)
	shader_uniform_ivec3     = 6 // Shader uniform type: ivec3 (3 int)
	shader_uniform_ivec4     = 7 // Shader uniform type: ivec4 (4 int)
	shader_uniform_sampler2d = 8 // Shader uniform type: sampler2d
}

// Shader attribute data types
pub enum ShaderAttributeDataType {
	shader_attrib_float = 0 // Shader attribute type: float
	shader_attrib_vec2  = 1 // Shader attribute type: vec2 (2 float)
	shader_attrib_vec3  = 2 // Shader attribute type: vec3 (3 float)
	shader_attrib_vec4  = 3 // Shader attribute type: vec4 (4 float)
}

// Pixel formats
pub enum PixelFormat {
	pixelformat_uncompressed_grayscale    = 1  // 8 bit per pixel (no alpha)
	pixelformat_uncompressed_gray_alpha   = 2  // 8*2 bpp (2 channels)
	pixelformat_uncompressed_r5g6b5       = 3  // 16 bpp
	pixelformat_uncompressed_r8g8b8       = 4  // 24 bpp
	pixelformat_uncompressed_r5g5b5a1     = 5  // 16 bpp (1 bit alpha)
	pixelformat_uncompressed_r4g4b4a4     = 6  // 16 bpp (4 bit alpha)
	pixelformat_uncompressed_r8g8b8a8     = 7  // 32 bpp
	pixelformat_uncompressed_r32          = 8  // 32 bpp (1 channel - float)
	pixelformat_uncompressed_r32g32b32    = 9  // 32*3 bpp (3 channels - float)
	pixelformat_uncompressed_r32g32b32a32 = 10 // 32*4 bpp (4 channels - float)
	pixelformat_uncompressed_r16          = 11 // 16 bpp (1 channel - half float)
	pixelformat_uncompressed_r16g16b16    = 12 // 16*3 bpp (3 channels - half float)
	pixelformat_uncompressed_r16g16b16a16 = 13 // 16*4 bpp (4 channels - half float)
	pixelformat_compressed_dxt1_rgb       = 14 // 4 bpp (no alpha)
	pixelformat_compressed_dxt1_rgba      = 15 // 4 bpp (1 bit alpha)
	pixelformat_compressed_dxt3_rgba      = 16 // 8 bpp
	pixelformat_compressed_dxt5_rgba      = 17 // 8 bpp
	pixelformat_compressed_etc1_rgb       = 18 // 4 bpp
	pixelformat_compressed_etc2_rgb       = 19 // 4 bpp
	pixelformat_compressed_etc2_eac_rgba  = 20 // 8 bpp
	pixelformat_compressed_pvrt_rgb       = 21 // 4 bpp
	pixelformat_compressed_pvrt_rgba      = 22 // 4 bpp
	pixelformat_compressed_astc_4x4_rgba  = 23 // 8 bpp
	pixelformat_compressed_astc_8x8_rgba  = 24 // 2 bpp
}

// Texture parameters: filter mode
pub enum TextureFilter {
	texture_filter_point           = 0 // No filter, just pixel approximation
	texture_filter_bilinear        = 1 // Linear filtering
	texture_filter_trilinear       = 2 // Trilinear filtering (linear with mipmaps)
	texture_filter_anisotropic_4x  = 3 // Anisotropic filtering 4x
	texture_filter_anisotropic_8x  = 4 // Anisotropic filtering 8x
	texture_filter_anisotropic_16x = 5 // Anisotropic filtering 16x
}

// Texture parameters: wrap mode
pub enum TextureWrap {
	texture_wrap_repeat        = 0 // Repeats texture in tiled mode
	texture_wrap_clamp         = 1 // Clamps texture to edge pixel in tiled mode
	texture_wrap_mirror_repeat = 2 // Mirrors and repeats the texture in tiled mode
	texture_wrap_mirror_clamp  = 3 // Mirrors and clamps to border the texture in tiled mode
}

// Cubemap layouts
pub enum CubemapLayout {
	cubemap_layout_auto_detect         = 0 // Automatically detect layout type
	cubemap_layout_line_vertical       = 1 // Layout is defined by a vertical line with faces
	cubemap_layout_line_horizontal     = 2 // Layout is defined by a horizontal line with faces
	cubemap_layout_cross_three_by_four = 3 // Layout is defined by a 3x4 cross with cubemap faces
	cubemap_layout_cross_four_by_three = 4 // Layout is defined by a 4x3 cross with cubemap faces
}

// Font type, defines generation method
pub enum FontType {
	font_default = 0 // Default font generation, anti-aliased
	font_bitmap  = 1 // Bitmap font generation, no anti-aliasing
	font_sdf     = 2 // SDF font generation, requires external shader
}

// Color blending modes (pre-defined)
pub enum BlendMode {
	blend_alpha             = 0 // Blend textures considering alpha (default)
	blend_additive          = 1 // Blend textures adding colors
	blend_multiplied        = 2 // Blend textures multiplying colors
	blend_add_colors        = 3 // Blend textures adding colors (alternative)
	blend_subtract_colors   = 4 // Blend textures subtracting colors (alternative)
	blend_alpha_premultiply = 5 // Blend premultiplied textures considering alpha
	blend_custom            = 6 // Blend textures using custom src/dst factors (use rlSetBlendFactors())
	blend_custom_separate   = 7 // Blend textures using custom rgb/alpha separate src/dst factors (use rlSetBlendFactorsSeparate())
}

// Gesture
@[flag]
pub enum Gesture as u32 {
	gesture_none        // No gesture
	gesture_tap         // Tap gesture
	gesture_doubletap   // Double tap gesture
	gesture_hold        // Hold gesture
	gesture_drag        // Drag gesture
	gesture_swipe_right // Swipe right gesture
	gesture_swipe_left  // Swipe left gesture
	gesture_swipe_up    // Swipe up gesture
	gesture_swipe_down  // Swipe down gesture
	gesture_pinch_in    // Pinch in gesture
	gesture_pinch_out   // Pinch out gesture
}

// Camera system modes
pub enum CameraMode {
	camera_custom       = 0 // Camera custom, controlled by user (UpdateCamera() does nothing)
	camera_free         = 1 // Camera free mode
	camera_orbital      = 2 // Camera orbital, around target, zoom supported
	camera_first_person = 3 // Camera first person
	camera_third_person = 4 // Camera third person
}

// Camera projection
pub enum CameraProjection {
	camera_perspective  = 0 // Perspective projection
	camera_orthographic = 1 // Orthographic projection
}

// N-patch layout
pub enum NPatchLayout {
	npatch_nine_patch             = 0 // Npatch layout: 3x3 tiles
	npatch_three_patch_vertical   = 1 // Npatch layout: 1x3 tiles
	npatch_three_patch_horizontal = 2 // Npatch layout: 3x1 tiles
}

fn C.InitWindow(int, int, &char)

// Initialize window and OpenGL context
@[inline]
pub fn init_window(width int, height int, title string) {
	C.InitWindow(width, height, title.str)
}

fn C.CloseWindow()

// Close window and unload OpenGL context
@[inline]
pub fn close_window() {
	C.CloseWindow()
}

fn C.WindowShouldClose() bool

// Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
@[inline]
pub fn window_should_close() bool {
	return C.WindowShouldClose()
}

fn C.IsWindowReady() bool

// Check if window has been initialized successfully
@[inline]
pub fn is_window_ready() bool {
	return C.IsWindowReady()
}

fn C.IsWindowFullscreen() bool

// Check if window is currently fullscreen
@[inline]
pub fn is_window_fullscreen() bool {
	return C.IsWindowFullscreen()
}

fn C.IsWindowHidden() bool

// Check if window is currently hidden
@[inline]
pub fn is_window_hidden() bool {
	return C.IsWindowHidden()
}

fn C.IsWindowMinimized() bool

// Check if window is currently minimized
@[inline]
pub fn is_window_minimized() bool {
	return C.IsWindowMinimized()
}

fn C.IsWindowMaximized() bool

// Check if window is currently maximized
@[inline]
pub fn is_window_maximized() bool {
	return C.IsWindowMaximized()
}

fn C.IsWindowFocused() bool

// Check if window is currently focused
@[inline]
pub fn is_window_focused() bool {
	return C.IsWindowFocused()
}

fn C.IsWindowResized() bool

// Check if window has been resized last frame
@[inline]
pub fn is_window_resized() bool {
	return C.IsWindowResized()
}

fn C.IsWindowState(ConfigFlags) bool

// Check if one specific window flag is enabled
@[inline]
pub fn is_window_state(flag ConfigFlags) bool {
	return C.IsWindowState(flag)
}

fn C.SetWindowState(ConfigFlags)

// Set window configuration state using flags
@[inline]
pub fn set_window_state(flags ConfigFlags) {
	C.SetWindowState(flags)
}

fn C.ClearWindowState(ConfigFlags)

// Clear window configuration state flags
@[inline]
pub fn clear_window_state(flags ConfigFlags) {
	C.ClearWindowState(flags)
}

fn C.ToggleFullscreen()

// Toggle window state: fullscreen/windowed, resizes monitor to match window resolution
@[inline]
pub fn toggle_fullscreen() {
	C.ToggleFullscreen()
}

fn C.ToggleBorderlessWindowed()

// Toggle window state: borderless windowed, resizes window to match monitor resolution
@[inline]
pub fn toggle_borderless_windowed() {
	C.ToggleBorderlessWindowed()
}

fn C.MaximizeWindow()

// Set window state: maximized, if resizable
@[inline]
pub fn maximize_window() {
	C.MaximizeWindow()
}

fn C.MinimizeWindow()

// Set window state: minimized, if resizable
@[inline]
pub fn minimize_window() {
	C.MinimizeWindow()
}

fn C.RestoreWindow()

// Set window state: not minimized/maximized
@[inline]
pub fn restore_window() {
	C.RestoreWindow()
}

fn C.SetWindowIcon(Image)

// Set icon for window (single image, RGBA 32bit)
@[inline]
pub fn set_window_icon(image Image) {
	C.SetWindowIcon(image)
}

fn C.SetWindowIcons(&Image, int)

// Set icon for window (multiple images, RGBA 32bit)
@[inline]
pub fn set_window_icons(images &Image, count int) {
	C.SetWindowIcons(images, count)
}

fn C.SetWindowTitle(&char)

// Set title for window
@[inline]
pub fn set_window_title(title string) {
	C.SetWindowTitle(title.str)
}

fn C.SetWindowPosition(int, int)

// Set window position on screen
@[inline]
pub fn set_window_position(x int, y int) {
	C.SetWindowPosition(x, y)
}

fn C.SetWindowMonitor(int)

// Set monitor for the current window
@[inline]
pub fn set_window_monitor(monitor int) {
	C.SetWindowMonitor(monitor)
}

fn C.SetWindowMinSize(int, int)

// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
@[inline]
pub fn set_window_min_size(width int, height int) {
	C.SetWindowMinSize(width, height)
}

fn C.SetWindowMaxSize(int, int)

// Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
@[inline]
pub fn set_window_max_size(width int, height int) {
	C.SetWindowMaxSize(width, height)
}

fn C.SetWindowSize(int, int)

// Set window dimensions
@[inline]
pub fn set_window_size(width int, height int) {
	C.SetWindowSize(width, height)
}

fn C.SetWindowOpacity(f32)

// Set window opacity [0.0f..1.0f]
@[inline]
pub fn set_window_opacity(opacity f32) {
	C.SetWindowOpacity(opacity)
}

fn C.SetWindowFocused()

// Set window focused
@[inline]
pub fn set_window_focused() {
	C.SetWindowFocused()
}

fn C.GetWindowHandle() voidptr

// Get native window handle
@[inline]
pub fn get_window_handle() voidptr {
	return C.GetWindowHandle()
}

fn C.GetScreenWidth() int

// Get current screen width
@[inline]
pub fn get_screen_width() int {
	return C.GetScreenWidth()
}

fn C.GetScreenHeight() int

// Get current screen height
@[inline]
pub fn get_screen_height() int {
	return C.GetScreenHeight()
}

fn C.GetRenderWidth() int

// Get current render width (it considers HiDPI)
@[inline]
pub fn get_render_width() int {
	return C.GetRenderWidth()
}

fn C.GetRenderHeight() int

// Get current render height (it considers HiDPI)
@[inline]
pub fn get_render_height() int {
	return C.GetRenderHeight()
}

fn C.GetMonitorCount() int

// Get number of connected monitors
@[inline]
pub fn get_monitor_count() int {
	return C.GetMonitorCount()
}

fn C.GetCurrentMonitor() int

// Get current monitor where window is placed
@[inline]
pub fn get_current_monitor() int {
	return C.GetCurrentMonitor()
}

fn C.GetMonitorPosition(int) Vector2

// Get specified monitor position
@[inline]
pub fn get_monitor_position(monitor int) Vector2 {
	return C.GetMonitorPosition(monitor)
}

fn C.GetMonitorWidth(int) int

// Get specified monitor width (current video mode used by monitor)
@[inline]
pub fn get_monitor_width(monitor int) int {
	return C.GetMonitorWidth(monitor)
}

fn C.GetMonitorHeight(int) int

// Get specified monitor height (current video mode used by monitor)
@[inline]
pub fn get_monitor_height(monitor int) int {
	return C.GetMonitorHeight(monitor)
}

fn C.GetMonitorPhysicalWidth(int) int

// Get specified monitor physical width in millimetres
@[inline]
pub fn get_monitor_physical_width(monitor int) int {
	return C.GetMonitorPhysicalWidth(monitor)
}

fn C.GetMonitorPhysicalHeight(int) int

// Get specified monitor physical height in millimetres
@[inline]
pub fn get_monitor_physical_height(monitor int) int {
	return C.GetMonitorPhysicalHeight(monitor)
}

fn C.GetMonitorRefreshRate(int) int

// Get specified monitor refresh rate
@[inline]
pub fn get_monitor_refresh_rate(monitor int) int {
	return C.GetMonitorRefreshRate(monitor)
}

fn C.GetWindowPosition() Vector2

// Get window position XY on monitor
@[inline]
pub fn get_window_position() Vector2 {
	return C.GetWindowPosition()
}

fn C.GetWindowScaleDPI() Vector2

// Get window scale DPI factor
@[inline]
pub fn get_window_scale_dpi() Vector2 {
	return C.GetWindowScaleDPI()
}

fn C.GetMonitorName(int) &char

// Get the human-readable, UTF-8 encoded name of the specified monitor
@[inline]
pub fn get_monitor_name(monitor int) string {
	unsafe {
		return C.GetMonitorName(monitor).vstring()
	}
}

fn C.SetClipboardText(&char)

// Set clipboard text content
@[inline]
pub fn set_clipboard_text(text string) {
	C.SetClipboardText(text.str)
}

fn C.GetClipboardText() &char

// Get clipboard text content
@[inline]
pub fn get_clipboard_text() string {
	unsafe {
		return C.GetClipboardText().vstring()
	}
}

fn C.GetClipboardImage() Image

// Get clipboard image content
@[inline]
pub fn get_clipboard_image() Image {
	return C.GetClipboardImage()
}

fn C.EnableEventWaiting()

// Enable waiting for events on EndDrawing(), no automatic event polling
@[inline]
pub fn enable_event_waiting() {
	C.EnableEventWaiting()
}

fn C.DisableEventWaiting()

// Disable waiting for events on EndDrawing(), automatic events polling
@[inline]
pub fn disable_event_waiting() {
	C.DisableEventWaiting()
}

fn C.ShowCursor()

// Shows cursor
@[inline]
pub fn show_cursor() {
	C.ShowCursor()
}

fn C.HideCursor()

// Hides cursor
@[inline]
pub fn hide_cursor() {
	C.HideCursor()
}

fn C.IsCursorHidden() bool

// Check if cursor is not visible
@[inline]
pub fn is_cursor_hidden() bool {
	return C.IsCursorHidden()
}

fn C.EnableCursor()

// Enables cursor (unlock cursor)
@[inline]
pub fn enable_cursor() {
	C.EnableCursor()
}

fn C.DisableCursor()

// Disables cursor (lock cursor)
@[inline]
pub fn disable_cursor() {
	C.DisableCursor()
}

fn C.IsCursorOnScreen() bool

// Check if cursor is on the screen
@[inline]
pub fn is_cursor_on_screen() bool {
	return C.IsCursorOnScreen()
}

fn C.ClearBackground(Color)

// Set background color (framebuffer clear color)
@[inline]
pub fn clear_background(color Color) {
	C.ClearBackground(color)
}

fn C.BeginDrawing()

// Setup canvas (framebuffer) to start drawing
@[inline]
pub fn begin_drawing() {
	C.BeginDrawing()
}

fn C.EndDrawing()

// End canvas drawing and swap buffers (double buffering)
@[inline]
pub fn end_drawing() {
	C.EndDrawing()
}

fn C.BeginMode2D(Camera2D)

// Begin 2D mode with custom camera (2D)
@[inline]
pub fn begin_mode_2d(camera Camera2D) {
	C.BeginMode2D(camera)
}

fn C.EndMode2D()

// Ends 2D mode with custom camera
@[inline]
pub fn end_mode_2d() {
	C.EndMode2D()
}

fn C.BeginMode3D(Camera3D)

// Begin 3D mode with custom camera (3D)
@[inline]
pub fn begin_mode_3d(camera Camera3D) {
	C.BeginMode3D(camera)
}

fn C.EndMode3D()

// Ends 3D mode and returns to default 2D orthographic mode
@[inline]
pub fn end_mode_3d() {
	C.EndMode3D()
}

fn C.BeginTextureMode(RenderTexture2D)

// Begin drawing to render texture
@[inline]
pub fn begin_texture_mode(target RenderTexture2D) {
	C.BeginTextureMode(target)
}

fn C.EndTextureMode()

// Ends drawing to render texture
@[inline]
pub fn end_texture_mode() {
	C.EndTextureMode()
}

fn C.BeginShaderMode(Shader)

// Begin custom shader drawing
@[inline]
pub fn begin_shader_mode(shader Shader) {
	C.BeginShaderMode(shader)
}

fn C.EndShaderMode()

// End custom shader drawing (use default shader)
@[inline]
pub fn end_shader_mode() {
	C.EndShaderMode()
}

fn C.BeginBlendMode(int)

// Begin blending mode (alpha, additive, multiplied, subtract, custom)
@[inline]
pub fn begin_blend_mode(mode int) {
	C.BeginBlendMode(mode)
}

fn C.EndBlendMode()

// End blending mode (reset to default: alpha blending)
@[inline]
pub fn end_blend_mode() {
	C.EndBlendMode()
}

fn C.BeginScissorMode(int, int, int, int)

// Begin scissor mode (define screen area for following drawing)
@[inline]
pub fn begin_scissor_mode(x int, y int, width int, height int) {
	C.BeginScissorMode(x, y, width, height)
}

fn C.EndScissorMode()

// End scissor mode
@[inline]
pub fn end_scissor_mode() {
	C.EndScissorMode()
}

fn C.BeginVrStereoMode(VrStereoConfig)

// Begin stereo rendering (requires VR simulator)
@[inline]
pub fn begin_vr_stereo_mode(config VrStereoConfig) {
	C.BeginVrStereoMode(config)
}

fn C.EndVrStereoMode()

// End stereo rendering (requires VR simulator)
@[inline]
pub fn end_vr_stereo_mode() {
	C.EndVrStereoMode()
}

fn C.LoadVrStereoConfig(VrDeviceInfo) VrStereoConfig

// Load VR stereo config for VR simulator device parameters
@[inline]
pub fn load_vr_stereo_config(device VrDeviceInfo) VrStereoConfig {
	return C.LoadVrStereoConfig(device)
}

fn C.UnloadVrStereoConfig(VrStereoConfig)

// Unload VR stereo config
@[inline]
pub fn unload_vr_stereo_config(config VrStereoConfig) {
	C.UnloadVrStereoConfig(config)
}

fn C.LoadShader(&char, &char) Shader

// Load shader from files and bind default locations
@[inline]
pub fn load_shader(vs_file_name string, fs_file_name string) Shader {
	return C.LoadShader(vs_file_name.str, fs_file_name.str)
}

fn C.LoadShaderFromMemory(&char, &char) Shader

// Load shader from code strings and bind default locations
@[inline]
pub fn load_shader_from_memory(vs_code string, fs_code string) Shader {
	return C.LoadShaderFromMemory(vs_code.str, fs_code.str)
}

fn C.IsShaderValid(Shader) bool

// Check if a shader is valid (loaded on GPU)
@[inline]
pub fn is_shader_valid(shader Shader) bool {
	return C.IsShaderValid(shader)
}

fn C.GetShaderLocation(Shader, &char) int

// Get shader uniform location
@[inline]
pub fn get_shader_location(shader Shader, uniform_name string) int {
	return C.GetShaderLocation(shader, uniform_name.str)
}

fn C.GetShaderLocationAttrib(Shader, &char) int

// Get shader attribute location
@[inline]
pub fn get_shader_location_attrib(shader Shader, attrib_name string) int {
	return C.GetShaderLocationAttrib(shader, attrib_name.str)
}

fn C.SetShaderValue(Shader, int, voidptr, int)

// Set shader uniform value
@[inline]
pub fn set_shader_value(shader Shader, loc_index int, value voidptr, uniform_type int) {
	C.SetShaderValue(shader, loc_index, value, uniform_type)
}

fn C.SetShaderValueV(Shader, int, voidptr, int, int)

// Set shader uniform value vector
@[inline]
pub fn set_shader_value_v(shader Shader, loc_index int, value voidptr, uniform_type int, count int) {
	C.SetShaderValueV(shader, loc_index, value, uniform_type, count)
}

fn C.SetShaderValueMatrix(Shader, int, Matrix)

// Set shader uniform value (matrix 4x4)
@[inline]
pub fn set_shader_value_matrix(shader Shader, loc_index int, mat Matrix) {
	C.SetShaderValueMatrix(shader, loc_index, mat)
}

fn C.SetShaderValueTexture(Shader, int, Texture2D)

// Set shader uniform value for texture (sampler2d)
@[inline]
pub fn set_shader_value_texture(shader Shader, loc_index int, texture Texture2D) {
	C.SetShaderValueTexture(shader, loc_index, texture)
}

fn C.UnloadShader(Shader)

// Unload shader from GPU memory (VRAM)
@[inline]
pub fn unload_shader(shader Shader) {
	C.UnloadShader(shader)
}

fn C.GetScreenToWorldRay(Vector2, Camera) Ray

// Get a ray trace from screen position (i.e mouse)
@[inline]
pub fn get_screen_to_world_ray(position Vector2, camera Camera) Ray {
	return C.GetScreenToWorldRay(position, camera)
}

fn C.GetScreenToWorldRayEx(Vector2, Camera, int, int) Ray

// Get a ray trace from screen position (i.e mouse) in a viewport
@[inline]
pub fn get_screen_to_world_ray_ex(position Vector2, camera Camera, width int, height int) Ray {
	return C.GetScreenToWorldRayEx(position, camera, width, height)
}

fn C.GetWorldToScreen(Vector3, Camera) Vector2

// Get the screen space position for a 3d world space position
@[inline]
pub fn get_world_to_screen(position Vector3, camera Camera) Vector2 {
	return C.GetWorldToScreen(position, camera)
}

fn C.GetWorldToScreenEx(Vector3, Camera, int, int) Vector2

// Get size position for a 3d world space position
@[inline]
pub fn get_world_to_screen_ex(position Vector3, camera Camera, width int, height int) Vector2 {
	return C.GetWorldToScreenEx(position, camera, width, height)
}

fn C.GetWorldToScreen2D(Vector2, Camera2D) Vector2

// Get the screen space position for a 2d camera world space position
@[inline]
pub fn get_world_to_screen_2d(position Vector2, camera Camera2D) Vector2 {
	return C.GetWorldToScreen2D(position, camera)
}

fn C.GetScreenToWorld2D(Vector2, Camera2D) Vector2

// Get the world space position for a 2d camera screen space position
@[inline]
pub fn get_screen_to_world_2d(position Vector2, camera Camera2D) Vector2 {
	return C.GetScreenToWorld2D(position, camera)
}

fn C.GetCameraMatrix(Camera) Matrix

// Get camera transform matrix (view matrix)
@[inline]
pub fn get_camera_matrix(camera Camera) Matrix {
	return C.GetCameraMatrix(camera)
}

fn C.GetCameraMatrix2D(Camera2D) Matrix

// Get camera 2d transform matrix
@[inline]
pub fn get_camera_matrix_2d(camera Camera2D) Matrix {
	return C.GetCameraMatrix2D(camera)
}

fn C.SetTargetFPS(int)

// Set target FPS (maximum)
@[inline]
pub fn set_target_fps(fps int) {
	C.SetTargetFPS(fps)
}

fn C.GetFrameTime() f32

// Get time in seconds for last frame drawn (delta time)
@[inline]
pub fn get_frame_time() f32 {
	return C.GetFrameTime()
}

fn C.GetTime() f64

// Get elapsed time in seconds since InitWindow()
@[inline]
pub fn get_time() f64 {
	return C.GetTime()
}

fn C.GetFPS() int

// Get current FPS
@[inline]
pub fn get_fps() int {
	return C.GetFPS()
}

fn C.SwapScreenBuffer()

// Swap back buffer with front buffer (screen drawing)
@[inline]
pub fn swap_screen_buffer() {
	C.SwapScreenBuffer()
}

fn C.PollInputEvents()

// Register all input events
@[inline]
pub fn poll_input_events() {
	C.PollInputEvents()
}

fn C.WaitTime(f64)

// Wait for some time (halt program execution)
@[inline]
pub fn wait_time(seconds f64) {
	C.WaitTime(seconds)
}

fn C.SetRandomSeed(u32)

// Set the seed for the random number generator
@[inline]
pub fn set_random_seed(seed u32) {
	C.SetRandomSeed(seed)
}

fn C.GetRandomValue(int, int) int

// Get a random value between min and max (both included)
@[inline]
pub fn get_random_value(min int, max int) int {
	return C.GetRandomValue(min, max)
}

fn C.LoadRandomSequence(u32, int, int) &int

// Load random values sequence, no values repeated
@[inline]
pub fn load_random_sequence(count u32, min int, max int) &int {
	return C.LoadRandomSequence(count, min, max)
}

fn C.UnloadRandomSequence(&int)

// Unload random values sequence
@[inline]
pub fn unload_random_sequence(sequence &int) {
	C.UnloadRandomSequence(sequence)
}

fn C.TakeScreenshot(&char)

// Takes a screenshot of current screen (filename extension defines format)
@[inline]
pub fn take_screenshot(file_name string) {
	C.TakeScreenshot(file_name.str)
}

fn C.SetConfigFlags(ConfigFlags)

// Setup init configuration flags (view FLAGS)
@[inline]
pub fn set_config_flags(flags ConfigFlags) {
	C.SetConfigFlags(flags)
}

fn C.OpenURL(&char)

// Open URL with default system browser (if available)
@[inline]
pub fn open_url(url string) {
	C.OpenURL(url.str)
}

fn C.TraceLog(int, &char, ...TraceLogLevel)

// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
@[inline]
pub fn trace_log(log_level int, text string, args ...TraceLogLevel) {
	C.TraceLog(log_level, text.str, ...args)
}

fn C.SetTraceLogLevel(int)

// Set the current threshold (minimum) log level
@[inline]
pub fn set_trace_log_level(log_level int) {
	C.SetTraceLogLevel(log_level)
}

fn C.MemAlloc(u32) voidptr

// Internal memory allocator
@[inline]
pub fn mem_alloc(size u32) voidptr {
	return C.MemAlloc(size)
}

fn C.MemRealloc(voidptr, u32) voidptr

// Internal memory reallocator
@[inline]
pub fn mem_realloc(ptr voidptr, size u32) voidptr {
	return C.MemRealloc(ptr, size)
}

fn C.MemFree(voidptr)

// Internal memory free
@[inline]
pub fn mem_free(ptr voidptr) {
	C.MemFree(ptr)
}

fn C.SetTraceLogCallback(TraceLogCallback)

// Set custom trace log
@[inline]
pub fn set_trace_log_callback(callback TraceLogCallback) {
	C.SetTraceLogCallback(callback)
}

fn C.SetLoadFileDataCallback(LoadFileDataCallback)

// Set custom file binary data loader
@[inline]
pub fn set_load_file_data_callback(callback LoadFileDataCallback) {
	C.SetLoadFileDataCallback(callback)
}

fn C.SetSaveFileDataCallback(SaveFileDataCallback)

// Set custom file binary data saver
@[inline]
pub fn set_save_file_data_callback(callback SaveFileDataCallback) {
	C.SetSaveFileDataCallback(callback)
}

fn C.SetLoadFileTextCallback(LoadFileTextCallback)

// Set custom file text data loader
@[inline]
pub fn set_load_file_text_callback(callback LoadFileTextCallback) {
	C.SetLoadFileTextCallback(callback)
}

fn C.SetSaveFileTextCallback(SaveFileTextCallback)

// Set custom file text data saver
@[inline]
pub fn set_save_file_text_callback(callback SaveFileTextCallback) {
	C.SetSaveFileTextCallback(callback)
}

fn C.LoadFileData(&char, &int) &u8

// Load file data as byte array (read)
@[inline]
pub fn load_file_data(file_name string, data_size &int) &u8 {
	return C.LoadFileData(file_name.str, data_size)
}

fn C.UnloadFileData(&u8)

// Unload file data allocated by LoadFileData()
@[inline]
pub fn unload_file_data(data &u8) {
	C.UnloadFileData(data)
}

fn C.SaveFileData(&char, voidptr, int) bool

// Save data to file from byte array (write), returns true on success
@[inline]
pub fn save_file_data(file_name string, data voidptr, data_size int) bool {
	return C.SaveFileData(file_name.str, data, data_size)
}

fn C.ExportDataAsCode(&u8, int, &char) bool

// Export data to code (.h), returns true on success
@[inline]
pub fn export_data_as_code(data &u8, data_size int, file_name string) bool {
	return C.ExportDataAsCode(data, data_size, file_name.str)
}

fn C.LoadFileText(&char) &char

// Load text data from file (read), returns a '\0' terminated string
@[inline]
pub fn load_file_text(file_name string) string {
	unsafe {
		return C.LoadFileText(file_name.str).vstring()
	}
}

fn C.UnloadFileText(&char)

// Unload file text data allocated by LoadFileText()
@[inline]
pub fn unload_file_text(text string) {
	C.UnloadFileText(text.str)
}

fn C.SaveFileText(&char, &char) bool

// Save text data to file (write), string must be '\0' terminated, returns true on success
@[inline]
pub fn save_file_text(file_name string, text string) bool {
	return C.SaveFileText(file_name.str, text.str)
}

fn C.FileExists(&char) bool

// Check if file exists
@[inline]
pub fn file_exists(file_name string) bool {
	return C.FileExists(file_name.str)
}

fn C.DirectoryExists(&char) bool

// Check if a directory path exists
@[inline]
pub fn directory_exists(dir_path string) bool {
	return C.DirectoryExists(dir_path.str)
}

fn C.IsFileExtension(&char, &char) bool

// Check file extension (including point: .png, .wav)
@[inline]
pub fn is_file_extension(file_name string, ext string) bool {
	return C.IsFileExtension(file_name.str, ext.str)
}

fn C.GetFileLength(&char) int

// Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
@[inline]
pub fn get_file_length(file_name string) int {
	return C.GetFileLength(file_name.str)
}

fn C.GetFileExtension(&char) &char

// Get pointer to extension for a filename string (includes dot: '.png')
@[inline]
pub fn get_file_extension(file_name string) string {
	unsafe {
		return C.GetFileExtension(file_name.str).vstring()
	}
}

fn C.GetFileName(&char) &char

// Get pointer to filename for a path string
@[inline]
pub fn get_file_name(file_path string) string {
	unsafe {
		return C.GetFileName(file_path.str).vstring()
	}
}

fn C.GetFileNameWithoutExt(&char) &char

// Get filename string without extension (uses static string)
@[inline]
pub fn get_file_name_without_ext(file_path string) string {
	unsafe {
		return C.GetFileNameWithoutExt(file_path.str).vstring()
	}
}

fn C.GetDirectoryPath(&char) &char

// Get full path for a given fileName with path (uses static string)
@[inline]
pub fn get_directory_path(file_path string) string {
	unsafe {
		return C.GetDirectoryPath(file_path.str).vstring()
	}
}

fn C.GetPrevDirectoryPath(&char) &char

// Get previous directory path for a given path (uses static string)
@[inline]
pub fn get_prev_directory_path(dir_path string) string {
	unsafe {
		return C.GetPrevDirectoryPath(dir_path.str).vstring()
	}
}

fn C.GetWorkingDirectory() &char

// Get current working directory (uses static string)
@[inline]
pub fn get_working_directory() string {
	unsafe {
		return C.GetWorkingDirectory().vstring()
	}
}

fn C.GetApplicationDirectory() &char

// Get the directory of the running application (uses static string)
@[inline]
pub fn get_application_directory() string {
	unsafe {
		return C.GetApplicationDirectory().vstring()
	}
}

fn C.MakeDirectory(&char) int

// Create directories (including full path requested), returns 0 on success
@[inline]
pub fn make_directory(dir_path string) int {
	return C.MakeDirectory(dir_path.str)
}

fn C.ChangeDirectory(&char) bool

// Change working directory, return true on success
@[inline]
pub fn change_directory(dir string) bool {
	return C.ChangeDirectory(dir.str)
}

fn C.IsPathFile(&char) bool

// Check if a given path is a file or a directory
@[inline]
pub fn is_path_file(path string) bool {
	return C.IsPathFile(path.str)
}

fn C.IsFileNameValid(&char) bool

// Check if fileName is valid for the platform/OS
@[inline]
pub fn is_file_name_valid(file_name string) bool {
	return C.IsFileNameValid(file_name.str)
}

fn C.LoadDirectoryFiles(&char) FilePathList

// Load directory filepaths
@[inline]
pub fn load_directory_files(dir_path string) FilePathList {
	return C.LoadDirectoryFiles(dir_path.str)
}

fn C.LoadDirectoryFilesEx(&char, &char, bool) FilePathList

// Load directory filepaths with extension filtering and recursive directory scan. Use 'DIR' in the filter string to include directories in the result
@[inline]
pub fn load_directory_files_ex(base_path string, filter string, scan_subdirs bool) FilePathList {
	return C.LoadDirectoryFilesEx(base_path.str, filter.str, scan_subdirs)
}

fn C.UnloadDirectoryFiles(FilePathList)

// Unload filepaths
@[inline]
pub fn unload_directory_files(files FilePathList) {
	C.UnloadDirectoryFiles(files)
}

fn C.IsFileDropped() bool

// Check if a file has been dropped into window
@[inline]
pub fn is_file_dropped() bool {
	return C.IsFileDropped()
}

fn C.LoadDroppedFiles() FilePathList

// Load dropped filepaths
@[inline]
pub fn load_dropped_files() FilePathList {
	return C.LoadDroppedFiles()
}

fn C.UnloadDroppedFiles(FilePathList)

// Unload dropped filepaths
@[inline]
pub fn unload_dropped_files(files FilePathList) {
	C.UnloadDroppedFiles(files)
}

fn C.GetFileModTime(&char) i64

// Get file modification time (last write time)
@[inline]
pub fn get_file_mod_time(file_name string) i64 {
	return C.GetFileModTime(file_name.str)
}

fn C.CompressData(&u8, int, &int) &u8

// Compress data (DEFLATE algorithm), memory must be MemFree()
@[inline]
pub fn compress_data(data &u8, data_size int, comp_data_size &int) &u8 {
	return C.CompressData(data, data_size, comp_data_size)
}

fn C.DecompressData(&u8, int, &int) &u8

// Decompress data (DEFLATE algorithm), memory must be MemFree()
@[inline]
pub fn decompress_data(comp_data &u8, comp_data_size int, data_size &int) &u8 {
	return C.DecompressData(comp_data, comp_data_size, data_size)
}

fn C.EncodeDataBase64(&u8, int, &int) &char

// Encode data to Base64 string, memory must be MemFree()
@[inline]
pub fn encode_data_base64(data &u8, data_size int, output_size &int) string {
	unsafe {
		return C.EncodeDataBase64(data, data_size, output_size).vstring()
	}
}

fn C.DecodeDataBase64(&u8, &int) &u8

// Decode Base64 string data, memory must be MemFree()
@[inline]
pub fn decode_data_base64(data &u8, output_size &int) &u8 {
	return C.DecodeDataBase64(data, output_size)
}

fn C.ComputeCRC32(&u8, int) u32

// Compute CRC32 hash code
@[inline]
pub fn compute_crc32(data &u8, data_size int) u32 {
	return C.ComputeCRC32(data, data_size)
}

fn C.ComputeMD5(&u8, int) &u32

// Compute MD5 hash code, returns static int[4] (16 bytes)
@[inline]
pub fn compute_md5(data &u8, data_size int) &u32 {
	return C.ComputeMD5(data, data_size)
}

fn C.ComputeSHA1(&u8, int) &u32

// Compute SHA1 hash code, returns static int[5] (20 bytes)
@[inline]
pub fn compute_sha1(data &u8, data_size int) &u32 {
	return C.ComputeSHA1(data, data_size)
}

fn C.LoadAutomationEventList(&char) AutomationEventList

// Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
@[inline]
pub fn load_automation_event_list(file_name string) AutomationEventList {
	return C.LoadAutomationEventList(file_name.str)
}

fn C.UnloadAutomationEventList(AutomationEventList)

// Unload automation events list from file
@[inline]
pub fn unload_automation_event_list(list AutomationEventList) {
	C.UnloadAutomationEventList(list)
}

fn C.ExportAutomationEventList(AutomationEventList, &char) bool

// Export automation events list as text file
@[inline]
pub fn export_automation_event_list(list AutomationEventList, file_name string) bool {
	return C.ExportAutomationEventList(list, file_name.str)
}

fn C.SetAutomationEventList(&AutomationEventList)

// Set automation event list to record to
@[inline]
pub fn set_automation_event_list(list &AutomationEventList) {
	C.SetAutomationEventList(list)
}

fn C.SetAutomationEventBaseFrame(int)

// Set automation event internal base frame to start recording
@[inline]
pub fn set_automation_event_base_frame(frame int) {
	C.SetAutomationEventBaseFrame(frame)
}

fn C.StartAutomationEventRecording()

// Start recording automation events (AutomationEventList must be set)
@[inline]
pub fn start_automation_event_recording() {
	C.StartAutomationEventRecording()
}

fn C.StopAutomationEventRecording()

// Stop recording automation events
@[inline]
pub fn stop_automation_event_recording() {
	C.StopAutomationEventRecording()
}

fn C.PlayAutomationEvent(AutomationEvent)

// Play a recorded automation event
@[inline]
pub fn play_automation_event(event AutomationEvent) {
	C.PlayAutomationEvent(event)
}

fn C.IsKeyPressed(int) bool

// Check if a key has been pressed once
@[inline]
pub fn is_key_pressed(key int) bool {
	return C.IsKeyPressed(key)
}

fn C.IsKeyPressedRepeat(int) bool

// Check if a key has been pressed again
@[inline]
pub fn is_key_pressed_repeat(key int) bool {
	return C.IsKeyPressedRepeat(key)
}

fn C.IsKeyDown(int) bool

// Check if a key is being pressed
@[inline]
pub fn is_key_down(key int) bool {
	return C.IsKeyDown(key)
}

fn C.IsKeyReleased(int) bool

// Check if a key has been released once
@[inline]
pub fn is_key_released(key int) bool {
	return C.IsKeyReleased(key)
}

fn C.IsKeyUp(int) bool

// Check if a key is NOT being pressed
@[inline]
pub fn is_key_up(key int) bool {
	return C.IsKeyUp(key)
}

fn C.GetKeyPressed() int

// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
@[inline]
pub fn get_key_pressed() int {
	return C.GetKeyPressed()
}

fn C.GetCharPressed() int

// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
@[inline]
pub fn get_char_pressed() int {
	return C.GetCharPressed()
}

fn C.SetExitKey(int)

// Set a custom key to exit program (default is ESC)
@[inline]
pub fn set_exit_key(key int) {
	C.SetExitKey(key)
}

fn C.IsGamepadAvailable(int) bool

// Check if a gamepad is available
@[inline]
pub fn is_gamepad_available(gamepad int) bool {
	return C.IsGamepadAvailable(gamepad)
}

fn C.GetGamepadName(int) &char

// Get gamepad internal name id
@[inline]
pub fn get_gamepad_name(gamepad int) string {
	unsafe {
		return C.GetGamepadName(gamepad).vstring()
	}
}

fn C.IsGamepadButtonPressed(int, int) bool

// Check if a gamepad button has been pressed once
@[inline]
pub fn is_gamepad_button_pressed(gamepad int, button int) bool {
	return C.IsGamepadButtonPressed(gamepad, button)
}

fn C.IsGamepadButtonDown(int, int) bool

// Check if a gamepad button is being pressed
@[inline]
pub fn is_gamepad_button_down(gamepad int, button int) bool {
	return C.IsGamepadButtonDown(gamepad, button)
}

fn C.IsGamepadButtonReleased(int, int) bool

// Check if a gamepad button has been released once
@[inline]
pub fn is_gamepad_button_released(gamepad int, button int) bool {
	return C.IsGamepadButtonReleased(gamepad, button)
}

fn C.IsGamepadButtonUp(int, int) bool

// Check if a gamepad button is NOT being pressed
@[inline]
pub fn is_gamepad_button_up(gamepad int, button int) bool {
	return C.IsGamepadButtonUp(gamepad, button)
}

fn C.GetGamepadButtonPressed() int

// Get the last gamepad button pressed
@[inline]
pub fn get_gamepad_button_pressed() int {
	return C.GetGamepadButtonPressed()
}

fn C.GetGamepadAxisCount(int) int

// Get gamepad axis count for a gamepad
@[inline]
pub fn get_gamepad_axis_count(gamepad int) int {
	return C.GetGamepadAxisCount(gamepad)
}

fn C.GetGamepadAxisMovement(int, int) f32

// Get axis movement value for a gamepad axis
@[inline]
pub fn get_gamepad_axis_movement(gamepad int, axis int) f32 {
	return C.GetGamepadAxisMovement(gamepad, axis)
}

fn C.SetGamepadMappings(&char) int

// Set internal gamepad mappings (SDL_GameControllerDB)
@[inline]
pub fn set_gamepad_mappings(mappings string) int {
	return C.SetGamepadMappings(mappings.str)
}

fn C.SetGamepadVibration(int, f32, f32, f32)

// Set gamepad vibration for both motors (duration in seconds)
@[inline]
pub fn set_gamepad_vibration(gamepad int, left_motor f32, right_motor f32, duration f32) {
	C.SetGamepadVibration(gamepad, left_motor, right_motor, duration)
}

fn C.IsMouseButtonPressed(int) bool

// Check if a mouse button has been pressed once
@[inline]
pub fn is_mouse_button_pressed(button int) bool {
	return C.IsMouseButtonPressed(button)
}

fn C.IsMouseButtonDown(int) bool

// Check if a mouse button is being pressed
@[inline]
pub fn is_mouse_button_down(button int) bool {
	return C.IsMouseButtonDown(button)
}

fn C.IsMouseButtonReleased(int) bool

// Check if a mouse button has been released once
@[inline]
pub fn is_mouse_button_released(button int) bool {
	return C.IsMouseButtonReleased(button)
}

fn C.IsMouseButtonUp(int) bool

// Check if a mouse button is NOT being pressed
@[inline]
pub fn is_mouse_button_up(button int) bool {
	return C.IsMouseButtonUp(button)
}

fn C.GetMouseX() int

// Get mouse position X
@[inline]
pub fn get_mouse_x() int {
	return C.GetMouseX()
}

fn C.GetMouseY() int

// Get mouse position Y
@[inline]
pub fn get_mouse_y() int {
	return C.GetMouseY()
}

fn C.GetMousePosition() Vector2

// Get mouse position XY
@[inline]
pub fn get_mouse_position() Vector2 {
	return C.GetMousePosition()
}

fn C.GetMouseDelta() Vector2

// Get mouse delta between frames
@[inline]
pub fn get_mouse_delta() Vector2 {
	return C.GetMouseDelta()
}

fn C.SetMousePosition(int, int)

// Set mouse position XY
@[inline]
pub fn set_mouse_position(x int, y int) {
	C.SetMousePosition(x, y)
}

fn C.SetMouseOffset(int, int)

// Set mouse offset
@[inline]
pub fn set_mouse_offset(offset_x int, offset_y int) {
	C.SetMouseOffset(offset_x, offset_y)
}

fn C.SetMouseScale(f32, f32)

// Set mouse scaling
@[inline]
pub fn set_mouse_scale(scale_x f32, scale_y f32) {
	C.SetMouseScale(scale_x, scale_y)
}

fn C.GetMouseWheelMove() f32

// Get mouse wheel movement for X or Y, whichever is larger
@[inline]
pub fn get_mouse_wheel_move() f32 {
	return C.GetMouseWheelMove()
}

fn C.GetMouseWheelMoveV() Vector2

// Get mouse wheel movement for both X and Y
@[inline]
pub fn get_mouse_wheel_move_v() Vector2 {
	return C.GetMouseWheelMoveV()
}

fn C.SetMouseCursor(int)

// Set mouse cursor
@[inline]
pub fn set_mouse_cursor(cursor int) {
	C.SetMouseCursor(cursor)
}

fn C.GetTouchX() int

// Get touch position X for touch point 0 (relative to screen size)
@[inline]
pub fn get_touch_x() int {
	return C.GetTouchX()
}

fn C.GetTouchY() int

// Get touch position Y for touch point 0 (relative to screen size)
@[inline]
pub fn get_touch_y() int {
	return C.GetTouchY()
}

fn C.GetTouchPosition(int) Vector2

// Get touch position XY for a touch point index (relative to screen size)
@[inline]
pub fn get_touch_position(index int) Vector2 {
	return C.GetTouchPosition(index)
}

fn C.GetTouchPointId(int) int

// Get touch point identifier for given index
@[inline]
pub fn get_touch_point_id(index int) int {
	return C.GetTouchPointId(index)
}

fn C.GetTouchPointCount() int

// Get number of touch points
@[inline]
pub fn get_touch_point_count() int {
	return C.GetTouchPointCount()
}

fn C.SetGesturesEnabled(Gesture)

// Enable a set of gestures using flags
@[inline]
pub fn set_gestures_enabled(flags Gesture) {
	C.SetGesturesEnabled(flags)
}

fn C.IsGestureDetected(u32) bool

// Check if a gesture have been detected
@[inline]
pub fn is_gesture_detected(gesture u32) bool {
	return C.IsGestureDetected(gesture)
}

fn C.GetGestureDetected() int

// Get latest detected gesture
@[inline]
pub fn get_gesture_detected() int {
	return C.GetGestureDetected()
}

fn C.GetGestureHoldDuration() f32

// Get gesture hold time in seconds
@[inline]
pub fn get_gesture_hold_duration() f32 {
	return C.GetGestureHoldDuration()
}

fn C.GetGestureDragVector() Vector2

// Get gesture drag vector
@[inline]
pub fn get_gesture_drag_vector() Vector2 {
	return C.GetGestureDragVector()
}

fn C.GetGestureDragAngle() f32

// Get gesture drag angle
@[inline]
pub fn get_gesture_drag_angle() f32 {
	return C.GetGestureDragAngle()
}

fn C.GetGesturePinchVector() Vector2

// Get gesture pinch delta
@[inline]
pub fn get_gesture_pinch_vector() Vector2 {
	return C.GetGesturePinchVector()
}

fn C.GetGesturePinchAngle() f32

// Get gesture pinch angle
@[inline]
pub fn get_gesture_pinch_angle() f32 {
	return C.GetGesturePinchAngle()
}

fn C.UpdateCamera(&Camera, int)

// Update camera position for selected mode
@[inline]
pub fn update_camera(camera &Camera, mode int) {
	C.UpdateCamera(camera, mode)
}

fn C.UpdateCameraPro(&Camera, Vector3, Vector3, f32)

// Update camera movement/rotation
@[inline]
pub fn update_camera_pro(camera &Camera, movement Vector3, rotation Vector3, zoom f32) {
	C.UpdateCameraPro(camera, movement, rotation, zoom)
}

fn C.SetShapesTexture(Texture2D, Rectangle)

// Set texture and rectangle to be used on shapes drawing
@[inline]
pub fn set_shapes_texture(texture Texture2D, source Rectangle) {
	C.SetShapesTexture(texture, source)
}

fn C.GetShapesTexture() Texture2D

// Get texture that is used for shapes drawing
@[inline]
pub fn get_shapes_texture() Texture2D {
	return C.GetShapesTexture()
}

fn C.GetShapesTextureRectangle() Rectangle

// Get texture source rectangle that is used for shapes drawing
@[inline]
pub fn get_shapes_texture_rectangle() Rectangle {
	return C.GetShapesTextureRectangle()
}

fn C.DrawPixel(int, int, Color)

// Draw a pixel using geometry [Can be slow, use with care]
@[inline]
pub fn draw_pixel(pos_x int, pos_y int, color Color) {
	C.DrawPixel(pos_x, pos_y, color)
}

fn C.DrawPixelV(Vector2, Color)

// Draw a pixel using geometry (Vector version) [Can be slow, use with care]
@[inline]
pub fn draw_pixel_v(position Vector2, color Color) {
	C.DrawPixelV(position, color)
}

fn C.DrawLine(int, int, int, int, Color)

// Draw a line
@[inline]
pub fn draw_line(start_pos_x int, start_pos_y int, end_pos_x int, end_pos_y int, color Color) {
	C.DrawLine(start_pos_x, start_pos_y, end_pos_x, end_pos_y, color)
}

fn C.DrawLineV(Vector2, Vector2, Color)

// Draw a line (using gl lines)
@[inline]
pub fn draw_line_v(start_pos Vector2, end_pos Vector2, color Color) {
	C.DrawLineV(start_pos, end_pos, color)
}

fn C.DrawLineEx(Vector2, Vector2, f32, Color)

// Draw a line (using triangles/quads)
@[inline]
pub fn draw_line_ex(start_pos Vector2, end_pos Vector2, thick f32, color Color) {
	C.DrawLineEx(start_pos, end_pos, thick, color)
}

fn C.DrawLineStrip(&Vector2, int, Color)

// Draw lines sequence (using gl lines)
@[inline]
pub fn draw_line_strip(points &Vector2, point_count int, color Color) {
	C.DrawLineStrip(points, point_count, color)
}

fn C.DrawLineBezier(Vector2, Vector2, f32, Color)

// Draw line segment cubic-bezier in-out interpolation
@[inline]
pub fn draw_line_bezier(start_pos Vector2, end_pos Vector2, thick f32, color Color) {
	C.DrawLineBezier(start_pos, end_pos, thick, color)
}

fn C.DrawCircle(int, int, f32, Color)

// Draw a color-filled circle
@[inline]
pub fn draw_circle(center_x int, center_y int, radius f32, color Color) {
	C.DrawCircle(center_x, center_y, radius, color)
}

fn C.DrawCircleSector(Vector2, f32, f32, f32, int, Color)

// Draw a piece of a circle
@[inline]
pub fn draw_circle_sector(center Vector2, radius f32, start_angle f32, end_angle f32, segments int, color Color) {
	C.DrawCircleSector(center, radius, start_angle, end_angle, segments, color)
}

fn C.DrawCircleSectorLines(Vector2, f32, f32, f32, int, Color)

// Draw circle sector outline
@[inline]
pub fn draw_circle_sector_lines(center Vector2, radius f32, start_angle f32, end_angle f32, segments int, color Color) {
	C.DrawCircleSectorLines(center, radius, start_angle, end_angle, segments, color)
}

fn C.DrawCircleGradient(int, int, f32, Color, Color)

// Draw a gradient-filled circle
@[inline]
pub fn draw_circle_gradient(center_x int, center_y int, radius f32, inner Color, outer Color) {
	C.DrawCircleGradient(center_x, center_y, radius, inner, outer)
}

fn C.DrawCircleV(Vector2, f32, Color)

// Draw a color-filled circle (Vector version)
@[inline]
pub fn draw_circle_v(center Vector2, radius f32, color Color) {
	C.DrawCircleV(center, radius, color)
}

fn C.DrawCircleLines(int, int, f32, Color)

// Draw circle outline
@[inline]
pub fn draw_circle_lines(center_x int, center_y int, radius f32, color Color) {
	C.DrawCircleLines(center_x, center_y, radius, color)
}

fn C.DrawCircleLinesV(Vector2, f32, Color)

// Draw circle outline (Vector version)
@[inline]
pub fn draw_circle_lines_v(center Vector2, radius f32, color Color) {
	C.DrawCircleLinesV(center, radius, color)
}

fn C.DrawEllipse(int, int, f32, f32, Color)

// Draw ellipse
@[inline]
pub fn draw_ellipse(center_x int, center_y int, radius_h f32, radius_v f32, color Color) {
	C.DrawEllipse(center_x, center_y, radius_h, radius_v, color)
}

fn C.DrawEllipseLines(int, int, f32, f32, Color)

// Draw ellipse outline
@[inline]
pub fn draw_ellipse_lines(center_x int, center_y int, radius_h f32, radius_v f32, color Color) {
	C.DrawEllipseLines(center_x, center_y, radius_h, radius_v, color)
}

fn C.DrawRing(Vector2, f32, f32, f32, f32, int, Color)

// Draw ring
@[inline]
pub fn draw_ring(center Vector2, inner_radius f32, outer_radius f32, start_angle f32, end_angle f32, segments int, color Color) {
	C.DrawRing(center, inner_radius, outer_radius, start_angle, end_angle, segments, color)
}

fn C.DrawRingLines(Vector2, f32, f32, f32, f32, int, Color)

// Draw ring outline
@[inline]
pub fn draw_ring_lines(center Vector2, inner_radius f32, outer_radius f32, start_angle f32, end_angle f32, segments int, color Color) {
	C.DrawRingLines(center, inner_radius, outer_radius, start_angle, end_angle, segments,
		color)
}

fn C.DrawRectangle(int, int, int, int, Color)

// Draw a color-filled rectangle
@[inline]
pub fn draw_rectangle(pos_x int, pos_y int, width int, height int, color Color) {
	C.DrawRectangle(pos_x, pos_y, width, height, color)
}

fn C.DrawRectangleV(Vector2, Vector2, Color)

// Draw a color-filled rectangle (Vector version)
@[inline]
pub fn draw_rectangle_v(position Vector2, size Vector2, color Color) {
	C.DrawRectangleV(position, size, color)
}

fn C.DrawRectangleRec(Rectangle, Color)

// Draw a color-filled rectangle
@[inline]
pub fn draw_rectangle_rec(rec Rectangle, color Color) {
	C.DrawRectangleRec(rec, color)
}

fn C.DrawRectanglePro(Rectangle, Vector2, f32, Color)

// Draw a color-filled rectangle with pro parameters
@[inline]
pub fn draw_rectangle_pro(rec Rectangle, origin Vector2, rotation f32, color Color) {
	C.DrawRectanglePro(rec, origin, rotation, color)
}

fn C.DrawRectangleGradientV(int, int, int, int, Color, Color)

// Draw a vertical-gradient-filled rectangle
@[inline]
pub fn draw_rectangle_gradient_v(pos_x int, pos_y int, width int, height int, top Color, bottom Color) {
	C.DrawRectangleGradientV(pos_x, pos_y, width, height, top, bottom)
}

fn C.DrawRectangleGradientH(int, int, int, int, Color, Color)

// Draw a horizontal-gradient-filled rectangle
@[inline]
pub fn draw_rectangle_gradient_h(pos_x int, pos_y int, width int, height int, left Color, right Color) {
	C.DrawRectangleGradientH(pos_x, pos_y, width, height, left, right)
}

fn C.DrawRectangleGradientEx(Rectangle, Color, Color, Color, Color)

// Draw a gradient-filled rectangle with custom vertex colors
@[inline]
pub fn draw_rectangle_gradient_ex(rec Rectangle, top_left Color, bottom_left Color, top_right Color, bottom_right Color) {
	C.DrawRectangleGradientEx(rec, top_left, bottom_left, top_right, bottom_right)
}

fn C.DrawRectangleLines(int, int, int, int, Color)

// Draw rectangle outline
@[inline]
pub fn draw_rectangle_lines(pos_x int, pos_y int, width int, height int, color Color) {
	C.DrawRectangleLines(pos_x, pos_y, width, height, color)
}

fn C.DrawRectangleLinesEx(Rectangle, f32, Color)

// Draw rectangle outline with extended parameters
@[inline]
pub fn draw_rectangle_lines_ex(rec Rectangle, line_thick f32, color Color) {
	C.DrawRectangleLinesEx(rec, line_thick, color)
}

fn C.DrawRectangleRounded(Rectangle, f32, int, Color)

// Draw rectangle with rounded edges
@[inline]
pub fn draw_rectangle_rounded(rec Rectangle, roundness f32, segments int, color Color) {
	C.DrawRectangleRounded(rec, roundness, segments, color)
}

fn C.DrawRectangleRoundedLines(Rectangle, f32, int, Color)

// Draw rectangle lines with rounded edges
@[inline]
pub fn draw_rectangle_rounded_lines(rec Rectangle, roundness f32, segments int, color Color) {
	C.DrawRectangleRoundedLines(rec, roundness, segments, color)
}

fn C.DrawRectangleRoundedLinesEx(Rectangle, f32, int, f32, Color)

// Draw rectangle with rounded edges outline
@[inline]
pub fn draw_rectangle_rounded_lines_ex(rec Rectangle, roundness f32, segments int, line_thick f32, color Color) {
	C.DrawRectangleRoundedLinesEx(rec, roundness, segments, line_thick, color)
}

fn C.DrawTriangle(Vector2, Vector2, Vector2, Color)

// Draw a color-filled triangle (vertex in counter-clockwise order!)
@[inline]
pub fn draw_triangle(v1 Vector2, v2 Vector2, v3 Vector2, color Color) {
	C.DrawTriangle(v1, v2, v3, color)
}

fn C.DrawTriangleLines(Vector2, Vector2, Vector2, Color)

// Draw triangle outline (vertex in counter-clockwise order!)
@[inline]
pub fn draw_triangle_lines(v1 Vector2, v2 Vector2, v3 Vector2, color Color) {
	C.DrawTriangleLines(v1, v2, v3, color)
}

fn C.DrawTriangleFan(&Vector2, int, Color)

// Draw a triangle fan defined by points (first vertex is the center)
@[inline]
pub fn draw_triangle_fan(points &Vector2, point_count int, color Color) {
	C.DrawTriangleFan(points, point_count, color)
}

fn C.DrawTriangleStrip(&Vector2, int, Color)

// Draw a triangle strip defined by points
@[inline]
pub fn draw_triangle_strip(points &Vector2, point_count int, color Color) {
	C.DrawTriangleStrip(points, point_count, color)
}

fn C.DrawPoly(Vector2, int, f32, f32, Color)

// Draw a regular polygon (Vector version)
@[inline]
pub fn draw_poly(center Vector2, sides int, radius f32, rotation f32, color Color) {
	C.DrawPoly(center, sides, radius, rotation, color)
}

fn C.DrawPolyLines(Vector2, int, f32, f32, Color)

// Draw a polygon outline of n sides
@[inline]
pub fn draw_poly_lines(center Vector2, sides int, radius f32, rotation f32, color Color) {
	C.DrawPolyLines(center, sides, radius, rotation, color)
}

fn C.DrawPolyLinesEx(Vector2, int, f32, f32, f32, Color)

// Draw a polygon outline of n sides with extended parameters
@[inline]
pub fn draw_poly_lines_ex(center Vector2, sides int, radius f32, rotation f32, line_thick f32, color Color) {
	C.DrawPolyLinesEx(center, sides, radius, rotation, line_thick, color)
}

fn C.DrawSplineLinear(&Vector2, int, f32, Color)

// Draw spline: Linear, minimum 2 points
@[inline]
pub fn draw_spline_linear(points &Vector2, point_count int, thick f32, color Color) {
	C.DrawSplineLinear(points, point_count, thick, color)
}

fn C.DrawSplineBasis(&Vector2, int, f32, Color)

// Draw spline: B-Spline, minimum 4 points
@[inline]
pub fn draw_spline_basis(points &Vector2, point_count int, thick f32, color Color) {
	C.DrawSplineBasis(points, point_count, thick, color)
}

fn C.DrawSplineCatmullRom(&Vector2, int, f32, Color)

// Draw spline: Catmull-Rom, minimum 4 points
@[inline]
pub fn draw_spline_catmull_rom(points &Vector2, point_count int, thick f32, color Color) {
	C.DrawSplineCatmullRom(points, point_count, thick, color)
}

fn C.DrawSplineBezierQuadratic(&Vector2, int, f32, Color)

// Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
@[inline]
pub fn draw_spline_bezier_quadratic(points &Vector2, point_count int, thick f32, color Color) {
	C.DrawSplineBezierQuadratic(points, point_count, thick, color)
}

fn C.DrawSplineBezierCubic(&Vector2, int, f32, Color)

// Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
@[inline]
pub fn draw_spline_bezier_cubic(points &Vector2, point_count int, thick f32, color Color) {
	C.DrawSplineBezierCubic(points, point_count, thick, color)
}

fn C.DrawSplineSegmentLinear(Vector2, Vector2, f32, Color)

// Draw spline segment: Linear, 2 points
@[inline]
pub fn draw_spline_segment_linear(p1 Vector2, p2 Vector2, thick f32, color Color) {
	C.DrawSplineSegmentLinear(p1, p2, thick, color)
}

fn C.DrawSplineSegmentBasis(Vector2, Vector2, Vector2, Vector2, f32, Color)

// Draw spline segment: B-Spline, 4 points
@[inline]
pub fn draw_spline_segment_basis(p1 Vector2, p2 Vector2, p3 Vector2, p4 Vector2, thick f32, color Color) {
	C.DrawSplineSegmentBasis(p1, p2, p3, p4, thick, color)
}

fn C.DrawSplineSegmentCatmullRom(Vector2, Vector2, Vector2, Vector2, f32, Color)

// Draw spline segment: Catmull-Rom, 4 points
@[inline]
pub fn draw_spline_segment_catmull_rom(p1 Vector2, p2 Vector2, p3 Vector2, p4 Vector2, thick f32, color Color) {
	C.DrawSplineSegmentCatmullRom(p1, p2, p3, p4, thick, color)
}

fn C.DrawSplineSegmentBezierQuadratic(Vector2, Vector2, Vector2, f32, Color)

// Draw spline segment: Quadratic Bezier, 2 points, 1 control point
@[inline]
pub fn draw_spline_segment_bezier_quadratic(p1 Vector2, c2 Vector2, p3 Vector2, thick f32, color Color) {
	C.DrawSplineSegmentBezierQuadratic(p1, c2, p3, thick, color)
}

fn C.DrawSplineSegmentBezierCubic(Vector2, Vector2, Vector2, Vector2, f32, Color)

// Draw spline segment: Cubic Bezier, 2 points, 2 control points
@[inline]
pub fn draw_spline_segment_bezier_cubic(p1 Vector2, c2 Vector2, c3 Vector2, p4 Vector2, thick f32, color Color) {
	C.DrawSplineSegmentBezierCubic(p1, c2, c3, p4, thick, color)
}

fn C.GetSplinePointLinear(Vector2, Vector2, f32) Vector2

// Get (evaluate) spline point: Linear
@[inline]
pub fn get_spline_point_linear(start_pos Vector2, end_pos Vector2, t f32) Vector2 {
	return C.GetSplinePointLinear(start_pos, end_pos, t)
}

fn C.GetSplinePointBasis(Vector2, Vector2, Vector2, Vector2, f32) Vector2

// Get (evaluate) spline point: B-Spline
@[inline]
pub fn get_spline_point_basis(p1 Vector2, p2 Vector2, p3 Vector2, p4 Vector2, t f32) Vector2 {
	return C.GetSplinePointBasis(p1, p2, p3, p4, t)
}

fn C.GetSplinePointCatmullRom(Vector2, Vector2, Vector2, Vector2, f32) Vector2

// Get (evaluate) spline point: Catmull-Rom
@[inline]
pub fn get_spline_point_catmull_rom(p1 Vector2, p2 Vector2, p3 Vector2, p4 Vector2, t f32) Vector2 {
	return C.GetSplinePointCatmullRom(p1, p2, p3, p4, t)
}

fn C.GetSplinePointBezierQuad(Vector2, Vector2, Vector2, f32) Vector2

// Get (evaluate) spline point: Quadratic Bezier
@[inline]
pub fn get_spline_point_bezier_quad(p1 Vector2, c2 Vector2, p3 Vector2, t f32) Vector2 {
	return C.GetSplinePointBezierQuad(p1, c2, p3, t)
}

fn C.GetSplinePointBezierCubic(Vector2, Vector2, Vector2, Vector2, f32) Vector2

// Get (evaluate) spline point: Cubic Bezier
@[inline]
pub fn get_spline_point_bezier_cubic(p1 Vector2, c2 Vector2, c3 Vector2, p4 Vector2, t f32) Vector2 {
	return C.GetSplinePointBezierCubic(p1, c2, c3, p4, t)
}

fn C.CheckCollisionRecs(Rectangle, Rectangle) bool

// Check collision between two rectangles
@[inline]
pub fn check_collision_recs(rec1 Rectangle, rec2 Rectangle) bool {
	return C.CheckCollisionRecs(rec1, rec2)
}

fn C.CheckCollisionCircles(Vector2, f32, Vector2, f32) bool

// Check collision between two circles
@[inline]
pub fn check_collision_circles(center1 Vector2, radius1 f32, center2 Vector2, radius2 f32) bool {
	return C.CheckCollisionCircles(center1, radius1, center2, radius2)
}

fn C.CheckCollisionCircleRec(Vector2, f32, Rectangle) bool

// Check collision between circle and rectangle
@[inline]
pub fn check_collision_circle_rec(center Vector2, radius f32, rec Rectangle) bool {
	return C.CheckCollisionCircleRec(center, radius, rec)
}

fn C.CheckCollisionCircleLine(Vector2, f32, Vector2, Vector2) bool

// Check if circle collides with a line created betweeen two points [p1] and [p2]
@[inline]
pub fn check_collision_circle_line(center Vector2, radius f32, p1 Vector2, p2 Vector2) bool {
	return C.CheckCollisionCircleLine(center, radius, p1, p2)
}

fn C.CheckCollisionPointRec(Vector2, Rectangle) bool

// Check if point is inside rectangle
@[inline]
pub fn check_collision_point_rec(point Vector2, rec Rectangle) bool {
	return C.CheckCollisionPointRec(point, rec)
}

fn C.CheckCollisionPointCircle(Vector2, Vector2, f32) bool

// Check if point is inside circle
@[inline]
pub fn check_collision_point_circle(point Vector2, center Vector2, radius f32) bool {
	return C.CheckCollisionPointCircle(point, center, radius)
}

fn C.CheckCollisionPointTriangle(Vector2, Vector2, Vector2, Vector2) bool

// Check if point is inside a triangle
@[inline]
pub fn check_collision_point_triangle(point Vector2, p1 Vector2, p2 Vector2, p3 Vector2) bool {
	return C.CheckCollisionPointTriangle(point, p1, p2, p3)
}

fn C.CheckCollisionPointLine(Vector2, Vector2, Vector2, int) bool

// Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
@[inline]
pub fn check_collision_point_line(point Vector2, p1 Vector2, p2 Vector2, threshold int) bool {
	return C.CheckCollisionPointLine(point, p1, p2, threshold)
}

fn C.CheckCollisionPointPoly(Vector2, &Vector2, int) bool

// Check if point is within a polygon described by array of vertices
@[inline]
pub fn check_collision_point_poly(point Vector2, points &Vector2, point_count int) bool {
	return C.CheckCollisionPointPoly(point, points, point_count)
}

fn C.CheckCollisionLines(Vector2, Vector2, Vector2, Vector2, &Vector2) bool

// Check the collision between two lines defined by two points each, returns collision point by reference
@[inline]
pub fn check_collision_lines(start_pos1 Vector2, end_pos1 Vector2, start_pos2 Vector2, end_pos2 Vector2, collision_point &Vector2) bool {
	return C.CheckCollisionLines(start_pos1, end_pos1, start_pos2, end_pos2, collision_point)
}

fn C.GetCollisionRec(Rectangle, Rectangle) Rectangle

// Get collision rectangle for two rectangles collision
@[inline]
pub fn get_collision_rec(rec1 Rectangle, rec2 Rectangle) Rectangle {
	return C.GetCollisionRec(rec1, rec2)
}

fn C.LoadImage(&char) Image

// Load image from file into CPU memory (RAM)
@[inline]
pub fn load_image(file_name string) Image {
	return C.LoadImage(file_name.str)
}

fn C.LoadImageRaw(&char, int, int, int, int) Image

// Load image from RAW file data
@[inline]
pub fn load_image_raw(file_name string, width int, height int, format int, header_size int) Image {
	return C.LoadImageRaw(file_name.str, width, height, format, header_size)
}

fn C.LoadImageAnim(&char, &int) Image

// Load image sequence from file (frames appended to image.data)
@[inline]
pub fn load_image_anim(file_name string, frames &int) Image {
	return C.LoadImageAnim(file_name.str, frames)
}

fn C.LoadImageAnimFromMemory(&char, &u8, int, &int) Image

// Load image sequence from memory buffer
@[inline]
pub fn load_image_anim_from_memory(file_type string, file_data &u8, data_size int, frames &int) Image {
	return C.LoadImageAnimFromMemory(file_type.str, file_data, data_size, frames)
}

fn C.LoadImageFromMemory(&char, &u8, int) Image

// Load image from memory buffer, fileType refers to extension: i.e. '.png'
@[inline]
pub fn load_image_from_memory(file_type string, file_data &u8, data_size int) Image {
	return C.LoadImageFromMemory(file_type.str, file_data, data_size)
}

fn C.LoadImageFromTexture(Texture2D) Image

// Load image from GPU texture data
@[inline]
pub fn load_image_from_texture(texture Texture2D) Image {
	return C.LoadImageFromTexture(texture)
}

fn C.LoadImageFromScreen() Image

// Load image from screen buffer and (screenshot)
@[inline]
pub fn load_image_from_screen() Image {
	return C.LoadImageFromScreen()
}

fn C.IsImageValid(Image) bool

// Check if an image is valid (data and parameters)
@[inline]
pub fn is_image_valid(image Image) bool {
	return C.IsImageValid(image)
}

fn C.UnloadImage(Image)

// Unload image from CPU memory (RAM)
@[inline]
pub fn unload_image(image Image) {
	C.UnloadImage(image)
}

fn C.ExportImage(Image, &char) bool

// Export image data to file, returns true on success
@[inline]
pub fn export_image(image Image, file_name string) bool {
	return C.ExportImage(image, file_name.str)
}

fn C.ExportImageToMemory(Image, &char, &int) &u8

// Export image to memory buffer
@[inline]
pub fn export_image_to_memory(image Image, file_type string, file_size &int) &u8 {
	return C.ExportImageToMemory(image, file_type.str, file_size)
}

fn C.ExportImageAsCode(Image, &char) bool

// Export image as code file defining an array of bytes, returns true on success
@[inline]
pub fn export_image_as_code(image Image, file_name string) bool {
	return C.ExportImageAsCode(image, file_name.str)
}

fn C.GenImageColor(int, int, Color) Image

// Generate image: plain color
@[inline]
pub fn gen_image_color(width int, height int, color Color) Image {
	return C.GenImageColor(width, height, color)
}

fn C.GenImageGradientLinear(int, int, int, Color, Color) Image

// Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
@[inline]
pub fn gen_image_gradient_linear(width int, height int, direction int, start Color, end Color) Image {
	return C.GenImageGradientLinear(width, height, direction, start, end)
}

fn C.GenImageGradientRadial(int, int, f32, Color, Color) Image

// Generate image: radial gradient
@[inline]
pub fn gen_image_gradient_radial(width int, height int, density f32, inner Color, outer Color) Image {
	return C.GenImageGradientRadial(width, height, density, inner, outer)
}

fn C.GenImageGradientSquare(int, int, f32, Color, Color) Image

// Generate image: square gradient
@[inline]
pub fn gen_image_gradient_square(width int, height int, density f32, inner Color, outer Color) Image {
	return C.GenImageGradientSquare(width, height, density, inner, outer)
}

fn C.GenImageChecked(int, int, int, int, Color, Color) Image

// Generate image: checked
@[inline]
pub fn gen_image_checked(width int, height int, checks_x int, checks_y int, col1 Color, col2 Color) Image {
	return C.GenImageChecked(width, height, checks_x, checks_y, col1, col2)
}

fn C.GenImageWhiteNoise(int, int, f32) Image

// Generate image: white noise
@[inline]
pub fn gen_image_white_noise(width int, height int, factor f32) Image {
	return C.GenImageWhiteNoise(width, height, factor)
}

fn C.GenImagePerlinNoise(int, int, int, int, f32) Image

// Generate image: perlin noise
@[inline]
pub fn gen_image_perlin_noise(width int, height int, offset_x int, offset_y int, scale f32) Image {
	return C.GenImagePerlinNoise(width, height, offset_x, offset_y, scale)
}

fn C.GenImageCellular(int, int, int) Image

// Generate image: cellular algorithm, bigger tileSize means bigger cells
@[inline]
pub fn gen_image_cellular(width int, height int, tile_size int) Image {
	return C.GenImageCellular(width, height, tile_size)
}

fn C.GenImageText(int, int, &char) Image

// Generate image: grayscale image from text data
@[inline]
pub fn gen_image_text(width int, height int, text string) Image {
	return C.GenImageText(width, height, text.str)
}

fn C.ImageCopy(Image) Image

// Create an image duplicate (useful for transformations)
@[inline]
pub fn image_copy(image Image) Image {
	return C.ImageCopy(image)
}

fn C.ImageFromImage(Image, Rectangle) Image

// Create an image from another image piece
@[inline]
pub fn image_from_image(image Image, rec Rectangle) Image {
	return C.ImageFromImage(image, rec)
}

fn C.ImageFromChannel(Image, int) Image

// Create an image from a selected channel of another image (GRAYSCALE)
@[inline]
pub fn image_from_channel(image Image, selected_channel int) Image {
	return C.ImageFromChannel(image, selected_channel)
}

fn C.ImageText(&char, int, Color) Image

// Create an image from text (default font)
@[inline]
pub fn image_text(text string, font_size int, color Color) Image {
	return C.ImageText(text.str, font_size, color)
}

fn C.ImageTextEx(Font, &char, f32, f32, Color) Image

// Create an image from text (custom sprite font)
@[inline]
pub fn image_text_ex(font Font, text string, font_size f32, spacing f32, tint Color) Image {
	return C.ImageTextEx(font, text.str, font_size, spacing, tint)
}

fn C.ImageFormat(&Image, int)

// Convert image data to desired format
@[inline]
pub fn image_format(image &Image, new_format int) {
	C.ImageFormat(image, new_format)
}

fn C.ImageToPOT(&Image, Color)

// Convert image to POT (power-of-two)
@[inline]
pub fn image_to_pot(image &Image, fill Color) {
	C.ImageToPOT(image, fill)
}

fn C.ImageCrop(&Image, Rectangle)

// Crop an image to a defined rectangle
@[inline]
pub fn image_crop(image &Image, crop Rectangle) {
	C.ImageCrop(image, crop)
}

fn C.ImageAlphaCrop(&Image, f32)

// Crop image depending on alpha value
@[inline]
pub fn image_alpha_crop(image &Image, threshold f32) {
	C.ImageAlphaCrop(image, threshold)
}

fn C.ImageAlphaClear(&Image, Color, f32)

// Clear alpha channel to desired color
@[inline]
pub fn image_alpha_clear(image &Image, color Color, threshold f32) {
	C.ImageAlphaClear(image, color, threshold)
}

fn C.ImageAlphaMask(&Image, Image)

// Apply alpha mask to image
@[inline]
pub fn image_alpha_mask(image &Image, alpha_mask Image) {
	C.ImageAlphaMask(image, alpha_mask)
}

fn C.ImageAlphaPremultiply(&Image)

// Premultiply alpha channel
@[inline]
pub fn image_alpha_premultiply(image &Image) {
	C.ImageAlphaPremultiply(image)
}

fn C.ImageBlurGaussian(&Image, int)

// Apply Gaussian blur using a box blur approximation
@[inline]
pub fn image_blur_gaussian(image &Image, blur_size int) {
	C.ImageBlurGaussian(image, blur_size)
}

fn C.ImageKernelConvolution(&Image, &f32, int)

// Apply custom square convolution kernel to image
@[inline]
pub fn image_kernel_convolution(image &Image, kernel &f32, kernel_size int) {
	C.ImageKernelConvolution(image, kernel, kernel_size)
}

fn C.ImageResize(&Image, int, int)

// Resize image (Bicubic scaling algorithm)
@[inline]
pub fn image_resize(image &Image, new_width int, new_height int) {
	C.ImageResize(image, new_width, new_height)
}

fn C.ImageResizeNN(&Image, int, int)

// Resize image (Nearest-Neighbor scaling algorithm)
@[inline]
pub fn image_resize_nn(image &Image, new_width int, new_height int) {
	C.ImageResizeNN(image, new_width, new_height)
}

fn C.ImageResizeCanvas(&Image, int, int, int, int, Color)

// Resize canvas and fill with color
@[inline]
pub fn image_resize_canvas(image &Image, new_width int, new_height int, offset_x int, offset_y int, fill Color) {
	C.ImageResizeCanvas(image, new_width, new_height, offset_x, offset_y, fill)
}

fn C.ImageMipmaps(&Image)

// Compute all mipmap levels for a provided image
@[inline]
pub fn image_mipmaps(image &Image) {
	C.ImageMipmaps(image)
}

fn C.ImageDither(&Image, int, int, int, int)

// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
@[inline]
pub fn image_dither(image &Image, r_bpp int, g_bpp int, b_bpp int, a_bpp int) {
	C.ImageDither(image, r_bpp, g_bpp, b_bpp, a_bpp)
}

fn C.ImageFlipVertical(&Image)

// Flip image vertically
@[inline]
pub fn image_flip_vertical(image &Image) {
	C.ImageFlipVertical(image)
}

fn C.ImageFlipHorizontal(&Image)

// Flip image horizontally
@[inline]
pub fn image_flip_horizontal(image &Image) {
	C.ImageFlipHorizontal(image)
}

fn C.ImageRotate(&Image, int)

// Rotate image by input angle in degrees (-359 to 359)
@[inline]
pub fn image_rotate(image &Image, degrees int) {
	C.ImageRotate(image, degrees)
}

fn C.ImageRotateCW(&Image)

// Rotate image clockwise 90deg
@[inline]
pub fn image_rotate_cw(image &Image) {
	C.ImageRotateCW(image)
}

fn C.ImageRotateCCW(&Image)

// Rotate image counter-clockwise 90deg
@[inline]
pub fn image_rotate_c_cw(image &Image) {
	C.ImageRotateCCW(image)
}

fn C.ImageColorTint(&Image, Color)

// Modify image color: tint
@[inline]
pub fn image_color_tint(image &Image, color Color) {
	C.ImageColorTint(image, color)
}

fn C.ImageColorInvert(&Image)

// Modify image color: invert
@[inline]
pub fn image_color_invert(image &Image) {
	C.ImageColorInvert(image)
}

fn C.ImageColorGrayscale(&Image)

// Modify image color: grayscale
@[inline]
pub fn image_color_grayscale(image &Image) {
	C.ImageColorGrayscale(image)
}

fn C.ImageColorContrast(&Image, f32)

// Modify image color: contrast (-100 to 100)
@[inline]
pub fn image_color_contrast(image &Image, contrast f32) {
	C.ImageColorContrast(image, contrast)
}

fn C.ImageColorBrightness(&Image, int)

// Modify image color: brightness (-255 to 255)
@[inline]
pub fn image_color_brightness(image &Image, brightness int) {
	C.ImageColorBrightness(image, brightness)
}

fn C.ImageColorReplace(&Image, Color, Color)

// Modify image color: replace color
@[inline]
pub fn image_color_replace(image &Image, color Color, replace Color) {
	C.ImageColorReplace(image, color, replace)
}

fn C.LoadImageColors(Image) &Color

// Load color data from image as a Color array (RGBA - 32bit)
@[inline]
pub fn load_image_colors(image Image) &Color {
	return C.LoadImageColors(image)
}

fn C.LoadImagePalette(Image, int, &int) &Color

// Load colors palette from image as a Color array (RGBA - 32bit)
@[inline]
pub fn load_image_palette(image Image, max_palette_size int, color_count &int) &Color {
	return C.LoadImagePalette(image, max_palette_size, color_count)
}

fn C.UnloadImageColors(&Color)

// Unload color data loaded with LoadImageColors()
@[inline]
pub fn unload_image_colors(colors &Color) {
	C.UnloadImageColors(colors)
}

fn C.UnloadImagePalette(&Color)

// Unload colors palette loaded with LoadImagePalette()
@[inline]
pub fn unload_image_palette(colors &Color) {
	C.UnloadImagePalette(colors)
}

fn C.GetImageAlphaBorder(Image, f32) Rectangle

// Get image alpha border rectangle
@[inline]
pub fn get_image_alpha_border(image Image, threshold f32) Rectangle {
	return C.GetImageAlphaBorder(image, threshold)
}

fn C.GetImageColor(Image, int, int) Color

// Get image pixel color at (x, y) position
@[inline]
pub fn get_image_color(image Image, x int, y int) Color {
	return C.GetImageColor(image, x, y)
}

fn C.ImageClearBackground(&Image, Color)

// Clear image background with given color
@[inline]
pub fn image_clear_background(dst &Image, color Color) {
	C.ImageClearBackground(dst, color)
}

fn C.ImageDrawPixel(&Image, int, int, Color)

// Draw pixel within an image
@[inline]
pub fn image_draw_pixel(dst &Image, pos_x int, pos_y int, color Color) {
	C.ImageDrawPixel(dst, pos_x, pos_y, color)
}

fn C.ImageDrawPixelV(&Image, Vector2, Color)

// Draw pixel within an image (Vector version)
@[inline]
pub fn image_draw_pixel_v(dst &Image, position Vector2, color Color) {
	C.ImageDrawPixelV(dst, position, color)
}

fn C.ImageDrawLine(&Image, int, int, int, int, Color)

// Draw line within an image
@[inline]
pub fn image_draw_line(dst &Image, start_pos_x int, start_pos_y int, end_pos_x int, end_pos_y int, color Color) {
	C.ImageDrawLine(dst, start_pos_x, start_pos_y, end_pos_x, end_pos_y, color)
}

fn C.ImageDrawLineV(&Image, Vector2, Vector2, Color)

// Draw line within an image (Vector version)
@[inline]
pub fn image_draw_line_v(dst &Image, start Vector2, end Vector2, color Color) {
	C.ImageDrawLineV(dst, start, end, color)
}

fn C.ImageDrawLineEx(&Image, Vector2, Vector2, int, Color)

// Draw a line defining thickness within an image
@[inline]
pub fn image_draw_line_ex(dst &Image, start Vector2, end Vector2, thick int, color Color) {
	C.ImageDrawLineEx(dst, start, end, thick, color)
}

fn C.ImageDrawCircle(&Image, int, int, int, Color)

// Draw a filled circle within an image
@[inline]
pub fn image_draw_circle(dst &Image, center_x int, center_y int, radius int, color Color) {
	C.ImageDrawCircle(dst, center_x, center_y, radius, color)
}

fn C.ImageDrawCircleV(&Image, Vector2, int, Color)

// Draw a filled circle within an image (Vector version)
@[inline]
pub fn image_draw_circle_v(dst &Image, center Vector2, radius int, color Color) {
	C.ImageDrawCircleV(dst, center, radius, color)
}

fn C.ImageDrawCircleLines(&Image, int, int, int, Color)

// Draw circle outline within an image
@[inline]
pub fn image_draw_circle_lines(dst &Image, center_x int, center_y int, radius int, color Color) {
	C.ImageDrawCircleLines(dst, center_x, center_y, radius, color)
}

fn C.ImageDrawCircleLinesV(&Image, Vector2, int, Color)

// Draw circle outline within an image (Vector version)
@[inline]
pub fn image_draw_circle_lines_v(dst &Image, center Vector2, radius int, color Color) {
	C.ImageDrawCircleLinesV(dst, center, radius, color)
}

fn C.ImageDrawRectangle(&Image, int, int, int, int, Color)

// Draw rectangle within an image
@[inline]
pub fn image_draw_rectangle(dst &Image, pos_x int, pos_y int, width int, height int, color Color) {
	C.ImageDrawRectangle(dst, pos_x, pos_y, width, height, color)
}

fn C.ImageDrawRectangleV(&Image, Vector2, Vector2, Color)

// Draw rectangle within an image (Vector version)
@[inline]
pub fn image_draw_rectangle_v(dst &Image, position Vector2, size Vector2, color Color) {
	C.ImageDrawRectangleV(dst, position, size, color)
}

fn C.ImageDrawRectangleRec(&Image, Rectangle, Color)

// Draw rectangle within an image
@[inline]
pub fn image_draw_rectangle_rec(dst &Image, rec Rectangle, color Color) {
	C.ImageDrawRectangleRec(dst, rec, color)
}

fn C.ImageDrawRectangleLines(&Image, Rectangle, int, Color)

// Draw rectangle lines within an image
@[inline]
pub fn image_draw_rectangle_lines(dst &Image, rec Rectangle, thick int, color Color) {
	C.ImageDrawRectangleLines(dst, rec, thick, color)
}

fn C.ImageDrawTriangle(&Image, Vector2, Vector2, Vector2, Color)

// Draw triangle within an image
@[inline]
pub fn image_draw_triangle(dst &Image, v1 Vector2, v2 Vector2, v3 Vector2, color Color) {
	C.ImageDrawTriangle(dst, v1, v2, v3, color)
}

fn C.ImageDrawTriangleEx(&Image, Vector2, Vector2, Vector2, Color, Color, Color)

// Draw triangle with interpolated colors within an image
@[inline]
pub fn image_draw_triangle_ex(dst &Image, v1 Vector2, v2 Vector2, v3 Vector2, c1 Color, c2 Color, c3 Color) {
	C.ImageDrawTriangleEx(dst, v1, v2, v3, c1, c2, c3)
}

fn C.ImageDrawTriangleLines(&Image, Vector2, Vector2, Vector2, Color)

// Draw triangle outline within an image
@[inline]
pub fn image_draw_triangle_lines(dst &Image, v1 Vector2, v2 Vector2, v3 Vector2, color Color) {
	C.ImageDrawTriangleLines(dst, v1, v2, v3, color)
}

fn C.ImageDrawTriangleFan(&Image, &Vector2, int, Color)

// Draw a triangle fan defined by points within an image (first vertex is the center)
@[inline]
pub fn image_draw_triangle_fan(dst &Image, points &Vector2, point_count int, color Color) {
	C.ImageDrawTriangleFan(dst, points, point_count, color)
}

fn C.ImageDrawTriangleStrip(&Image, &Vector2, int, Color)

// Draw a triangle strip defined by points within an image
@[inline]
pub fn image_draw_triangle_strip(dst &Image, points &Vector2, point_count int, color Color) {
	C.ImageDrawTriangleStrip(dst, points, point_count, color)
}

fn C.ImageDraw(&Image, Image, Rectangle, Rectangle, Color)

// Draw a source image within a destination image (tint applied to source)
@[inline]
pub fn image_draw(dst &Image, src Image, src_rec Rectangle, dst_rec Rectangle, tint Color) {
	C.ImageDraw(dst, src, src_rec, dst_rec, tint)
}

fn C.ImageDrawText(&Image, &char, int, int, int, Color)

// Draw text (using default font) within an image (destination)
@[inline]
pub fn image_draw_text(dst &Image, text string, pos_x int, pos_y int, font_size int, color Color) {
	C.ImageDrawText(dst, text.str, pos_x, pos_y, font_size, color)
}

fn C.ImageDrawTextEx(&Image, Font, &char, Vector2, f32, f32, Color)

// Draw text (custom sprite font) within an image (destination)
@[inline]
pub fn image_draw_text_ex(dst &Image, font Font, text string, position Vector2, font_size f32, spacing f32, tint Color) {
	C.ImageDrawTextEx(dst, font, text.str, position, font_size, spacing, tint)
}

fn C.LoadTexture(&char) Texture2D

// Load texture from file into GPU memory (VRAM)
@[inline]
pub fn load_texture(file_name string) Texture2D {
	return C.LoadTexture(file_name.str)
}

fn C.LoadTextureFromImage(Image) Texture2D

// Load texture from image data
@[inline]
pub fn load_texture_from_image(image Image) Texture2D {
	return C.LoadTextureFromImage(image)
}

fn C.LoadTextureCubemap(Image, int) TextureCubemap

// Load cubemap from image, multiple image cubemap layouts supported
@[inline]
pub fn load_texture_cubemap(image Image, layout int) TextureCubemap {
	return C.LoadTextureCubemap(image, layout)
}

fn C.LoadRenderTexture(int, int) RenderTexture2D

// Load texture for rendering (framebuffer)
@[inline]
pub fn load_render_texture(width int, height int) RenderTexture2D {
	return C.LoadRenderTexture(width, height)
}

fn C.IsTextureValid(Texture2D) bool

// Check if a texture is valid (loaded in GPU)
@[inline]
pub fn is_texture_valid(texture Texture2D) bool {
	return C.IsTextureValid(texture)
}

fn C.UnloadTexture(Texture2D)

// Unload texture from GPU memory (VRAM)
@[inline]
pub fn unload_texture(texture Texture2D) {
	C.UnloadTexture(texture)
}

fn C.IsRenderTextureValid(RenderTexture2D) bool

// Check if a render texture is valid (loaded in GPU)
@[inline]
pub fn is_render_texture_valid(target RenderTexture2D) bool {
	return C.IsRenderTextureValid(target)
}

fn C.UnloadRenderTexture(RenderTexture2D)

// Unload render texture from GPU memory (VRAM)
@[inline]
pub fn unload_render_texture(target RenderTexture2D) {
	C.UnloadRenderTexture(target)
}

fn C.UpdateTexture(Texture2D, voidptr)

// Update GPU texture with new data
@[inline]
pub fn update_texture(texture Texture2D, pixels voidptr) {
	C.UpdateTexture(texture, pixels)
}

fn C.UpdateTextureRec(Texture2D, Rectangle, voidptr)

// Update GPU texture rectangle with new data
@[inline]
pub fn update_texture_rec(texture Texture2D, rec Rectangle, pixels voidptr) {
	C.UpdateTextureRec(texture, rec, pixels)
}

fn C.GenTextureMipmaps(&Texture2D)

// Generate GPU mipmaps for a texture
@[inline]
pub fn gen_texture_mipmaps(texture &Texture2D) {
	C.GenTextureMipmaps(texture)
}

fn C.SetTextureFilter(Texture2D, int)

// Set texture scaling filter mode
@[inline]
pub fn set_texture_filter(texture Texture2D, filter int) {
	C.SetTextureFilter(texture, filter)
}

fn C.SetTextureWrap(Texture2D, int)

// Set texture wrapping mode
@[inline]
pub fn set_texture_wrap(texture Texture2D, wrap int) {
	C.SetTextureWrap(texture, wrap)
}

fn C.DrawTexture(Texture2D, int, int, Color)

// Draw a Texture2D
@[inline]
pub fn draw_texture(texture Texture2D, pos_x int, pos_y int, tint Color) {
	C.DrawTexture(texture, pos_x, pos_y, tint)
}

fn C.DrawTextureV(Texture2D, Vector2, Color)

// Draw a Texture2D with position defined as Vector2
@[inline]
pub fn draw_texture_v(texture Texture2D, position Vector2, tint Color) {
	C.DrawTextureV(texture, position, tint)
}

fn C.DrawTextureEx(Texture2D, Vector2, f32, f32, Color)

// Draw a Texture2D with extended parameters
@[inline]
pub fn draw_texture_ex(texture Texture2D, position Vector2, rotation f32, scale f32, tint Color) {
	C.DrawTextureEx(texture, position, rotation, scale, tint)
}

fn C.DrawTextureRec(Texture2D, Rectangle, Vector2, Color)

// Draw a part of a texture defined by a rectangle
@[inline]
pub fn draw_texture_rec(texture Texture2D, source Rectangle, position Vector2, tint Color) {
	C.DrawTextureRec(texture, source, position, tint)
}

fn C.DrawTexturePro(Texture2D, Rectangle, Rectangle, Vector2, f32, Color)

// Draw a part of a texture defined by a rectangle with 'pro' parameters
@[inline]
pub fn draw_texture_pro(texture Texture2D, source Rectangle, dest Rectangle, origin Vector2, rotation f32, tint Color) {
	C.DrawTexturePro(texture, source, dest, origin, rotation, tint)
}

fn C.DrawTextureNPatch(Texture2D, NPatchInfo, Rectangle, Vector2, f32, Color)

// Draws a texture (or part of it) that stretches or shrinks nicely
@[inline]
pub fn draw_texture_npatch(texture Texture2D, n_patch_info NPatchInfo, dest Rectangle, origin Vector2, rotation f32, tint Color) {
	C.DrawTextureNPatch(texture, n_patch_info, dest, origin, rotation, tint)
}

fn C.ColorIsEqual(Color, Color) bool

// Check if two colors are equal
@[inline]
pub fn color_is_equal(col1 Color, col2 Color) bool {
	return C.ColorIsEqual(col1, col2)
}

fn C.Fade(Color, f32) Color

// Get color with alpha applied, alpha goes from 0.0f to 1.0f
@[inline]
pub fn fade(color Color, alpha f32) Color {
	return C.Fade(color, alpha)
}

fn C.ColorToInt(Color) int

// Get hexadecimal value for a Color (0xRRGGBBAA)
@[inline]
pub fn color_to_int(color Color) int {
	return C.ColorToInt(color)
}

fn C.ColorNormalize(Color) Vector4

// Get Color normalized as float [0..1]
@[inline]
pub fn color_normalize(color Color) Vector4 {
	return C.ColorNormalize(color)
}

fn C.ColorFromNormalized(Vector4) Color

// Get Color from normalized values [0..1]
@[inline]
pub fn color_from_normalized(normalized Vector4) Color {
	return C.ColorFromNormalized(normalized)
}

fn C.ColorToHSV(Color) Vector3

// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
@[inline]
pub fn color_to_hsv(color Color) Vector3 {
	return C.ColorToHSV(color)
}

fn C.ColorFromHSV(f32, f32, f32) Color

// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
@[inline]
pub fn color_from_hsv(hue f32, saturation f32, value f32) Color {
	return C.ColorFromHSV(hue, saturation, value)
}

fn C.ColorTint(Color, Color) Color

// Get color multiplied with another color
@[inline]
pub fn color_tint(color Color, tint Color) Color {
	return C.ColorTint(color, tint)
}

fn C.ColorBrightness(Color, f32) Color

// Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
@[inline]
pub fn color_brightness(color Color, factor f32) Color {
	return C.ColorBrightness(color, factor)
}

fn C.ColorContrast(Color, f32) Color

// Get color with contrast correction, contrast values between -1.0f and 1.0f
@[inline]
pub fn color_contrast(color Color, contrast f32) Color {
	return C.ColorContrast(color, contrast)
}

fn C.ColorAlpha(Color, f32) Color

// Get color with alpha applied, alpha goes from 0.0f to 1.0f
@[inline]
pub fn color_alpha(color Color, alpha f32) Color {
	return C.ColorAlpha(color, alpha)
}

fn C.ColorAlphaBlend(Color, Color, Color) Color

// Get src alpha-blended into dst color with tint
@[inline]
pub fn color_alpha_blend(dst Color, src Color, tint Color) Color {
	return C.ColorAlphaBlend(dst, src, tint)
}

fn C.ColorLerp(Color, Color, f32) Color

// Get color lerp interpolation between two colors, factor [0.0f..1.0f]
@[inline]
pub fn color_lerp(color1 Color, color2 Color, factor f32) Color {
	return C.ColorLerp(color1, color2, factor)
}

fn C.GetColor(u32) Color

// Get Color structure from hexadecimal value
@[inline]
pub fn get_color(hex_value u32) Color {
	return C.GetColor(hex_value)
}

fn C.GetPixelColor(voidptr, int) Color

// Get Color from a source pixel pointer of certain format
@[inline]
pub fn get_pixel_color(src_ptr voidptr, format int) Color {
	return C.GetPixelColor(src_ptr, format)
}

fn C.SetPixelColor(voidptr, Color, int)

// Set color formatted into destination pixel pointer
@[inline]
pub fn set_pixel_color(dst_ptr voidptr, color Color, format int) {
	C.SetPixelColor(dst_ptr, color, format)
}

fn C.GetPixelDataSize(int, int, int) int

// Get pixel data size in bytes for certain format
@[inline]
pub fn get_pixel_data_size(width int, height int, format int) int {
	return C.GetPixelDataSize(width, height, format)
}

fn C.GetFontDefault() Font

// Get the default Font
@[inline]
pub fn get_font_default() Font {
	return C.GetFontDefault()
}

fn C.LoadFont(&char) Font

// Load font from file into GPU memory (VRAM)
@[inline]
pub fn load_font(file_name string) Font {
	return C.LoadFont(file_name.str)
}

fn C.LoadFontEx(&char, int, &int, int) Font

// Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height
@[inline]
pub fn load_font_ex(file_name string, font_size int, codepoints &int, codepoint_count int) Font {
	return C.LoadFontEx(file_name.str, font_size, codepoints, codepoint_count)
}

fn C.LoadFontFromImage(Image, Color, int) Font

// Load font from Image (XNA style)
@[inline]
pub fn load_font_from_image(image Image, key Color, first_char int) Font {
	return C.LoadFontFromImage(image, key, first_char)
}

fn C.LoadFontFromMemory(&char, &u8, int, int, &int, int) Font

// Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
@[inline]
pub fn load_font_from_memory(file_type string, file_data &u8, data_size int, font_size int, codepoints &int, codepoint_count int) Font {
	return C.LoadFontFromMemory(file_type.str, file_data, data_size, font_size, codepoints,
		codepoint_count)
}

fn C.IsFontValid(Font) bool

// Check if a font is valid (font data loaded, WARNING: GPU texture not checked)
@[inline]
pub fn is_font_valid(font Font) bool {
	return C.IsFontValid(font)
}

fn C.LoadFontData(&u8, int, int, &int, int, int) &GlyphInfo

// Load font data for further use
@[inline]
pub fn load_font_data(file_data &u8, data_size int, font_size int, codepoints &int, codepoint_count int, typ int) &GlyphInfo {
	return C.LoadFontData(file_data, data_size, font_size, codepoints, codepoint_count,
		typ)
}

fn C.GenImageFontAtlas(&GlyphInfo, &&Rectangle, int, int, int, int) Image

// Generate image font atlas using chars info
@[inline]
pub fn gen_image_font_atlas(glyphs &GlyphInfo, glyph_recs &&Rectangle, glyph_count int, font_size int, padding int, pack_method int) Image {
	return C.GenImageFontAtlas(glyphs, glyph_recs, glyph_count, font_size, padding, pack_method)
}

fn C.UnloadFontData(&GlyphInfo, int)

// Unload font chars info data (RAM)
@[inline]
pub fn unload_font_data(glyphs &GlyphInfo, glyph_count int) {
	C.UnloadFontData(glyphs, glyph_count)
}

fn C.UnloadFont(Font)

// Unload font from GPU memory (VRAM)
@[inline]
pub fn unload_font(font Font) {
	C.UnloadFont(font)
}

fn C.ExportFontAsCode(Font, &char) bool

// Export font as code file, returns true on success
@[inline]
pub fn export_font_as_code(font Font, file_name string) bool {
	return C.ExportFontAsCode(font, file_name.str)
}

fn C.DrawFPS(int, int)

// Draw current FPS
@[inline]
pub fn draw_fps(pos_x int, pos_y int) {
	C.DrawFPS(pos_x, pos_y)
}

fn C.DrawText(&char, int, int, int, Color)

// Draw text (using default font)
@[inline]
pub fn draw_text(text string, pos_x int, pos_y int, font_size int, color Color) {
	C.DrawText(text.str, pos_x, pos_y, font_size, color)
}

fn C.DrawTextEx(Font, &char, Vector2, f32, f32, Color)

// Draw text using font and additional parameters
@[inline]
pub fn draw_text_ex(font Font, text string, position Vector2, font_size f32, spacing f32, tint Color) {
	C.DrawTextEx(font, text.str, position, font_size, spacing, tint)
}

fn C.DrawTextPro(Font, &char, Vector2, Vector2, f32, f32, f32, Color)

// Draw text using Font and pro parameters (rotation)
@[inline]
pub fn draw_text_pro(font Font, text string, position Vector2, origin Vector2, rotation f32, font_size f32, spacing f32, tint Color) {
	C.DrawTextPro(font, text.str, position, origin, rotation, font_size, spacing, tint)
}

fn C.DrawTextCodepoint(Font, int, Vector2, f32, Color)

// Draw one character (codepoint)
@[inline]
pub fn draw_text_codepoint(font Font, codepoint int, position Vector2, font_size f32, tint Color) {
	C.DrawTextCodepoint(font, codepoint, position, font_size, tint)
}

fn C.DrawTextCodepoints(Font, &int, int, Vector2, f32, f32, Color)

// Draw multiple character (codepoint)
@[inline]
pub fn draw_text_codepoints(font Font, codepoints &int, codepoint_count int, position Vector2, font_size f32, spacing f32, tint Color) {
	C.DrawTextCodepoints(font, codepoints, codepoint_count, position, font_size, spacing,
		tint)
}

fn C.SetTextLineSpacing(int)

// Set vertical line spacing when drawing with line-breaks
@[inline]
pub fn set_text_line_spacing(spacing int) {
	C.SetTextLineSpacing(spacing)
}

fn C.MeasureText(&char, int) int

// Measure string width for default font
@[inline]
pub fn measure_text(text string, font_size int) int {
	return C.MeasureText(text.str, font_size)
}

fn C.MeasureTextEx(Font, &char, f32, f32) Vector2

// Measure string size for Font
@[inline]
pub fn measure_text_ex(font Font, text string, font_size f32, spacing f32) Vector2 {
	return C.MeasureTextEx(font, text.str, font_size, spacing)
}

fn C.GetGlyphIndex(Font, int) int

// Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
@[inline]
pub fn get_glyph_index(font Font, codepoint int) int {
	return C.GetGlyphIndex(font, codepoint)
}

fn C.GetGlyphInfo(Font, int) GlyphInfo

// Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
@[inline]
pub fn get_glyph_info(font Font, codepoint int) GlyphInfo {
	return C.GetGlyphInfo(font, codepoint)
}

fn C.GetGlyphAtlasRec(Font, int) Rectangle

// Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
@[inline]
pub fn get_glyph_atlas_rec(font Font, codepoint int) Rectangle {
	return C.GetGlyphAtlasRec(font, codepoint)
}

fn C.LoadUTF8(&int, int) &char

// Load UTF-8 text encoded from codepoints array
@[inline]
pub fn load_utf8(codepoints &int, length int) string {
	unsafe {
		return C.LoadUTF8(codepoints, length).vstring()
	}
}

fn C.UnloadUTF8(&char)

// Unload UTF-8 text encoded from codepoints array
@[inline]
pub fn unload_utf8(text string) {
	C.UnloadUTF8(text.str)
}

fn C.LoadCodepoints(&char, &int) &int

// Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
@[inline]
pub fn load_codepoints(text string, count &int) &int {
	return C.LoadCodepoints(text.str, count)
}

fn C.UnloadCodepoints(&int)

// Unload codepoints data from memory
@[inline]
pub fn unload_codepoints(codepoints &int) {
	C.UnloadCodepoints(codepoints)
}

fn C.GetCodepointCount(&char) int

// Get total number of codepoints in a UTF-8 encoded string
@[inline]
pub fn get_codepoint_count(text string) int {
	return C.GetCodepointCount(text.str)
}

fn C.GetCodepoint(&char, &int) int

// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
@[inline]
pub fn get_codepoint(text string, codepoint_size &int) int {
	return C.GetCodepoint(text.str, codepoint_size)
}

fn C.GetCodepointNext(&char, &int) int

// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
@[inline]
pub fn get_codepoint_next(text string, codepoint_size &int) int {
	return C.GetCodepointNext(text.str, codepoint_size)
}

fn C.GetCodepointPrevious(&char, &int) int

// Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
@[inline]
pub fn get_codepoint_previous(text string, codepoint_size &int) int {
	return C.GetCodepointPrevious(text.str, codepoint_size)
}

fn C.CodepointToUTF8(int, &int) &char

// Encode one codepoint into UTF-8 byte array (array length returned as parameter)
@[inline]
pub fn codepoint_to_utf8(codepoint int, utf8_size &int) string {
	unsafe {
		return C.CodepointToUTF8(codepoint, utf8_size).vstring()
	}
}

fn C.TextCopy(&char, &char) int

// Copy one string to another, returns bytes copied
@[inline]
pub fn text_copy(dst string, src string) int {
	return C.TextCopy(dst.str, src.str)
}

fn C.TextIsEqual(&char, &char) bool

// Check if two text string are equal
@[inline]
pub fn text_is_equal(text1 string, text2 string) bool {
	return C.TextIsEqual(text1.str, text2.str)
}

fn C.TextLength(&char) u32

// Get text length, checks for '\0' ending
@[inline]
pub fn text_length(text string) u32 {
	return C.TextLength(text.str)
}

fn C.TextFormat(&char, ...any) &char

// Text formatting with variables (sprintf() style)
@[inline]
pub fn text_format(text string, args ...any) string {
	unsafe {
		return C.TextFormat(text.str, ...args).vstring()
	}
}

fn C.TextSubtext(&char, int, int) &char

// Get a piece of a text string
@[inline]
pub fn text_subtext(text string, position int, length int) string {
	unsafe {
		return C.TextSubtext(text.str, position, length).vstring()
	}
}

fn C.TextReplace(&char, &char, &char) &char

// Replace text string (WARNING: memory must be freed!)
@[inline]
pub fn text_replace(text string, replace string, by string) string {
	unsafe {
		return C.TextReplace(text.str, replace.str, by.str).vstring()
	}
}

fn C.TextInsert(&char, &char, int) &char

// Insert text in a position (WARNING: memory must be freed!)
@[inline]
pub fn text_insert(text string, insert string, position int) string {
	unsafe {
		return C.TextInsert(text.str, insert.str, position).vstring()
	}
}

fn C.TextJoin(&&char, int, &char) &char

// Join text strings with delimiter
@[inline]
pub fn text_join(text_list &&char, count int, delimiter string) string {
	unsafe {
		return C.TextJoin(text_list, count, delimiter.str).vstring()
	}
}

fn C.TextSplit(&char, char, &int) &&char

// Split text into multiple strings
@[inline]
pub fn text_split(text string, delimiter char, count &int) &&char {
	return C.TextSplit(text.str, delimiter, count)
}

fn C.TextAppend(&char, &char, &int)

// Append text at specific position and move cursor!
@[inline]
pub fn text_append(text string, append string, position &int) {
	C.TextAppend(text.str, append.str, position)
}

fn C.TextFindIndex(&char, &char) int

// Find first text occurrence within a string
@[inline]
pub fn text_find_index(text string, find string) int {
	return C.TextFindIndex(text.str, find.str)
}

fn C.TextToUpper(&char) &char

// Get upper case version of provided string
@[inline]
pub fn text_to_upper(text string) string {
	unsafe {
		return C.TextToUpper(text.str).vstring()
	}
}

fn C.TextToLower(&char) &char

// Get lower case version of provided string
@[inline]
pub fn text_to_lower(text string) string {
	unsafe {
		return C.TextToLower(text.str).vstring()
	}
}

fn C.TextToPascal(&char) &char

// Get Pascal case notation version of provided string
@[inline]
pub fn text_to_pascal(text string) string {
	unsafe {
		return C.TextToPascal(text.str).vstring()
	}
}

fn C.TextToSnake(&char) &char

// Get Snake case notation version of provided string
@[inline]
pub fn text_to_snake(text string) string {
	unsafe {
		return C.TextToSnake(text.str).vstring()
	}
}

fn C.TextToCamel(&char) &char

// Get Camel case notation version of provided string
@[inline]
pub fn text_to_camel(text string) string {
	unsafe {
		return C.TextToCamel(text.str).vstring()
	}
}

fn C.TextToInteger(&char) int

// Get integer value from text (negative values not supported)
@[inline]
pub fn text_to_integer(text string) int {
	return C.TextToInteger(text.str)
}

fn C.TextToFloat(&char) f32

// Get float value from text (negative values not supported)
@[inline]
pub fn text_to_float(text string) f32 {
	return C.TextToFloat(text.str)
}

fn C.DrawLine3D(Vector3, Vector3, Color)

// Draw a line in 3D world space
@[inline]
pub fn draw_line_3d(start_pos Vector3, end_pos Vector3, color Color) {
	C.DrawLine3D(start_pos, end_pos, color)
}

fn C.DrawPoint3D(Vector3, Color)

// Draw a point in 3D space, actually a small line
@[inline]
pub fn draw_point_3d(position Vector3, color Color) {
	C.DrawPoint3D(position, color)
}

fn C.DrawCircle3D(Vector3, f32, Vector3, f32, Color)

// Draw a circle in 3D world space
@[inline]
pub fn draw_circle_3d(center Vector3, radius f32, rotation_axis Vector3, rotation_angle f32, color Color) {
	C.DrawCircle3D(center, radius, rotation_axis, rotation_angle, color)
}

fn C.DrawTriangle3D(Vector3, Vector3, Vector3, Color)

// Draw a color-filled triangle (vertex in counter-clockwise order!)
@[inline]
pub fn draw_triangle_3d(v1 Vector3, v2 Vector3, v3 Vector3, color Color) {
	C.DrawTriangle3D(v1, v2, v3, color)
}

fn C.DrawTriangleStrip3D(&Vector3, int, Color)

// Draw a triangle strip defined by points
@[inline]
pub fn draw_triangle_strip_3d(points &Vector3, point_count int, color Color) {
	C.DrawTriangleStrip3D(points, point_count, color)
}

fn C.DrawCube(Vector3, f32, f32, f32, Color)

// Draw cube
@[inline]
pub fn draw_cube(position Vector3, width f32, height f32, length f32, color Color) {
	C.DrawCube(position, width, height, length, color)
}

fn C.DrawCubeV(Vector3, Vector3, Color)

// Draw cube (Vector version)
@[inline]
pub fn draw_cube_v(position Vector3, size Vector3, color Color) {
	C.DrawCubeV(position, size, color)
}

fn C.DrawCubeWires(Vector3, f32, f32, f32, Color)

// Draw cube wires
@[inline]
pub fn draw_cube_wires(position Vector3, width f32, height f32, length f32, color Color) {
	C.DrawCubeWires(position, width, height, length, color)
}

fn C.DrawCubeWiresV(Vector3, Vector3, Color)

// Draw cube wires (Vector version)
@[inline]
pub fn draw_cube_wires_v(position Vector3, size Vector3, color Color) {
	C.DrawCubeWiresV(position, size, color)
}

fn C.DrawSphere(Vector3, f32, Color)

// Draw sphere
@[inline]
pub fn draw_sphere(center_pos Vector3, radius f32, color Color) {
	C.DrawSphere(center_pos, radius, color)
}

fn C.DrawSphereEx(Vector3, f32, int, int, Color)

// Draw sphere with extended parameters
@[inline]
pub fn draw_sphere_ex(center_pos Vector3, radius f32, rings int, slices int, color Color) {
	C.DrawSphereEx(center_pos, radius, rings, slices, color)
}

fn C.DrawSphereWires(Vector3, f32, int, int, Color)

// Draw sphere wires
@[inline]
pub fn draw_sphere_wires(center_pos Vector3, radius f32, rings int, slices int, color Color) {
	C.DrawSphereWires(center_pos, radius, rings, slices, color)
}

fn C.DrawCylinder(Vector3, f32, f32, f32, int, Color)

// Draw a cylinder/cone
@[inline]
pub fn draw_cylinder(position Vector3, radius_top f32, radius_bottom f32, height f32, slices int, color Color) {
	C.DrawCylinder(position, radius_top, radius_bottom, height, slices, color)
}

fn C.DrawCylinderEx(Vector3, Vector3, f32, f32, int, Color)

// Draw a cylinder with base at startPos and top at endPos
@[inline]
pub fn draw_cylinder_ex(start_pos Vector3, end_pos Vector3, start_radius f32, end_radius f32, sides int, color Color) {
	C.DrawCylinderEx(start_pos, end_pos, start_radius, end_radius, sides, color)
}

fn C.DrawCylinderWires(Vector3, f32, f32, f32, int, Color)

// Draw a cylinder/cone wires
@[inline]
pub fn draw_cylinder_wires(position Vector3, radius_top f32, radius_bottom f32, height f32, slices int, color Color) {
	C.DrawCylinderWires(position, radius_top, radius_bottom, height, slices, color)
}

fn C.DrawCylinderWiresEx(Vector3, Vector3, f32, f32, int, Color)

// Draw a cylinder wires with base at startPos and top at endPos
@[inline]
pub fn draw_cylinder_wires_ex(start_pos Vector3, end_pos Vector3, start_radius f32, end_radius f32, sides int, color Color) {
	C.DrawCylinderWiresEx(start_pos, end_pos, start_radius, end_radius, sides, color)
}

fn C.DrawCapsule(Vector3, Vector3, f32, int, int, Color)

// Draw a capsule with the center of its sphere caps at startPos and endPos
@[inline]
pub fn draw_capsule(start_pos Vector3, end_pos Vector3, radius f32, slices int, rings int, color Color) {
	C.DrawCapsule(start_pos, end_pos, radius, slices, rings, color)
}

fn C.DrawCapsuleWires(Vector3, Vector3, f32, int, int, Color)

// Draw capsule wireframe with the center of its sphere caps at startPos and endPos
@[inline]
pub fn draw_capsule_wires(start_pos Vector3, end_pos Vector3, radius f32, slices int, rings int, color Color) {
	C.DrawCapsuleWires(start_pos, end_pos, radius, slices, rings, color)
}

fn C.DrawPlane(Vector3, Vector2, Color)

// Draw a plane XZ
@[inline]
pub fn draw_plane(center_pos Vector3, size Vector2, color Color) {
	C.DrawPlane(center_pos, size, color)
}

fn C.DrawRay(Ray, Color)

// Draw a ray line
@[inline]
pub fn draw_ray(ray Ray, color Color) {
	C.DrawRay(ray, color)
}

fn C.DrawGrid(int, f32)

// Draw a grid (centered at (0, 0, 0))
@[inline]
pub fn draw_grid(slices int, spacing f32) {
	C.DrawGrid(slices, spacing)
}

fn C.LoadModel(&char) Model

// Load model from files (meshes and materials)
@[inline]
pub fn load_model(file_name string) Model {
	return C.LoadModel(file_name.str)
}

fn C.LoadModelFromMesh(Mesh) Model

// Load model from generated mesh (default material)
@[inline]
pub fn load_model_from_mesh(mesh Mesh) Model {
	return C.LoadModelFromMesh(mesh)
}

fn C.IsModelValid(Model) bool

// Check if a model is valid (loaded in GPU, VAO/VBOs)
@[inline]
pub fn is_model_valid(model Model) bool {
	return C.IsModelValid(model)
}

fn C.UnloadModel(Model)

// Unload model (including meshes) from memory (RAM and/or VRAM)
@[inline]
pub fn unload_model(model Model) {
	C.UnloadModel(model)
}

fn C.GetModelBoundingBox(Model) BoundingBox

// Compute model bounding box limits (considers all meshes)
@[inline]
pub fn get_model_bounding_box(model Model) BoundingBox {
	return C.GetModelBoundingBox(model)
}

fn C.DrawModel(Model, Vector3, f32, Color)

// Draw a model (with texture if set)
@[inline]
pub fn draw_model(model Model, position Vector3, scale f32, tint Color) {
	C.DrawModel(model, position, scale, tint)
}

fn C.DrawModelEx(Model, Vector3, Vector3, f32, Vector3, Color)

// Draw a model with extended parameters
@[inline]
pub fn draw_model_ex(model Model, position Vector3, rotation_axis Vector3, rotation_angle f32, scale Vector3, tint Color) {
	C.DrawModelEx(model, position, rotation_axis, rotation_angle, scale, tint)
}

fn C.DrawModelWires(Model, Vector3, f32, Color)

// Draw a model wires (with texture if set)
@[inline]
pub fn draw_model_wires(model Model, position Vector3, scale f32, tint Color) {
	C.DrawModelWires(model, position, scale, tint)
}

fn C.DrawModelWiresEx(Model, Vector3, Vector3, f32, Vector3, Color)

// Draw a model wires (with texture if set) with extended parameters
@[inline]
pub fn draw_model_wires_ex(model Model, position Vector3, rotation_axis Vector3, rotation_angle f32, scale Vector3, tint Color) {
	C.DrawModelWiresEx(model, position, rotation_axis, rotation_angle, scale, tint)
}

fn C.DrawModelPoints(Model, Vector3, f32, Color)

// Draw a model as points
@[inline]
pub fn draw_model_points(model Model, position Vector3, scale f32, tint Color) {
	C.DrawModelPoints(model, position, scale, tint)
}

fn C.DrawModelPointsEx(Model, Vector3, Vector3, f32, Vector3, Color)

// Draw a model as points with extended parameters
@[inline]
pub fn draw_model_points_ex(model Model, position Vector3, rotation_axis Vector3, rotation_angle f32, scale Vector3, tint Color) {
	C.DrawModelPointsEx(model, position, rotation_axis, rotation_angle, scale, tint)
}

fn C.DrawBoundingBox(BoundingBox, Color)

// Draw bounding box (wires)
@[inline]
pub fn draw_bounding_box(box BoundingBox, color Color) {
	C.DrawBoundingBox(box, color)
}

fn C.DrawBillboard(Camera, Texture2D, Vector3, f32, Color)

// Draw a billboard texture
@[inline]
pub fn draw_billboard(camera Camera, texture Texture2D, position Vector3, scale f32, tint Color) {
	C.DrawBillboard(camera, texture, position, scale, tint)
}

fn C.DrawBillboardRec(Camera, Texture2D, Rectangle, Vector3, Vector2, Color)

// Draw a billboard texture defined by source
@[inline]
pub fn draw_billboard_rec(camera Camera, texture Texture2D, source Rectangle, position Vector3, size Vector2, tint Color) {
	C.DrawBillboardRec(camera, texture, source, position, size, tint)
}

fn C.DrawBillboardPro(Camera, Texture2D, Rectangle, Vector3, Vector3, Vector2, Vector2, f32, Color)

// Draw a billboard texture defined by source and rotation
@[inline]
pub fn draw_billboard_pro(camera Camera, texture Texture2D, source Rectangle, position Vector3, up Vector3, size Vector2, origin Vector2, rotation f32, tint Color) {
	C.DrawBillboardPro(camera, texture, source, position, up, size, origin, rotation,
		tint)
}

fn C.UploadMesh(&Mesh, bool)

// Upload mesh vertex data in GPU and provide VAO/VBO ids
@[inline]
pub fn upload_mesh(mesh &Mesh, dynamic bool) {
	C.UploadMesh(mesh, dynamic)
}

fn C.UpdateMeshBuffer(Mesh, int, voidptr, int, int)

// Update mesh vertex data in GPU for a specific buffer index
@[inline]
pub fn update_mesh_buffer(mesh Mesh, index int, data voidptr, data_size int, offset int) {
	C.UpdateMeshBuffer(mesh, index, data, data_size, offset)
}

fn C.UnloadMesh(Mesh)

// Unload mesh data from CPU and GPU
@[inline]
pub fn unload_mesh(mesh Mesh) {
	C.UnloadMesh(mesh)
}

fn C.DrawMesh(Mesh, Material, Matrix)

// Draw a 3d mesh with material and transform
@[inline]
pub fn draw_mesh(mesh Mesh, material Material, transform Matrix) {
	C.DrawMesh(mesh, material, transform)
}

fn C.DrawMeshInstanced(Mesh, Material, &Matrix, int)

// Draw multiple mesh instances with material and different transforms
@[inline]
pub fn draw_mesh_instanced(mesh Mesh, material Material, transforms &Matrix, instances int) {
	C.DrawMeshInstanced(mesh, material, transforms, instances)
}

fn C.GetMeshBoundingBox(Mesh) BoundingBox

// Compute mesh bounding box limits
@[inline]
pub fn get_mesh_bounding_box(mesh Mesh) BoundingBox {
	return C.GetMeshBoundingBox(mesh)
}

fn C.GenMeshTangents(&Mesh)

// Compute mesh tangents
@[inline]
pub fn gen_mesh_tangents(mesh &Mesh) {
	C.GenMeshTangents(mesh)
}

fn C.ExportMesh(Mesh, &char) bool

// Export mesh data to file, returns true on success
@[inline]
pub fn export_mesh(mesh Mesh, file_name string) bool {
	return C.ExportMesh(mesh, file_name.str)
}

fn C.ExportMeshAsCode(Mesh, &char) bool

// Export mesh as code file (.h) defining multiple arrays of vertex attributes
@[inline]
pub fn export_mesh_as_code(mesh Mesh, file_name string) bool {
	return C.ExportMeshAsCode(mesh, file_name.str)
}

fn C.GenMeshPoly(int, f32) Mesh

// Generate polygonal mesh
@[inline]
pub fn gen_mesh_poly(sides int, radius f32) Mesh {
	return C.GenMeshPoly(sides, radius)
}

fn C.GenMeshPlane(f32, f32, int, int) Mesh

// Generate plane mesh (with subdivisions)
@[inline]
pub fn gen_mesh_plane(width f32, length f32, res_x int, res_z int) Mesh {
	return C.GenMeshPlane(width, length, res_x, res_z)
}

fn C.GenMeshCube(f32, f32, f32) Mesh

// Generate cuboid mesh
@[inline]
pub fn gen_mesh_cube(width f32, height f32, length f32) Mesh {
	return C.GenMeshCube(width, height, length)
}

fn C.GenMeshSphere(f32, int, int) Mesh

// Generate sphere mesh (standard sphere)
@[inline]
pub fn gen_mesh_sphere(radius f32, rings int, slices int) Mesh {
	return C.GenMeshSphere(radius, rings, slices)
}

fn C.GenMeshHemiSphere(f32, int, int) Mesh

// Generate half-sphere mesh (no bottom cap)
@[inline]
pub fn gen_mesh_hemi_sphere(radius f32, rings int, slices int) Mesh {
	return C.GenMeshHemiSphere(radius, rings, slices)
}

fn C.GenMeshCylinder(f32, f32, int) Mesh

// Generate cylinder mesh
@[inline]
pub fn gen_mesh_cylinder(radius f32, height f32, slices int) Mesh {
	return C.GenMeshCylinder(radius, height, slices)
}

fn C.GenMeshCone(f32, f32, int) Mesh

// Generate cone/pyramid mesh
@[inline]
pub fn gen_mesh_cone(radius f32, height f32, slices int) Mesh {
	return C.GenMeshCone(radius, height, slices)
}

fn C.GenMeshTorus(f32, f32, int, int) Mesh

// Generate torus mesh
@[inline]
pub fn gen_mesh_torus(radius f32, size f32, rad_seg int, sides int) Mesh {
	return C.GenMeshTorus(radius, size, rad_seg, sides)
}

fn C.GenMeshKnot(f32, f32, int, int) Mesh

// Generate trefoil knot mesh
@[inline]
pub fn gen_mesh_knot(radius f32, size f32, rad_seg int, sides int) Mesh {
	return C.GenMeshKnot(radius, size, rad_seg, sides)
}

fn C.GenMeshHeightmap(Image, Vector3) Mesh

// Generate heightmap mesh from image data
@[inline]
pub fn gen_mesh_heightmap(heightmap Image, size Vector3) Mesh {
	return C.GenMeshHeightmap(heightmap, size)
}

fn C.GenMeshCubicmap(Image, Vector3) Mesh

// Generate cubes-based map mesh from image data
@[inline]
pub fn gen_mesh_cubicmap(cubicmap Image, cube_size Vector3) Mesh {
	return C.GenMeshCubicmap(cubicmap, cube_size)
}

fn C.LoadMaterials(&char, &int) &Material

// Load materials from model file
@[inline]
pub fn load_materials(file_name string, material_count &int) &Material {
	return C.LoadMaterials(file_name.str, material_count)
}

fn C.LoadMaterialDefault() Material

// Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
@[inline]
pub fn load_material_default() Material {
	return C.LoadMaterialDefault()
}

fn C.IsMaterialValid(Material) bool

// Check if a material is valid (shader assigned, map textures loaded in GPU)
@[inline]
pub fn is_material_valid(material Material) bool {
	return C.IsMaterialValid(material)
}

fn C.UnloadMaterial(Material)

// Unload material from GPU memory (VRAM)
@[inline]
pub fn unload_material(material Material) {
	C.UnloadMaterial(material)
}

fn C.SetMaterialTexture(&Material, int, Texture2D)

// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
@[inline]
pub fn set_material_texture(material &Material, map_type int, texture Texture2D) {
	C.SetMaterialTexture(material, map_type, texture)
}

fn C.SetModelMeshMaterial(&Model, int, int)

// Set material for a mesh
@[inline]
pub fn set_model_mesh_material(model &Model, mesh_id int, material_id int) {
	C.SetModelMeshMaterial(model, mesh_id, material_id)
}

fn C.LoadModelAnimations(&char, &int) &ModelAnimation

// Load model animations from file
@[inline]
pub fn load_model_animations(file_name string, anim_count &int) &ModelAnimation {
	return C.LoadModelAnimations(file_name.str, anim_count)
}

fn C.UpdateModelAnimation(Model, ModelAnimation, int)

// Update model animation pose (CPU)
@[inline]
pub fn update_model_animation(model Model, anim ModelAnimation, frame int) {
	C.UpdateModelAnimation(model, anim, frame)
}

fn C.UpdateModelAnimationBones(Model, ModelAnimation, int)

// Update model animation mesh bone matrices (GPU skinning)
@[inline]
pub fn update_model_animation_bones(model Model, anim ModelAnimation, frame int) {
	C.UpdateModelAnimationBones(model, anim, frame)
}

fn C.UnloadModelAnimation(ModelAnimation)

// Unload animation data
@[inline]
pub fn unload_model_animation(anim ModelAnimation) {
	C.UnloadModelAnimation(anim)
}

fn C.UnloadModelAnimations(&ModelAnimation, int)

// Unload animation array data
@[inline]
pub fn unload_model_animations(animations &ModelAnimation, anim_count int) {
	C.UnloadModelAnimations(animations, anim_count)
}

fn C.IsModelAnimationValid(Model, ModelAnimation) bool

// Check model animation skeleton match
@[inline]
pub fn is_model_animation_valid(model Model, anim ModelAnimation) bool {
	return C.IsModelAnimationValid(model, anim)
}

fn C.CheckCollisionSpheres(Vector3, f32, Vector3, f32) bool

// Check collision between two spheres
@[inline]
pub fn check_collision_spheres(center1 Vector3, radius1 f32, center2 Vector3, radius2 f32) bool {
	return C.CheckCollisionSpheres(center1, radius1, center2, radius2)
}

fn C.CheckCollisionBoxes(BoundingBox, BoundingBox) bool

// Check collision between two bounding boxes
@[inline]
pub fn check_collision_boxes(box1 BoundingBox, box2 BoundingBox) bool {
	return C.CheckCollisionBoxes(box1, box2)
}

fn C.CheckCollisionBoxSphere(BoundingBox, Vector3, f32) bool

// Check collision between box and sphere
@[inline]
pub fn check_collision_box_sphere(box BoundingBox, center Vector3, radius f32) bool {
	return C.CheckCollisionBoxSphere(box, center, radius)
}

fn C.GetRayCollisionSphere(Ray, Vector3, f32) RayCollision

// Get collision info between ray and sphere
@[inline]
pub fn get_ray_collision_sphere(ray Ray, center Vector3, radius f32) RayCollision {
	return C.GetRayCollisionSphere(ray, center, radius)
}

fn C.GetRayCollisionBox(Ray, BoundingBox) RayCollision

// Get collision info between ray and box
@[inline]
pub fn get_ray_collision_box(ray Ray, box BoundingBox) RayCollision {
	return C.GetRayCollisionBox(ray, box)
}

fn C.GetRayCollisionMesh(Ray, Mesh, Matrix) RayCollision

// Get collision info between ray and mesh
@[inline]
pub fn get_ray_collision_mesh(ray Ray, mesh Mesh, transform Matrix) RayCollision {
	return C.GetRayCollisionMesh(ray, mesh, transform)
}

fn C.GetRayCollisionTriangle(Ray, Vector3, Vector3, Vector3) RayCollision

// Get collision info between ray and triangle
@[inline]
pub fn get_ray_collision_triangle(ray Ray, p1 Vector3, p2 Vector3, p3 Vector3) RayCollision {
	return C.GetRayCollisionTriangle(ray, p1, p2, p3)
}

fn C.GetRayCollisionQuad(Ray, Vector3, Vector3, Vector3, Vector3) RayCollision

// Get collision info between ray and quad
@[inline]
pub fn get_ray_collision_quad(ray Ray, p1 Vector3, p2 Vector3, p3 Vector3, p4 Vector3) RayCollision {
	return C.GetRayCollisionQuad(ray, p1, p2, p3, p4)
}

fn C.InitAudioDevice()

// Initialize audio device and context
@[inline]
pub fn init_audio_device() {
	C.InitAudioDevice()
}

fn C.CloseAudioDevice()

// Close the audio device and context
@[inline]
pub fn close_audio_device() {
	C.CloseAudioDevice()
}

fn C.IsAudioDeviceReady() bool

// Check if audio device has been initialized successfully
@[inline]
pub fn is_audio_device_ready() bool {
	return C.IsAudioDeviceReady()
}

fn C.SetMasterVolume(f32)

// Set master volume (listener)
@[inline]
pub fn set_master_volume(volume f32) {
	C.SetMasterVolume(volume)
}

fn C.GetMasterVolume() f32

// Get master volume (listener)
@[inline]
pub fn get_master_volume() f32 {
	return C.GetMasterVolume()
}

fn C.LoadWave(&char) Wave

// Load wave data from file
@[inline]
pub fn load_wave(file_name string) Wave {
	return C.LoadWave(file_name.str)
}

fn C.LoadWaveFromMemory(&char, &u8, int) Wave

// Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
@[inline]
pub fn load_wave_from_memory(file_type string, file_data &u8, data_size int) Wave {
	return C.LoadWaveFromMemory(file_type.str, file_data, data_size)
}

fn C.IsWaveValid(Wave) bool

// Checks if wave data is valid (data loaded and parameters)
@[inline]
pub fn is_wave_valid(wave Wave) bool {
	return C.IsWaveValid(wave)
}

fn C.LoadSound(&char) Sound

// Load sound from file
@[inline]
pub fn load_sound(file_name string) Sound {
	return C.LoadSound(file_name.str)
}

fn C.LoadSoundFromWave(Wave) Sound

// Load sound from wave data
@[inline]
pub fn load_sound_from_wave(wave Wave) Sound {
	return C.LoadSoundFromWave(wave)
}

fn C.LoadSoundAlias(Sound) Sound

// Create a new sound that shares the same sample data as the source sound, does not own the sound data
@[inline]
pub fn load_sound_alias(source Sound) Sound {
	return C.LoadSoundAlias(source)
}

fn C.IsSoundValid(Sound) bool

// Checks if a sound is valid (data loaded and buffers initialized)
@[inline]
pub fn is_sound_valid(sound Sound) bool {
	return C.IsSoundValid(sound)
}

fn C.UpdateSound(Sound, voidptr, int)

// Update sound buffer with new data
@[inline]
pub fn update_sound(sound Sound, data voidptr, sample_count int) {
	C.UpdateSound(sound, data, sample_count)
}

fn C.UnloadWave(Wave)

// Unload wave data
@[inline]
pub fn unload_wave(wave Wave) {
	C.UnloadWave(wave)
}

fn C.UnloadSound(Sound)

// Unload sound
@[inline]
pub fn unload_sound(sound Sound) {
	C.UnloadSound(sound)
}

fn C.UnloadSoundAlias(Sound)

// Unload a sound alias (does not deallocate sample data)
@[inline]
pub fn unload_sound_alias(alias Sound) {
	C.UnloadSoundAlias(alias)
}

fn C.ExportWave(Wave, &char) bool

// Export wave data to file, returns true on success
@[inline]
pub fn export_wave(wave Wave, file_name string) bool {
	return C.ExportWave(wave, file_name.str)
}

fn C.ExportWaveAsCode(Wave, &char) bool

// Export wave sample data to code (.h), returns true on success
@[inline]
pub fn export_wave_as_code(wave Wave, file_name string) bool {
	return C.ExportWaveAsCode(wave, file_name.str)
}

fn C.PlaySound(Sound)

// Play a sound
@[inline]
pub fn play_sound(sound Sound) {
	C.PlaySound(sound)
}

fn C.StopSound(Sound)

// Stop playing a sound
@[inline]
pub fn stop_sound(sound Sound) {
	C.StopSound(sound)
}

fn C.PauseSound(Sound)

// Pause a sound
@[inline]
pub fn pause_sound(sound Sound) {
	C.PauseSound(sound)
}

fn C.ResumeSound(Sound)

// Resume a paused sound
@[inline]
pub fn resume_sound(sound Sound) {
	C.ResumeSound(sound)
}

fn C.IsSoundPlaying(Sound) bool

// Check if a sound is currently playing
@[inline]
pub fn is_sound_playing(sound Sound) bool {
	return C.IsSoundPlaying(sound)
}

fn C.SetSoundVolume(Sound, f32)

// Set volume for a sound (1.0 is max level)
@[inline]
pub fn set_sound_volume(sound Sound, volume f32) {
	C.SetSoundVolume(sound, volume)
}

fn C.SetSoundPitch(Sound, f32)

// Set pitch for a sound (1.0 is base level)
@[inline]
pub fn set_sound_pitch(sound Sound, pitch f32) {
	C.SetSoundPitch(sound, pitch)
}

fn C.SetSoundPan(Sound, f32)

// Set pan for a sound (0.5 is center)
@[inline]
pub fn set_sound_pan(sound Sound, pan f32) {
	C.SetSoundPan(sound, pan)
}

fn C.WaveCopy(Wave) Wave

// Copy a wave to a new wave
@[inline]
pub fn wave_copy(wave Wave) Wave {
	return C.WaveCopy(wave)
}

fn C.WaveCrop(&Wave, int, int)

// Crop a wave to defined frames range
@[inline]
pub fn wave_crop(wave &Wave, init_frame int, final_frame int) {
	C.WaveCrop(wave, init_frame, final_frame)
}

fn C.WaveFormat(&Wave, int, int, int)

// Convert wave data to desired format
@[inline]
pub fn wave_format(wave &Wave, sample_rate int, sample_size int, channels int) {
	C.WaveFormat(wave, sample_rate, sample_size, channels)
}

fn C.LoadWaveSamples(Wave) &f32

// Load samples data from wave as a 32bit float data array
@[inline]
pub fn load_wave_samples(wave Wave) &f32 {
	return C.LoadWaveSamples(wave)
}

fn C.UnloadWaveSamples(&f32)

// Unload samples data loaded with LoadWaveSamples()
@[inline]
pub fn unload_wave_samples(samples &f32) {
	C.UnloadWaveSamples(samples)
}

fn C.LoadMusicStream(&char) Music

// Load music stream from file
@[inline]
pub fn load_music_stream(file_name string) Music {
	return C.LoadMusicStream(file_name.str)
}

fn C.LoadMusicStreamFromMemory(&char, &u8, int) Music

// Load music stream from data
@[inline]
pub fn load_music_stream_from_memory(file_type string, data &u8, data_size int) Music {
	return C.LoadMusicStreamFromMemory(file_type.str, data, data_size)
}

fn C.IsMusicValid(Music) bool

// Checks if a music stream is valid (context and buffers initialized)
@[inline]
pub fn is_music_valid(music Music) bool {
	return C.IsMusicValid(music)
}

fn C.UnloadMusicStream(Music)

// Unload music stream
@[inline]
pub fn unload_music_stream(music Music) {
	C.UnloadMusicStream(music)
}

fn C.PlayMusicStream(Music)

// Start music playing
@[inline]
pub fn play_music_stream(music Music) {
	C.PlayMusicStream(music)
}

fn C.IsMusicStreamPlaying(Music) bool

// Check if music is playing
@[inline]
pub fn is_music_stream_playing(music Music) bool {
	return C.IsMusicStreamPlaying(music)
}

fn C.UpdateMusicStream(Music)

// Updates buffers for music streaming
@[inline]
pub fn update_music_stream(music Music) {
	C.UpdateMusicStream(music)
}

fn C.StopMusicStream(Music)

// Stop music playing
@[inline]
pub fn stop_music_stream(music Music) {
	C.StopMusicStream(music)
}

fn C.PauseMusicStream(Music)

// Pause music playing
@[inline]
pub fn pause_music_stream(music Music) {
	C.PauseMusicStream(music)
}

fn C.ResumeMusicStream(Music)

// Resume playing paused music
@[inline]
pub fn resume_music_stream(music Music) {
	C.ResumeMusicStream(music)
}

fn C.SeekMusicStream(Music, f32)

// Seek music to a position (in seconds)
@[inline]
pub fn seek_music_stream(music Music, position f32) {
	C.SeekMusicStream(music, position)
}

fn C.SetMusicVolume(Music, f32)

// Set volume for music (1.0 is max level)
@[inline]
pub fn set_music_volume(music Music, volume f32) {
	C.SetMusicVolume(music, volume)
}

fn C.SetMusicPitch(Music, f32)

// Set pitch for a music (1.0 is base level)
@[inline]
pub fn set_music_pitch(music Music, pitch f32) {
	C.SetMusicPitch(music, pitch)
}

fn C.SetMusicPan(Music, f32)

// Set pan for a music (0.5 is center)
@[inline]
pub fn set_music_pan(music Music, pan f32) {
	C.SetMusicPan(music, pan)
}

fn C.GetMusicTimeLength(Music) f32

// Get music time length (in seconds)
@[inline]
pub fn get_music_time_length(music Music) f32 {
	return C.GetMusicTimeLength(music)
}

fn C.GetMusicTimePlayed(Music) f32

// Get current music time played (in seconds)
@[inline]
pub fn get_music_time_played(music Music) f32 {
	return C.GetMusicTimePlayed(music)
}

fn C.LoadAudioStream(u32, u32, u32) AudioStream

// Load audio stream (to stream raw audio pcm data)
@[inline]
pub fn load_audio_stream(sample_rate u32, sample_size u32, channels u32) AudioStream {
	return C.LoadAudioStream(sample_rate, sample_size, channels)
}

fn C.IsAudioStreamValid(AudioStream) bool

// Checks if an audio stream is valid (buffers initialized)
@[inline]
pub fn is_audio_stream_valid(stream AudioStream) bool {
	return C.IsAudioStreamValid(stream)
}

fn C.UnloadAudioStream(AudioStream)

// Unload audio stream and free memory
@[inline]
pub fn unload_audio_stream(stream AudioStream) {
	C.UnloadAudioStream(stream)
}

fn C.UpdateAudioStream(AudioStream, voidptr, int)

// Update audio stream buffers with data
@[inline]
pub fn update_audio_stream(stream AudioStream, data voidptr, frame_count int) {
	C.UpdateAudioStream(stream, data, frame_count)
}

fn C.IsAudioStreamProcessed(AudioStream) bool

// Check if any audio stream buffers requires refill
@[inline]
pub fn is_audio_stream_processed(stream AudioStream) bool {
	return C.IsAudioStreamProcessed(stream)
}

fn C.PlayAudioStream(AudioStream)

// Play audio stream
@[inline]
pub fn play_audio_stream(stream AudioStream) {
	C.PlayAudioStream(stream)
}

fn C.PauseAudioStream(AudioStream)

// Pause audio stream
@[inline]
pub fn pause_audio_stream(stream AudioStream) {
	C.PauseAudioStream(stream)
}

fn C.ResumeAudioStream(AudioStream)

// Resume audio stream
@[inline]
pub fn resume_audio_stream(stream AudioStream) {
	C.ResumeAudioStream(stream)
}

fn C.IsAudioStreamPlaying(AudioStream) bool

// Check if audio stream is playing
@[inline]
pub fn is_audio_stream_playing(stream AudioStream) bool {
	return C.IsAudioStreamPlaying(stream)
}

fn C.StopAudioStream(AudioStream)

// Stop audio stream
@[inline]
pub fn stop_audio_stream(stream AudioStream) {
	C.StopAudioStream(stream)
}

fn C.SetAudioStreamVolume(AudioStream, f32)

// Set volume for audio stream (1.0 is max level)
@[inline]
pub fn set_audio_stream_volume(stream AudioStream, volume f32) {
	C.SetAudioStreamVolume(stream, volume)
}

fn C.SetAudioStreamPitch(AudioStream, f32)

// Set pitch for audio stream (1.0 is base level)
@[inline]
pub fn set_audio_stream_pitch(stream AudioStream, pitch f32) {
	C.SetAudioStreamPitch(stream, pitch)
}

fn C.SetAudioStreamPan(AudioStream, f32)

// Set pan for audio stream (0.5 is centered)
@[inline]
pub fn set_audio_stream_pan(stream AudioStream, pan f32) {
	C.SetAudioStreamPan(stream, pan)
}

fn C.SetAudioStreamBufferSizeDefault(int)

// Default size for new audio streams
@[inline]
pub fn set_audio_stream_buffer_size_default(size int) {
	C.SetAudioStreamBufferSizeDefault(size)
}

fn C.SetAudioStreamCallback(AudioStream, AudioCallback)

// Audio thread callback to request new data
@[inline]
pub fn set_audio_stream_callback(stream AudioStream, callback AudioCallback) {
	C.SetAudioStreamCallback(stream, callback)
}

fn C.AttachAudioStreamProcessor(AudioStream, AudioCallback)

// Attach audio stream processor to stream, receives the samples as 'float'
@[inline]
pub fn attach_audio_stream_processor(stream AudioStream, processor AudioCallback) {
	C.AttachAudioStreamProcessor(stream, processor)
}

fn C.DetachAudioStreamProcessor(AudioStream, AudioCallback)

// Detach audio stream processor from stream
@[inline]
pub fn detach_audio_stream_processor(stream AudioStream, processor AudioCallback) {
	C.DetachAudioStreamProcessor(stream, processor)
}

fn C.AttachAudioMixedProcessor(AudioCallback)

// Attach audio stream processor to the entire audio pipeline, receives the samples as 'float'
@[inline]
pub fn attach_audio_mixed_processor(processor AudioCallback) {
	C.AttachAudioMixedProcessor(processor)
}

fn C.DetachAudioMixedProcessor(AudioCallback)

// Detach audio stream processor from the entire audio pipeline
@[inline]
pub fn detach_audio_mixed_processor(processor AudioCallback) {
	C.DetachAudioMixedProcessor(processor)
}
