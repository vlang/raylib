@[has_globals]
module main

import raylib
import raylib.raymath

const screen_width = 800
const screen_height = 600

const ball_radius = 10
const ball_speed = 5

const paddle_width = 100
const paddle_height = 20
const paddle_speed = 7

const brick_width = 60
const brick_height = 20
const brick_rows = 5
const brick_cols = screen_width / brick_width - 1
const brick_gap = 5

// Game state
__global ball = raylib.Vector2{screen_width / 2, screen_height / 2}
__global ball_direction = raylib.Vector2{1, 1}
__global paddle = raylib.Rectangle{screen_width / 2 - paddle_width / 2, screen_height - paddle_height - 10, paddle_width, paddle_height}
__global bricks = []raylib.Rectangle{}
__global score = 0
__global game_over = false

fn init_bricks() []raylib.Rectangle {
	bricks = []
	bstart := (screen_width + brick_gap - (brick_width + brick_gap) * brick_cols) / 2
	for row := 0; row < brick_rows; row++ {
		for col := 0; col < brick_cols; col++ {
			x := bstart + col * (brick_width + brick_gap)
			y := 80 + row * (brick_height + brick_gap)
			bricks << raylib.Rectangle{x, y, brick_width, brick_height}
		}
	}
	return bricks
}

fn reset_game() {
	ball = raylib.Vector2{screen_width / 2, screen_height / 2}
	ball_direction = raylib.Vector2{1, 1}
	paddle = raylib.Rectangle{screen_width / 2 - paddle_width / 2, screen_height - paddle_height - 10, paddle_width, paddle_height}
	init_bricks()
	score = 0
	game_over = false
}

fn update_game() {
	if game_over {
		if raylib.is_key_pressed(int(raylib.KeyboardKey.key_r)) {
			reset_game()
		}
		return
	}
	// move the paddle:
	if raylib.is_key_down(int(raylib.KeyboardKey.key_left)) && paddle.x > 0 {
		paddle.x -= paddle_speed
	}
	if raylib.is_key_down(int(raylib.KeyboardKey.key_right))
		&& paddle.x < screen_width - paddle.width {
		paddle.x += paddle_speed
	}
	// move the ball:
	ball.x += ball_direction.x * ball_speed
	ball.y += ball_direction.y * ball_speed
	// ball collision with walls
	if ball.x < ball_radius || ball.x > screen_width - ball_radius {
		ball_direction.x *= -1
	}
	if ball.y < ball_radius {
		ball_direction.y *= -1
	}
	// ball collision with paddle:
	if raylib.check_collision_circle_rec(ball, ball_radius, paddle) {
		ball_direction.y *= -1
		// calculate the relative position of the ball hit on the paddle
		hit_position := (ball.x - (paddle.x + paddle.width / 2)) / (paddle.width / 2)
		// adjust the ball's horizontal direction based on the hit position
		ball_direction.x = hit_position * 2
		// avoid excessive angles
		ball_direction.x = raymath.clamp(ball_direction.x, -1, 1)
		ball_direction = raymath.vector2_normalize(ball_direction)
	}
	// ball collision with bricks:
	for i := 0; i < bricks.len; i++ {
		if raylib.check_collision_circle_rec(ball, ball_radius, bricks[i]) {
			ball_direction.y *= -1
			bricks.delete(i)
			score++
			break
		}
	}
	if ball.y > screen_height - ball_radius {
		game_over = true
	}
}

fn draw_game() {
	raylib.begin_drawing()
	raylib.clear_background(raylib.raywhite)
	raylib.draw_circle_v(ball, ball_radius, raylib.red)
	raylib.draw_rectangle_rec(paddle, raylib.black)
	for brick in bricks {
		raylib.draw_rectangle_rec(brick, raylib.blue)
	}
	raylib.draw_text('Score: ${score}', 10, 10, 20, raylib.gray)
	if game_over {
		raylib.draw_text('Game Over! Press R to restart.', screen_width / 2 - 250, screen_height / 2 - 20,
			30, raylib.red)
	}
	raylib.end_drawing()
}

fn main() {
	raylib.set_config_flags(.flag_vsync_hint | .flag_msaa_4x_hint)
	raylib.set_trace_log_level(int(raylib.TraceLogLevel.log_error))
	raylib.init_window(screen_width, screen_height, 'Breakout Game')
	defer { raylib.close_window() }
	raylib.set_target_fps(60)
	init_bricks()
	for !raylib.window_should_close() {
		update_game()
		draw_game()
	}
}
