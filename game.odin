package game

import "core:fmt"
import "core:math/rand"
import k2 "karl2d"

anim_timer: int = 0
anim_timer_max: int = 20
player_pos: k2.Vec2 = {}
error: bool = false

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
	font = k2.load_font_from_bytes(#load("square.ttf"))
	font_vec2 = k2.measure_text("a", font_size, font)
	// fmt.println("font vec2:", font_vec2)
	camera = k2.Camera {
		target = player_pos,
		offset = k2.get_screen_size() * 0.5,
		zoom   = 1,
	}
	// fmt.println(fmt.tprint(k2.Keyboard_Key.Space))
}

lerp :: proc(a, b: k2.Vec2, t: f32) -> k2.Vec2 {
	return a + (b - a) * t
}

handle_direction :: proc() {
	if k2.key_went_down(.Right) {
		dir = .Right
	}
	if k2.key_went_down(.Down) {
		dir = .Down
	}
	if k2.key_went_down(.Left) {
		dir = .Left
	}
	if k2.key_went_down(.Up) {
		dir = .Up
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
	// fmt.println("move_player:", key)

	d, r, u, l := ns[1], ns[3], ns[5], ns[7]
	#partial switch dir {
	case .Down:
		if key == d.key {
			error = false
			player_pos = d.pos
			// fmt.println("Player:", player_pos)
		} else {
			error = true
		}
	case .Right:
		if key == r.key {
			error = false
			player_pos = r.pos
			// fmt.println("Player:", player_pos)
		} else {
			error = true
		}
	case .Up:
		if key == u.key {
			error = false
			player_pos = u.pos
			// fmt.println("Player:", player_pos)
		} else {
			error = true
		}
	case .Left:
		if key == l.key {
			error = false
			player_pos = l.pos
			// fmt.println("Player:", player_pos)
		} else {
			error = true
		}
	}
}

fill_neighbors :: proc() {
	for level in 1 ..= 29 {
		for i in 0 ..< (8 * level) {
			x, y: f32
			side := i / (2 * level)
			offset := i % (2 * level)

			switch side {
			case 0:
				x, y = -f32(level) * font_size + f32(offset) * font_size, f32(level) * font_size
			case 1:
				x, y = f32(level) * font_size, f32(level) * font_size - f32(offset) * font_size
			case 2:
				x, y = f32(level) * font_size - f32(offset) * font_size, -f32(level) * font_size
			case 3:
				x, y = -f32(level) * font_size, -f32(level) * font_size + f32(offset) * font_size
			}
			px, py := player_pos.x + f32(x), player_pos.y + f32(y)
			append(
				&ns,
				grid{k2.Vec2{px, py}, rand_keys[abs(int(px * 17 + py * 19)) % len(rand_keys)]},
			)
		}
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
}

step :: proc() -> bool {
	if !k2.update() {
		return false
	}

	fill_neighbors()
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
			k2.Color{183, 83, 183, 83},
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
