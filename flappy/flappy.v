module main

// import rand
// import time
import raylib

const window_title = $if prod { 'flappy' } $else { 'flappy (debug)' }
const screen_width = 640
const screen_height = 360
const fps = 60
const jump = -4.0
// 壁の追加間隔
const interval = 120
// 壁の初期x座標
const wall_start_x = 640
// 穴のy座標の最大値
const hole_y_max = 150
// GOPHERの幅
const gopher_width = 60
// GOPHERの高さ
const gopher_height = 75
// 穴のサイズ（高さ）
const hole_height = 170
// 壁の高さ
const wall_height = 360
// 壁の幅
const wall_width = 20

const assets_path = 'assets'
const suffix = 'png'

enum Scene as u8 {
	game_title
	game_play
	game_over
}

struct Gopher {
mut:
	x      f32
	y      f32
	width  int
	height int
}

struct Wall {
mut:
	wall_x int
	hole_y int
}

// struct Walls {
// mut:
// 	items    []Wall
// }

struct App {
mut:
	gopher       Gopher
	velocity     f32
	gravity      f32
	frames       int
	old_score    int
	new_score    int
	score_string string
	walls        []Wall
	scene        Scene
	textures     map[string]raylib.Texture2D
}

enum Texture as u8 {
	gopher
	sky
	wall
}

fn (mut app App) new_game() {
	app.gopher = Gopher{
		x:      200.0
		y:      150.0
		width:  60
		height: 75
	}
	app.gravity = 0.1
	app.score_string = 'Score: 0'
	app.scene = .game_title
	// game.walls = make([dynamic]Wall)
	// app.textures = map[string]raylib.Texture2D{}
	app.load_texture()
}

fn (mut app App) load_texture() {
	file_names := ['gopher', 'sky', 'wall']

	for file_name in file_names {
		path := '${assets_path}/${file_name}.${suffix}'
		println(path)

		asset := raylib.load_image(path)

		// BUG??
		app.textures[file_name] = raylib.load_texture_from_image(asset)

		// raylib.unload_image(asset)
	}
}

fn main() {
	mut app := App{}
	app.new_game()
	println('Hello World!')
}
