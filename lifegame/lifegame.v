module main

import rand
import time
import raylib

const window_title = $if prod { 'lifegame' } $else { 'lifegame (debug)' }
const cell_size = 2
const initial_cell_count = 40 * 2
const fps = 30 / 2
const screen_width = 480
const screen_height = 640
const col_size = (screen_width / cell_size + 2)
const row_size = (screen_height / cell_size + 2)
const initial_cell_color = raylib.raywhite
const initial_bg_color = raylib.black

struct App {
mut:
	board           [][]State = [][]State{len: row_size, init: []State{len: col_size}}
	board_neighbors [row_size][col_size]u8
	cell_color      raylib.Color = initial_cell_color
	bg_color        raylib.Color = initial_bg_color
}

enum State as u8 {
	dead
	alive
}

fn (mut app App) new_game() {
	for i in 1 .. row_size - 1 {
		for j in 1 .. col_size - 1 {
			app.board[i][j] = if 1 <= j && j <= initial_cell_count {
				State.alive
			} else {
				State.dead
			}
		}
	}
}

fn (app &App) draw() {
	for i in 1 .. row_size - 1 {
		for j in 1 .. col_size - 1 {
			if app.board[i][j] == State.alive {
				raylib.draw_rectangle(cell_size * (j - 1), cell_size * (i - 1), cell_size,
					cell_size, app.cell_color)
			}
		}
	}
}

fn (mut app App) randomize() ! {
	for i in 1 .. row_size - 1 {
		rand.shuffle(mut app.board[i][1..col_size - 1])!
	}
}

fn (mut app App) change_bg_color() {
	app.bg_color = raylib.Color{rand.u8(), rand.u8(), rand.u8(), 255}
}

fn (mut app App) change_cell_color() {
	app.cell_color = raylib.Color{rand.u8(), rand.u8(), rand.u8(), 255}
}

fn (mut app App) next_generation() {
	for i in 1 .. row_size - 1 {
		for j in 1 .. col_size - 1 {
			// top = top-left + top-middle + top-right
			top := u8(app.board[i - 1][j - 1]) + u8(app.board[i - 1][j]) + u8(app.board[i - 1][j +
				1])
			// middle = left + right
			middle := u8(app.board[i][j - 1]) + u8(app.board[i][j + 1])
			// bottom = bottom-left + bottom-middle + bottom-right
			bottom := u8(app.board[i + 1][j - 1]) + u8(app.board[i + 1][j]) + u8(app.board[i +
				1][j + 1])

			app.board_neighbors[i][j] = top + middle + bottom
		}
	}

	for i in 1 .. row_size - 1 {
		for j in 1 .. col_size - 1 {
			match app.board_neighbors[i][j] {
				2 {} // Do nothing
				3 { app.board[i][j] = State.alive }
				else { app.board[i][j] = State.dead }
			}
		}
	}
}

fn main() {
	rand.seed([u32(time.now().nanosecond), 0])

	mut app := App{}
	app.new_game()
	app.randomize() or { panic('failed to randomize') }

	raylib.init_window(screen_width, screen_height, window_title)
	defer { raylib.close_window() }

	raylib.set_target_fps(fps)

	for !raylib.window_should_close() {
		if raylib.is_key_pressed(int(raylib.KeyboardKey.key_r)) {
			app.new_game()
			app.randomize() or { panic('failed to randomize') }
		} else if raylib.is_key_pressed(int(raylib.KeyboardKey.key_b)) {
			app.change_bg_color()
		} else if raylib.is_key_pressed(int(raylib.KeyboardKey.key_c)) {
			app.change_cell_color()
		}

		raylib.begin_drawing()
		raylib.clear_background(app.bg_color)

		app.draw()
		app.next_generation()

		raylib.end_drawing()
	}
}
