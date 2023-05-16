extends CharacterBody2D


const WALK_SPEED = 10.0
const RUN_SPEED = 30.0
var last_direction : String
#patrol variables
var _patrol_location : Vector2 # the next location to explore/patrol.
var PATROL_DISTANCE := 10.0 # the distance between each rand patrol point from the PATROL_ORIGIN
#Patrol origin is where they spawn, by default, but obviously can be moved.
@onready var PATROL_ORIGIN := global_position as Vector2 # These bad guys aren't very brave. They tend to stay near one location.
#rnd
var rand := RandomNumberGenerator.new() as RandomNumberGenerator


func _physics_process(delta):
	var SPEED = WALK_SPEED
	var moving :bool = false
	var mirror :bool = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var command : Vector2
	command.x = Input.get_axis("Left", "Right")
	command.y = Input.get_axis("Up", "Down")
	
	
	command = command.normalized()
	if command.x:
		moving = true
		velocity.x = command.x * SPEED
		last_direction = "Right"
		if command.x < 0:
			mirror = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if command.y:
		moving = true
		velocity.y = command.y * SPEED
		if command.y > 0:
			last_direction = "Down"
		else:
			last_direction = "Up"
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED) 
		
	if moving:
		$Sprite2D.flip_h = mirror

	else:
		$AnimatedSprite2D.play("Idel" + last_direction)

	move_and_slide()





func _on_scouting_timer_timeout():
	
	pass
	
