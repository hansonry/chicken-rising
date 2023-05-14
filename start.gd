extends Node2D

const WIDTH  : int = 320
const HEIGHT : int = 240

const ROOM_TRANSITION_SPEED: float = 20

var camera_destination: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _compute_camera_location(pos: Vector2) -> Vector2:
	var frame : Vector2
	frame.x = floor(pos.x / WIDTH)
	frame.y = floor(pos.y / HEIGHT)
	return Vector2(frame.x * WIDTH, frame.y * HEIGHT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera : Camera2D = $Camera2D
	var player: CharacterBody2D = $Player
	camera_destination = _compute_camera_location(player.transform.origin)
	camera.transform.origin = camera.transform.origin.lerp(camera_destination, delta * ROOM_TRANSITION_SPEED)
	


