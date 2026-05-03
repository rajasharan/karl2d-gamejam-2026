package game

import "core:fmt"
import "core:math"
import "core:math/noise"
import "core:math/rand"
import k2 "karl2d"

anim_timer: int = 0
anim_timer_max: int = 20
player_pos: k2.Vec2 = {}
error: bool = false

screen_size: k2.Vec2
font: k2.Font
font_size: f32 = 14 * 4
font_vec2: k2.Vec2
camera: k2.Camera
key := k2.Keyboard_Key.None

grid :: struct {
	pos: k2.Vec2,
	key: k2.Keyboard_Key,
}

ns: [dynamic]grid

rand_keys := [?]k2.Keyboard_Key {
	.A,
	.B,
	.C,
	.E,
	.F,
	.G,
	.H,
	.I,
	.J,
	.K,
	.L,
	.M,
	.N,
	.O,
	.P,
	.Q,
	.R,
	.S,
	.T,
	.U,
	.V,
	.W,
	.X,
	.Y,
	.Space,
	.Z,
}

dir: k2.Keyboard_Key = .Right

main :: proc() {
	init()
	for step() {}
	shutdown()
}

init :: proc() {
	k2.init(900, 720, "karl2d gamejam 2026", options = {window_mode = .Windowed_Resizable})
	screen_size = k2.get_screen_size()
	font = k2.load_font_from_bytes(#load("square.ttf"))
	font_vec2 = k2.measure_text("a", font_size, font)
	// fmt.println("font vec2:", font_vec2)
	camera = k2.Camera {
		target = player_pos,
		offset = k2.get_screen_size() * 0.5,
		zoom   = 1,
	}
	// fmt.println(fmt.tprint(k2.Keyboard_Key.Space))
	// x, y: f32 = -54.0, 56.0
	// fmt.println("floor:", math.floor(x / y))
}

lerp :: proc(a, b: k2.Vec2, t: f32) -> k2.Vec2 {
	return a + (b - a) * t
}

handle_direction :: proc() {
	if k2.key_went_down(.Right) {
		dir = .Right
		// fmt.println("tiles#", len(ns))
	}
	if k2.key_went_down(.Down) {
		dir = .Down
		// fmt.println("tiles#", len(ns))
	}
	if k2.key_went_down(.Left) {
		dir = .Left
		// fmt.println("tiles#", len(ns))
	}
	if k2.key_went_down(.Up) {
		dir = .Up
		// fmt.println("tiles#", len(ns))
	}
}

handle_characters :: proc() {
	if k2.key_went_up(.A) {
		key = .A
		return
	}
	if k2.key_went_up(.B) {
		key = .B
		return
	}
	if k2.key_went_up(.C) {
		key = .C
		return
	}
	if k2.key_went_up(.D) {
		key = .D
		return
	}
	if k2.key_went_up(.E) {
		key = .E
		return
	}
	if k2.key_went_up(.F) {
		key = .F
		return
	}
	if k2.key_went_up(.G) {
		key = .G
		return
	}
	if k2.key_went_up(.H) {
		key = .H
		return
	}
	if k2.key_went_up(.I) {
		key = .I
		return
	}
	if k2.key_went_up(.J) {
		key = .J
		return
	}
	if k2.key_went_up(.K) {
		key = .K
		return
	}
	if k2.key_went_up(.L) {
		key = .L
		return
	}
	if k2.key_went_up(.M) {
		key = .M
		return
	}
	if k2.key_went_up(.N) {
		key = .N
		return
	}
	if k2.key_went_up(.O) {
		key = .O
		return
	}
	if k2.key_went_up(.P) {
		key = .P
		return
	}
	if k2.key_went_up(.Q) {
		key = .Q
		return
	}
	if k2.key_went_up(.R) {
		key = .R
		return
	}
	if k2.key_went_up(.S) {
		key = .S
		return
	}
	if k2.key_went_up(.T) {
		key = .T
		return
	}
	if k2.key_went_up(.U) {
		key = .U
		return
	}
	if k2.key_went_up(.V) {
		key = .V
		return
	}
	if k2.key_went_up(.W) {
		key = .W
		return
	}
	if k2.key_went_up(.X) {
		key = .X
		return
	}
	if k2.key_went_up(.Y) {
		key = .Y
		return
	}
	if k2.key_went_up(.Z) {
		key = .Z
		return
	}
	if k2.key_went_up(.Space) {
		key = .Space
		return
	}
	key = .None
}

move_player :: proc() {
	if key == .None {
		return
	}

	r := k2.Vec2{player_pos.x + font_size, player_pos.y}
	u := k2.Vec2{player_pos.x, player_pos.y - font_size}
	l := k2.Vec2{player_pos.x - font_size, player_pos.y}
	d := k2.Vec2{player_pos.x, player_pos.y + font_size}

	#partial switch dir {
	case .Right:
		char := get_char_at(r.x, r.y)
		if key == char {
			error = false
			player_pos = r
		} else {
			error = true
		}
	case .Up:
		char := get_char_at(u.x, u.y)
		if key == char {
			error = false
			player_pos = u
		} else {
			error = true
		}
	case .Left:
		char := get_char_at(l.x, l.y)
		if key == char {
			error = false
			player_pos = l
		} else {
			error = true
		}
	case .Down:
		char := get_char_at(d.x, d.y)
		if key == char {
			error = false
			player_pos = d
		} else {
			error = true
		}
	}
}

get_char_at :: proc(x, y: f32) -> k2.Keyboard_Key {
	n := noise.noise_2d(123456, {f64(x), f64(y)})
	i := abs(int(n * 123456)) % len(rand_keys)
	return rand_keys[i]
}

fill_screen :: proc() {
	sx, sy: f32 = 0, 0
	wh := k2.screen_to_world(screen_size, camera)
	w, h := wh.x, wh.y
	xy := k2.screen_to_world({sx, sy}, camera)
	x, y := xy.x, xy.y
	mx, my := math.floor(x / font_size), math.floor(y / font_size)
	x = mx * font_size
	for x <= w {
		y = my * font_size
		for y <= h {
			append(&ns, grid{k2.Vec2{x, y}, get_char_at(x, y)})
			y += font_size
		}
		x += font_size
	}
}

draw_neighbors :: proc() {
	for n in ns {
		k2.draw_rect({n.pos.x, n.pos.y, font_size, font_size}, k2.DARK_GRAY)
		if n.key == k2.Keyboard_Key.Space {
			k2.draw_text(" ", n.pos, font_size, k2.Color{183, 183, 183, 183}, font)
		} else {
			k2.draw_text(fmt.tprint(n.key), n.pos, font_size, k2.Color{183, 183, 183, 183}, font)
		}
	}
	// k2.draw_rect_outline({-952 + 56, -56 * 13, font_size, font_size}, 2.0, k2.DARK_RED)
}

step :: proc() -> bool {
	if !k2.update() {
		return false
	}

	fill_screen()
	handle_direction()
	handle_characters()
	move_player()

	k2.set_camera(nil)
	k2.clear(k2.DARK_GRAY)

	k2.set_camera(camera)
	draw_neighbors()

	camera.target = lerp(camera.target, player_pos, 1 * k2.get_frame_time())
	k2.set_camera(camera)

	if error {
		dx := rand.float32_range(-2.5, 2.5)
		dy := rand.float32_range(-2.5, 2.5)
		k2.draw_rect({player_pos.x + dx, player_pos.y + dy, font_size, font_size}, k2.LIGHT_RED)
		k2.draw_text("*", player_pos + k2.Vec2{dx, dy}, font_size, k2.DARK_RED, font)
		anim_timer += 1
		// fmt.println("Anim:", anim_timer)
		if anim_timer >= anim_timer_max {
			anim_timer = 0
			error = false
		}
	} else {
		anim_timer = 0
		k2.draw_rect(
			{player_pos.x, player_pos.y, font_size, font_size},
			k2.Color{183, 83, 183, 245},
		)
		#partial switch dir {
		case .Left:
			k2.draw_text(
				"<",
				{player_pos.x, player_pos.y + font_size / 3},
				font_size / 3,
				k2.LIGHT_RED,
				font,
			)
		case .Down:
			k2.draw_text(
				"v",
				{player_pos.x + font_size / 3, player_pos.y + font_size * 2 / 3},
				font_size / 3,
				k2.LIGHT_RED,
				font,
			)
		case .Right:
			k2.draw_text(
				">",
				{player_pos.x + font_size * 2 / 3, player_pos.y + font_size / 3},
				font_size / 3,
				k2.LIGHT_RED,
				font,
			)
		case .Up:
			k2.draw_text("^", {player_pos.x, player_pos.y}, font_size, k2.LIGHT_RED, font)
		}
	}

	k2.present()
	clear(&ns)
	return true
}

shutdown :: proc() {
	k2.shutdown()
}
