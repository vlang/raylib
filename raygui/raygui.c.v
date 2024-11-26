module raygui

import raylib { Color, Font, Rectangle, Vector2, Vector3 }

pub type GuiStyleProp = C.GuiStyleProp

// NOTE: Used when exporting style as code for convenience
pub struct C.GuiStyleProp {
	// Control identifier
	control_id u16
	// Property identifier
	property_id u16
	// Property value
	property_value int
}

pub type GuiTextStyle = C.GuiTextStyle

// NOTE: Text style is defined by control
pub struct C.GuiTextStyle {
	size         u32
	char_spacing int
	line_spacing int
	alignment_h  int
	alignment_v  int
	padding      int
}

// Gui control state
pub enum GuiState {
	state_normal   = 0
	state_focused  = 1
	state_pressed  = 2
	state_disabled = 3
}

// Gui control text alignment
pub enum GuiTextAlignment {
	text_align_left   = 0
	text_align_center = 1
	text_align_right  = 2
}

// Gui control text alignment vertical
pub enum GuiTextAlignmentVertical {
	text_align_top    = 0
	text_align_middle = 1
	text_align_bottom = 2
}

// Gui control text wrap mode
pub enum GuiTextWrapMode {
	text_wrap_none = 0
	text_wrap_char = 1
	text_wrap_word = 2
}

// Gui controls
pub enum GuiControl {
	default     = 0
	label       = 1  // Used also for: LABELBUTTON
	button      = 2
	toggle      = 3  // Used also for: TOGGLEGROUP
	slider      = 4  // Used also for: SLIDERBAR, TOGGLESLIDER
	progressbar = 5
	checkbox    = 6
	combobox    = 7
	dropdownbox = 8
	textbox     = 9  // Used also for: TEXTBOXMULTI
	valuebox    = 10
	spinner     = 11 // Uses: BUTTON, VALUEBOX
	listview    = 12
	colorpicker = 13
	scrollbar   = 14
	statusbar   = 15
}

// Gui base properties for every control
pub enum GuiControlProperty {
	border_color_normal   = 0  // Control border color in STATE_NORMAL
	base_color_normal     = 1  // Control base color in STATE_NORMAL
	text_color_normal     = 2  // Control text color in STATE_NORMAL
	border_color_focused  = 3  // Control border color in STATE_FOCUSED
	base_color_focused    = 4  // Control base color in STATE_FOCUSED
	text_color_focused    = 5  // Control text color in STATE_FOCUSED
	border_color_pressed  = 6  // Control border color in STATE_PRESSED
	base_color_pressed    = 7  // Control base color in STATE_PRESSED
	text_color_pressed    = 8  // Control text color in STATE_PRESSED
	border_color_disabled = 9  // Control border color in STATE_DISABLED
	base_color_disabled   = 10 // Control base color in STATE_DISABLED
	text_color_disabled   = 11 // Control text color in STATE_DISABLED
	border_width          = 12 // Control border size, 0 for no border
	text_padding          = 13 // Control text padding, not considering border
	text_alignment        = 14 // Control text horizontal alignment inside control text bound (after border and padding)
}

// DEFAULT extended properties
pub enum GuiDefaultProperty {
	text_size               = 16 // Text size (glyphs max height)
	text_spacing            = 17 // Text spacing between glyphs
	line_color              = 18 // Line control color
	background_color        = 19 // Background color
	text_line_spacing       = 20 // Text spacing between lines
	text_alignment_vertical = 21 // Text vertical alignment inside text bounds (after border and padding)
	text_wrap_mode          = 22 // Text wrap-mode inside text bounds
}

// Toggle/ToggleGroup
pub enum GuiToggleProperty {
	group_padding = 16 // ToggleGroup separation between toggles
}

// Slider/SliderBar
pub enum GuiSliderProperty {
	slider_width   = 16 // Slider size of internal bar
	slider_padding = 17 // Slider/SliderBar internal bar padding
}

// ProgressBar
pub enum GuiProgressBarProperty {
	progress_padding = 16 // ProgressBar internal padding
}

// ScrollBar
pub enum GuiScrollBarProperty {
	arrows_size           = 16 // ScrollBar arrows size
	arrows_visible        = 17 // ScrollBar arrows visible
	scroll_slider_padding = 18 // ScrollBar slider internal padding
	scroll_slider_size    = 19 // ScrollBar slider size
	scroll_padding        = 20 // ScrollBar scroll padding from arrows
	scroll_speed          = 21 // ScrollBar scrolling speed
}

// CheckBox
pub enum GuiCheckBoxProperty {
	check_padding = 16 // CheckBox internal check padding
}

// ComboBox
pub enum GuiComboBoxProperty {
	combo_button_width   = 16 // ComboBox right button width
	combo_button_spacing = 17 // ComboBox button separation
}

// DropdownBox
pub enum GuiDropdownBoxProperty {
	arrow_padding          = 16 // DropdownBox arrow separation from border and items
	dropdown_items_spacing = 17 // DropdownBox items separation
	dropdown_arrow_hidden  = 18 // DropdownBox arrow hidden
	dropdown_roll_up       = 19 // DropdownBox roll up flag (default rolls down)
}

// TextBox/TextBoxMulti/ValueBox/Spinner
pub enum GuiTextBoxProperty {
	text_readonly = 16 // TextBox in read-only mode: 0-text editable, 1-text no-editable
}

// Spinner
pub enum GuiSpinnerProperty {
	spin_button_width   = 16 // Spinner left/right buttons width
	spin_button_spacing = 17 // Spinner buttons separation
}

// ListView
pub enum GuiListViewProperty {
	list_items_height       = 16 // ListView items height
	list_items_spacing      = 17 // ListView items separation
	scrollbar_width         = 18 // ListView scrollbar size (usually width)
	scrollbar_side          = 19 // ListView scrollbar side (0-SCROLLBAR_LEFT_SIDE, 1-SCROLLBAR_RIGHT_SIDE)
	list_items_border_width = 20 // ListView items border width
}

// ColorPicker
pub enum GuiColorPickerProperty {
	color_selector_size      = 16
	huebar_width             = 17 // ColorPicker right hue bar width
	huebar_padding           = 18 // ColorPicker right hue bar separation from panel
	huebar_selector_height   = 19 // ColorPicker right hue bar selector height
	huebar_selector_overflow = 20 // ColorPicker right hue bar selector overflow
}

pub enum GuiIconName {
	icon_none                    = 0
	icon_folder_file_open        = 1
	icon_file_save_classic       = 2
	icon_folder_open             = 3
	icon_folder_save             = 4
	icon_file_open               = 5
	icon_file_save               = 6
	icon_file_export             = 7
	icon_file_add                = 8
	icon_file_delete             = 9
	icon_filetype_text           = 10
	icon_filetype_audio          = 11
	icon_filetype_image          = 12
	icon_filetype_play           = 13
	icon_filetype_video          = 14
	icon_filetype_info           = 15
	icon_file_copy               = 16
	icon_file_cut                = 17
	icon_file_paste              = 18
	icon_cursor_hand             = 19
	icon_cursor_pointer          = 20
	icon_cursor_classic          = 21
	icon_pencil                  = 22
	icon_pencil_big              = 23
	icon_brush_classic           = 24
	icon_brush_painter           = 25
	icon_water_drop              = 26
	icon_color_picker            = 27
	icon_rubber                  = 28
	icon_color_bucket            = 29
	icon_text_t                  = 30
	icon_text_a                  = 31
	icon_scale                   = 32
	icon_resize                  = 33
	icon_filter_point            = 34
	icon_filter_bilinear         = 35
	icon_crop                    = 36
	icon_crop_alpha              = 37
	icon_square_toggle           = 38
	icon_symmetry                = 39
	icon_symmetry_horizontal     = 40
	icon_symmetry_vertical       = 41
	icon_lens                    = 42
	icon_lens_big                = 43
	icon_eye_on                  = 44
	icon_eye_off                 = 45
	icon_filter_top              = 46
	icon_filter                  = 47
	icon_target_point            = 48
	icon_target_small            = 49
	icon_target_big              = 50
	icon_target_move             = 51
	icon_cursor_move             = 52
	icon_cursor_scale            = 53
	icon_cursor_scale_right      = 54
	icon_cursor_scale_left       = 55
	icon_undo                    = 56
	icon_redo                    = 57
	icon_reredo                  = 58
	icon_mutate                  = 59
	icon_rotate                  = 60
	icon_repeat                  = 61
	icon_shuffle                 = 62
	icon_emptybox                = 63
	icon_target                  = 64
	icon_target_small_fill       = 65
	icon_target_big_fill         = 66
	icon_target_move_fill        = 67
	icon_cursor_move_fill        = 68
	icon_cursor_scale_fill       = 69
	icon_cursor_scale_right_fill = 70
	icon_cursor_scale_left_fill  = 71
	icon_undo_fill               = 72
	icon_redo_fill               = 73
	icon_reredo_fill             = 74
	icon_mutate_fill             = 75
	icon_rotate_fill             = 76
	icon_repeat_fill             = 77
	icon_shuffle_fill            = 78
	icon_emptybox_small          = 79
	icon_box                     = 80
	icon_box_top                 = 81
	icon_box_top_right           = 82
	icon_box_right               = 83
	icon_box_bottom_right        = 84
	icon_box_bottom              = 85
	icon_box_bottom_left         = 86
	icon_box_left                = 87
	icon_box_top_left            = 88
	icon_box_center              = 89
	icon_box_circle_mask         = 90
	icon_pot                     = 91
	icon_alpha_multiply          = 92
	icon_alpha_clear             = 93
	icon_dithering               = 94
	icon_mipmaps                 = 95
	icon_box_grid                = 96
	icon_grid                    = 97
	icon_box_corners_small       = 98
	icon_box_corners_big         = 99
	icon_four_boxes              = 100
	icon_grid_fill               = 101
	icon_box_multisize           = 102
	icon_zoom_small              = 103
	icon_zoom_medium             = 104
	icon_zoom_big                = 105
	icon_zoom_all                = 106
	icon_zoom_center             = 107
	icon_box_dots_small          = 108
	icon_box_dots_big            = 109
	icon_box_concentric          = 110
	icon_box_grid_big            = 111
	icon_ok_tick                 = 112
	icon_cross                   = 113
	icon_arrow_left              = 114
	icon_arrow_right             = 115
	icon_arrow_down              = 116
	icon_arrow_up                = 117
	icon_arrow_left_fill         = 118
	icon_arrow_right_fill        = 119
	icon_arrow_down_fill         = 120
	icon_arrow_up_fill           = 121
	icon_audio                   = 122
	icon_fx                      = 123
	icon_wave                    = 124
	icon_wave_sinus              = 125
	icon_wave_square             = 126
	icon_wave_triangular         = 127
	icon_cross_small             = 128
	icon_player_previous         = 129
	icon_player_play_back        = 130
	icon_player_play             = 131
	icon_player_pause            = 132
	icon_player_stop             = 133
	icon_player_next             = 134
	icon_player_record           = 135
	icon_magnet                  = 136
	icon_lock_close              = 137
	icon_lock_open               = 138
	icon_clock                   = 139
	icon_tools                   = 140
	icon_gear                    = 141
	icon_gear_big                = 142
	icon_bin                     = 143
	icon_hand_pointer            = 144
	icon_laser                   = 145
	icon_coin                    = 146
	icon_explosion               = 147
	icon_1up                     = 148
	icon_player                  = 149
	icon_player_jump             = 150
	icon_key                     = 151
	icon_demon                   = 152
	icon_text_popup              = 153
	icon_gear_ex                 = 154
	icon_crack                   = 155
	icon_crack_points            = 156
	icon_star                    = 157
	icon_door                    = 158
	icon_exit                    = 159
	icon_mode_2d                 = 160
	icon_mode_3d                 = 161
	icon_cube                    = 162
	icon_cube_face_top           = 163
	icon_cube_face_left          = 164
	icon_cube_face_front         = 165
	icon_cube_face_bottom        = 166
	icon_cube_face_right         = 167
	icon_cube_face_back          = 168
	icon_camera                  = 169
	icon_special                 = 170
	icon_link_net                = 171
	icon_link_boxes              = 172
	icon_link_multi              = 173
	icon_link                    = 174
	icon_link_broke              = 175
	icon_text_notes              = 176
	icon_notebook                = 177
	icon_suitcase                = 178
	icon_suitcase_zip            = 179
	icon_mailbox                 = 180
	icon_monitor                 = 181
	icon_printer                 = 182
	icon_photo_camera            = 183
	icon_photo_camera_flash      = 184
	icon_house                   = 185
	icon_heart                   = 186
	icon_corner                  = 187
	icon_vertical_bars           = 188
	icon_vertical_bars_fill      = 189
	icon_life_bars               = 190
	icon_info                    = 191
	icon_crossline               = 192
	icon_help                    = 193
	icon_filetype_alpha          = 194
	icon_filetype_home           = 195
	icon_layers_visible          = 196
	icon_layers                  = 197
	icon_window                  = 198
	icon_hidpi                   = 199
	icon_filetype_binary         = 200
	icon_hex                     = 201
	icon_shield                  = 202
	icon_file_new                = 203
	icon_folder_add              = 204
	icon_alarm                   = 205
	icon_cpu                     = 206
	icon_rom                     = 207
	icon_step_over               = 208
	icon_step_into               = 209
	icon_step_out                = 210
	icon_restart                 = 211
	icon_breakpoint_on           = 212
	icon_breakpoint_off          = 213
	icon_burger_menu             = 214
	icon_case_sensitive          = 215
	icon_reg_exp                 = 216
	icon_folder                  = 217
	icon_file                    = 218
	icon_sand_timer              = 219
	icon_warning                 = 220
	icon_help_box                = 221
	icon_info_box                = 222
	icon_priority                = 223
	icon_layers_iso              = 224
	icon_layers2                 = 225
	icon_mlayers                 = 226
	icon_maps                    = 227
	icon_hot                     = 228
	icon_229                     = 229
	icon_230                     = 230
	icon_231                     = 231
	icon_232                     = 232
	icon_233                     = 233
	icon_234                     = 234
	icon_235                     = 235
	icon_236                     = 236
	icon_237                     = 237
	icon_238                     = 238
	icon_239                     = 239
	icon_240                     = 240
	icon_241                     = 241
	icon_242                     = 242
	icon_243                     = 243
	icon_244                     = 244
	icon_245                     = 245
	icon_246                     = 246
	icon_247                     = 247
	icon_248                     = 248
	icon_249                     = 249
	icon_250                     = 250
	icon_251                     = 251
	icon_252                     = 252
	icon_253                     = 253
	icon_254                     = 254
	icon_255                     = 255
}

fn C.GuiEnable()

// Enable gui controls (global state)
@[inline]
pub fn gui_enable() {
	C.GuiEnable()
}

fn C.GuiDisable()

// Disable gui controls (global state)
@[inline]
pub fn gui_disable() {
	C.GuiDisable()
}

fn C.GuiLock()

// Lock gui controls (global state)
@[inline]
pub fn gui_lock() {
	C.GuiLock()
}

fn C.GuiUnlock()

// Unlock gui controls (global state)
@[inline]
pub fn gui_unlock() {
	C.GuiUnlock()
}

fn C.GuiIsLocked() bool

// Check if gui is locked (global state)
@[inline]
pub fn gui_is_locked() bool {
	return C.GuiIsLocked()
}

fn C.GuiSetAlpha(f32)

// Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f
@[inline]
pub fn gui_set_alpha(alpha f32) {
	C.GuiSetAlpha(alpha)
}

fn C.GuiSetState(int)

// Set gui state (global state)
@[inline]
pub fn gui_set_state(state int) {
	C.GuiSetState(state)
}

fn C.GuiGetState() int

// Get gui state (global state)
@[inline]
pub fn gui_get_state() int {
	return C.GuiGetState()
}

fn C.GuiSetFont(Font)

// Set gui custom font (global state)
@[inline]
pub fn gui_set_font(font Font) {
	C.GuiSetFont(font)
}

fn C.GuiGetFont() Font

// Get gui custom font (global state)
@[inline]
pub fn gui_get_font() Font {
	return C.GuiGetFont()
}

fn C.GuiSetStyle(int, int, int)

// Set one style property
@[inline]
pub fn gui_set_style(control int, property int, value int) {
	C.GuiSetStyle(control, property, value)
}

fn C.GuiGetStyle(int, int) int

// Get one style property
@[inline]
pub fn gui_get_style(control int, property int) int {
	return C.GuiGetStyle(control, property)
}

fn C.GuiLoadStyle(&u8)

// Load style file over global style variable (.rgs)
@[inline]
pub fn gui_load_style(file_name string) {
	C.GuiLoadStyle(file_name.str)
}

fn C.GuiLoadStyleDefault()

// Load style default over global style
@[inline]
pub fn gui_load_style_default() {
	C.GuiLoadStyleDefault()
}

fn C.GuiEnableTooltip()

// Enable gui tooltips (global state)
@[inline]
pub fn gui_enable_tooltip() {
	C.GuiEnableTooltip()
}

fn C.GuiDisableTooltip()

// Disable gui tooltips (global state)
@[inline]
pub fn gui_disable_tooltip() {
	C.GuiDisableTooltip()
}

fn C.GuiSetTooltip(&u8)

// Set tooltip string
@[inline]
pub fn gui_set_tooltip(tooltip string) {
	C.GuiSetTooltip(tooltip.str)
}

fn C.GuiIconText(int, &u8) &u8

// Get text with icon id prepended (if supported)
@[inline]
pub fn gui_icon_text(icon_id int, text string) string {
	unsafe {
		return C.GuiIconText(icon_id, text.str).vstring()
	}
}

fn C.GuiSetIconScale(int)

// Set default icon drawing size
@[inline]
pub fn gui_set_icon_scale(scale int) {
	C.GuiSetIconScale(scale)
}

fn C.GuiGetIcons() &u32

// Get raygui icons data pointer
@[inline]
pub fn gui_get_icons() &u32 {
	return C.GuiGetIcons()
}

fn C.GuiLoadIcons(&u8, bool) &&u8

// Load raygui icons file (.rgi) into internal icons data
@[inline]
pub fn gui_load_icons(file_name string, load_icons_name bool) &&u8 {
	return C.GuiLoadIcons(file_name.str, load_icons_name)
}

fn C.GuiDrawIcon(int, int, int, int, Color)

// Draw icon using pixel size at specified position
@[inline]
pub fn gui_draw_icon(icon_id int, pos_x int, pos_y int, pixel_size int, color Color) {
	C.GuiDrawIcon(icon_id, pos_x, pos_y, pixel_size, color)
}

fn C.GuiWindowBox(Rectangle, &u8) int

// Window Box control, shows a window that can be closed
@[inline]
pub fn gui_window_box(bounds Rectangle, title string) int {
	return C.GuiWindowBox(bounds, title.str)
}

fn C.GuiGroupBox(Rectangle, &u8) int

// Group Box control with text name
@[inline]
pub fn gui_group_box(bounds Rectangle, text string) int {
	return C.GuiGroupBox(bounds, text.str)
}

fn C.GuiLine(Rectangle, &u8) int

// Line separator control, could contain text
@[inline]
pub fn gui_line(bounds Rectangle, text string) int {
	return C.GuiLine(bounds, text.str)
}

fn C.GuiPanel(Rectangle, &u8) int

// Panel control, useful to group controls
@[inline]
pub fn gui_panel(bounds Rectangle, text string) int {
	return C.GuiPanel(bounds, text.str)
}

fn C.GuiTabBar(Rectangle, &&u8, int, &int) int

// Tab Bar control, returns TAB to be closed or -1
@[inline]
pub fn gui_tab_bar(bounds Rectangle, text &&u8, count int, active &int) int {
	return C.GuiTabBar(bounds, text, count, active)
}

fn C.GuiScrollPanel(Rectangle, &u8, Rectangle, &Vector2, &Rectangle) int

// Scroll Panel control
@[inline]
pub fn gui_scroll_panel(bounds Rectangle, text string, content Rectangle, scroll &Vector2, view &Rectangle) int {
	return C.GuiScrollPanel(bounds, text.str, content, scroll, view)
}

fn C.GuiLabel(Rectangle, &u8) int

// Label control
@[inline]
pub fn gui_label(bounds Rectangle, text string) int {
	return C.GuiLabel(bounds, text.str)
}

fn C.GuiButton(Rectangle, &u8) int

// Button control, returns true when clicked
@[inline]
pub fn gui_button(bounds Rectangle, text string) int {
	return C.GuiButton(bounds, text.str)
}

fn C.GuiLabelButton(Rectangle, &u8) int

// Label button control, returns true when clicked
@[inline]
pub fn gui_label_button(bounds Rectangle, text string) int {
	return C.GuiLabelButton(bounds, text.str)
}

fn C.GuiToggle(Rectangle, &u8, &bool) int

// Toggle Button control
@[inline]
pub fn gui_toggle(bounds Rectangle, text string, active &bool) int {
	return C.GuiToggle(bounds, text.str, active)
}

fn C.GuiToggleGroup(Rectangle, &u8, &int) int

// Toggle Group control
@[inline]
pub fn gui_toggle_group(bounds Rectangle, text string, active &int) int {
	return C.GuiToggleGroup(bounds, text.str, active)
}

fn C.GuiToggleSlider(Rectangle, &u8, &int) int

// Toggle Slider control
@[inline]
pub fn gui_toggle_slider(bounds Rectangle, text string, active &int) int {
	return C.GuiToggleSlider(bounds, text.str, active)
}

fn C.GuiCheckBox(Rectangle, &u8, &bool) int

// Check Box control, returns true when active
@[inline]
pub fn gui_check_box(bounds Rectangle, text string, checked &bool) int {
	return C.GuiCheckBox(bounds, text.str, checked)
}

fn C.GuiComboBox(Rectangle, &u8, &int) int

// Combo Box control
@[inline]
pub fn gui_combo_box(bounds Rectangle, text string, active &int) int {
	return C.GuiComboBox(bounds, text.str, active)
}

fn C.GuiDropdownBox(Rectangle, &u8, &int, bool) int

// Dropdown Box control
@[inline]
pub fn gui_dropdown_box(bounds Rectangle, text string, active &int, edit_mode bool) int {
	return C.GuiDropdownBox(bounds, text.str, active, edit_mode)
}

fn C.GuiSpinner(Rectangle, &u8, &int, int, int, bool) int

// Spinner control
@[inline]
pub fn gui_spinner(bounds Rectangle, text string, value &int, min_value int, max_value int, edit_mode bool) int {
	return C.GuiSpinner(bounds, text.str, value, min_value, max_value, edit_mode)
}

fn C.GuiValueBox(Rectangle, &u8, &int, int, int, bool) int

// Value Box control, updates input text with numbers
@[inline]
pub fn gui_value_box(bounds Rectangle, text string, value &int, min_value int, max_value int, edit_mode bool) int {
	return C.GuiValueBox(bounds, text.str, value, min_value, max_value, edit_mode)
}

fn C.GuiValueBoxFloat(Rectangle, &u8, &u8, &f32, bool) int

// Value box control for float values
@[inline]
pub fn gui_value_box_float(bounds Rectangle, text string, text_value string, value &f32, edit_mode bool) int {
	return C.GuiValueBoxFloat(bounds, text.str, text_value.str, value, edit_mode)
}

fn C.GuiTextBox(Rectangle, &u8, int, bool) int

// Text Box control, updates input text
@[inline]
pub fn gui_text_box(bounds Rectangle, text string, text_size int, edit_mode bool) int {
	return C.GuiTextBox(bounds, text.str, text_size, edit_mode)
}

fn C.GuiSlider(Rectangle, &u8, &u8, &f32, f32, f32) int

// Slider control
@[inline]
pub fn gui_slider(bounds Rectangle, text_left string, text_right string, value &f32, min_value f32, max_value f32) int {
	return C.GuiSlider(bounds, text_left.str, text_right.str, value, min_value, max_value)
}

fn C.GuiSliderBar(Rectangle, &u8, &u8, &f32, f32, f32) int

// Slider Bar control
@[inline]
pub fn gui_slider_bar(bounds Rectangle, text_left string, text_right string, value &f32, min_value f32, max_value f32) int {
	return C.GuiSliderBar(bounds, text_left.str, text_right.str, value, min_value, max_value)
}

fn C.GuiProgressBar(Rectangle, &u8, &u8, &f32, f32, f32) int

// Progress Bar control
@[inline]
pub fn gui_progress_bar(bounds Rectangle, text_left string, text_right string, value &f32, min_value f32, max_value f32) int {
	return C.GuiProgressBar(bounds, text_left.str, text_right.str, value, min_value, max_value)
}

fn C.GuiStatusBar(Rectangle, &u8) int

// Status Bar control, shows info text
@[inline]
pub fn gui_status_bar(bounds Rectangle, text string) int {
	return C.GuiStatusBar(bounds, text.str)
}

fn C.GuiDummyRec(Rectangle, &u8) int

// Dummy control for placeholders
@[inline]
pub fn gui_dummy_rec(bounds Rectangle, text string) int {
	return C.GuiDummyRec(bounds, text.str)
}

fn C.GuiGrid(Rectangle, &u8, f32, int, &Vector2) int

// Grid control
@[inline]
pub fn gui_grid(bounds Rectangle, text string, spacing f32, subdivs int, mouse_cell &Vector2) int {
	return C.GuiGrid(bounds, text.str, spacing, subdivs, mouse_cell)
}

fn C.GuiListView(Rectangle, &u8, &int, &int) int

// List View control
@[inline]
pub fn gui_list_view(bounds Rectangle, text string, scroll_index &int, active &int) int {
	return C.GuiListView(bounds, text.str, scroll_index, active)
}

fn C.GuiListViewEx(Rectangle, &&u8, int, &int, &int, &int) int

// List View with extended parameters
@[inline]
pub fn gui_list_view_ex(bounds Rectangle, text &&u8, count int, scroll_index &int, active &int, focus &int) int {
	return C.GuiListViewEx(bounds, text, count, scroll_index, active, focus)
}

fn C.GuiMessageBox(Rectangle, &u8, &u8, &u8) int

// Message Box control, displays a message
@[inline]
pub fn gui_message_box(bounds Rectangle, title string, message string, buttons string) int {
	return C.GuiMessageBox(bounds, title.str, message.str, buttons.str)
}

fn C.GuiTextInputBox(Rectangle, &u8, &u8, &u8, &u8, int, &bool) int

// Text Input Box control, ask for text, supports secret
@[inline]
pub fn gui_text_input_box(bounds Rectangle, title string, message string, buttons string, text string, text_max_size int, secret_view_active &bool) int {
	return C.GuiTextInputBox(bounds, title.str, message.str, buttons.str, text.str, text_max_size,
		secret_view_active)
}

fn C.GuiColorPicker(Rectangle, &u8, &Color) int

// Color Picker control (multiple color controls)
@[inline]
pub fn gui_color_picker(bounds Rectangle, text string, color &Color) int {
	return C.GuiColorPicker(bounds, text.str, color)
}

fn C.GuiColorPanel(Rectangle, &u8, &Color) int

// Color Panel control
@[inline]
pub fn gui_color_panel(bounds Rectangle, text string, color &Color) int {
	return C.GuiColorPanel(bounds, text.str, color)
}

fn C.GuiColorBarAlpha(Rectangle, &u8, &f32) int

// Color Bar Alpha control
@[inline]
pub fn gui_color_bar_alpha(bounds Rectangle, text string, alpha &f32) int {
	return C.GuiColorBarAlpha(bounds, text.str, alpha)
}

fn C.GuiColorBarHue(Rectangle, &u8, &f32) int

// Color Bar Hue control
@[inline]
pub fn gui_color_bar_hue(bounds Rectangle, text string, value &f32) int {
	return C.GuiColorBarHue(bounds, text.str, value)
}

fn C.GuiColorPickerHSV(Rectangle, &u8, &Vector3) int

// Color Picker control that avoids conversion to RGB on each call (multiple color controls)
@[inline]
pub fn gui_color_picker_hsv(bounds Rectangle, text string, color_hsv &Vector3) int {
	return C.GuiColorPickerHSV(bounds, text.str, color_hsv)
}

fn C.GuiColorPanelHSV(Rectangle, &u8, &Vector3) int

// Color Panel control that updates Hue-Saturation-Value color value, used by GuiColorPickerHSV()
@[inline]
pub fn gui_color_panel_hsv(bounds Rectangle, text string, color_hsv &Vector3) int {
	return C.GuiColorPanelHSV(bounds, text.str, color_hsv)
}
