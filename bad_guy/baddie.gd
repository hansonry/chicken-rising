extends CharacterBody2D

class_name Baddie

const WALK_SPEED = 10.0
const RUN_SPEED = 30.0
var SPEED = WALK_SPEED
#NOTE: Scouting depends on last_direction
@export var DEBUG: bool = false
@onready var sprite = $AnimatedSprite2D as AnimatedSprite2D
@onready var vision_scanner = $VisionRaycast as ScoutingVision

var last_direction = "Right"
#patrol variables
@onready var next_patrol_location : Vector2 = global_position + Vector2.RIGHT # the next location to explore/patrol.
var PATROL_POINT_DIST_SQR_THRESHOLD = 5;
var PATROL_DISTANCE := 100.0 # the distance between each rand patrol point from the PATROL_ORIGIN
#Patrol origin is where they spawn, by default, but obviously can be moved.
@onready var PATROL_ORIGIN := global_position as Vector2 # These bad guys aren't very brave. They tend to stay near one location.

#rnd
var rand := RandomNumberGenerator.new() as RandomNumberGenerator

func _process(delta):
	if DEBUG:
		queue_redraw()

func _physics_process(delta):
	var moving :bool = false
	# get the next place to patrol.
	var command := global_position.direction_to(next_patrol_location) as Vector2
	
	if _am_I_close_enough(): 
		command = Vector2.ZERO
		
	command = command.normalized()
	if command.x:
		moving = true
		velocity.x = command.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if command.y:
		moving = true
		velocity.y = command.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED) 

		
	_calculate_last_direction(velocity)
	_pick_anim(last_direction)
	_pick_scan_angle(last_direction)
	
	move_and_slide()
	
	#DEBUG
	_DEBUG_dir_keypress()

func _am_I_close_enough():
	return global_position.distance_squared_to(next_patrol_location) < 5;


func _pick_anim( direction : String):
	match direction:
		"Up":
			sprite.play("Up")
		"Down":
			sprite.play("Down")
		"Right":
			sprite.play("Right")
			sprite.flip_h = false;
		"Left":
			sprite.play("Right")
			sprite.flip_h = true;

func _pick_scan_angle(direction: String):
	match direction:
		"Up":
			vision_scanner.set_scan_angle(PI)
		"Down":
			vision_scanner.set_scan_angle(0)
		"Right":
			vision_scanner.set_scan_angle(1.5*PI)
		"Left":
			vision_scanner.set_scan_angle(PI/2)

func _DEBUG_dir_keypress():
	if Input.is_key_pressed(KEY_J):
		next_patrol_location = global_position + (Vector2.LEFT * 30)
	if Input.is_key_pressed(KEY_I):
		next_patrol_location = global_position + (Vector2.UP * 30)
	if Input.is_key_pressed(KEY_K):
		next_patrol_location = global_position + (Vector2.DOWN * 30)
	if Input.is_key_pressed(KEY_L):
		next_patrol_location = global_position + (Vector2.RIGHT * 30)
		
		
func _calculate_last_direction(dir: Vector2):
	var alignment = dir.dot(Vector2.UP)
	var maxAlignment = alignment
	last_direction="Up"
	
	alignment = dir.dot(Vector2.DOWN)
	if alignment>maxAlignment:
		maxAlignment = alignment
		last_direction="Down"
		
	alignment = dir.dot(Vector2.LEFT)
	if alignment>maxAlignment:
		maxAlignment = alignment
		last_direction="Left"

	alignment = dir.dot(Vector2.RIGHT)
	if alignment>maxAlignment:
		#nothing left to compare to
		last_direction="Right"
	pass


func _on_scouting_timer_timeout():
	# Get a random point within PATROL_DISTANCE from the PATROL_ORIGIN.
	SPEED = WALK_SPEED
	next_patrol_location = PATROL_ORIGIN + ( Vector2.from_angle(rand.randf_range(-PI,PI)) * PATROL_DISTANCE * rand.randf());
	vision_scanner.scan_lazy()
	pass


func _on_vision_raycast_scout_alert(player_loc:Vector2):
	#If the enemy sees the player, chase the player!!!
	SPEED=RUN_SPEED
	next_patrol_location = player_loc
	$PatrolTimer.start() # reset the timer. we don't want our bad guy to wander off randomly while chasing us!d
	vision_scanner.scan_alert()
	pass

func _draw():
	if DEBUG:
		draw_line(Vector2.ZERO , Vector2.from_angle($VisionRaycast.base_angle) * 30 , Color.BLUE )
