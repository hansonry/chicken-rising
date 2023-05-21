extends Node2D

const WIDTH  : int = 320
const HEIGHT : int = 240

const ROOM_TRANSITION_SPEED: float = 20

var camera_destination: Vector2 = Vector2.ZERO
@export var shake_noise : Noise = FastNoiseLite.new()
@export var MAX_SHAKE_INTENSITY : float = 15
@export var SHAKE_SPEED: float = 600
@export var PERCENT_TIMER_SHAKE_STARTS :float = 0.7
var original_camera_position : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	original_camera_position = $Camera2D.position
	Inventory.game_ready()

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
	_add_shake(camera, delta)
	
	

func _get_doomsday_closeness():
	return 1-($Camera2D/TheCountDown/CountDownTimer.time_left / ($Camera2D/TheCountDown/CountDownTimer.wait_time * PERCENT_TIMER_SHAKE_STARTS))
	
var shake_timer = 0.0
# Intensity should be percent value :  0.0 - 1.0
func _add_shake( camera : Camera2D , delta: float ): 
	var intensity = _get_doomsday_closeness()
	if(_should_shake(intensity)):
		print ("int:"+ str(intensity) )
		var offsetx = shake_noise.get_noise_1d( shake_timer );
		var offsety = shake_noise.get_noise_1d( shake_timer + 10);
		var offset = Vector2( offsetx, offsety)
		print ("orig offset = " + str(offset))
		offset = offset * (intensity * intensity) * MAX_SHAKE_INTENSITY # use the squared value of intensity because feels better
		print ( str (offset))
		shake_timer+= delta*SHAKE_SPEED
		camera.offset = offset


func _should_shake(intensity):
	return intensity>PERCENT_TIMER_SHAKE_STARTS
