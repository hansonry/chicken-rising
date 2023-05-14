extends CharacterBody2D

var last_direction: String = "Right"

const SPEED = 100.0

signal player_life_changed

var health = 3

func _ready():
	emit_signal("player_life_changed", health)

func _physics_process(delta):
	var moving :bool = false
	var mirror :bool = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("Left", "Right")
	var directionY = Input.get_axis("Up", "Down")
	if directionX:
		moving = true
		velocity.x = directionX * SPEED
		last_direction = "Right"
		if directionX < 0:
			mirror = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directionY:
		moving = true
		velocity.y = directionY * SPEED
		if directionY > 0:
			last_direction = "Down"
		else:
			last_direction = "Up"
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED) 
	
	if moving:
		$AnimatedSprite2D.play("Walk" + last_direction)
		$AnimatedSprite2D.flip_h = mirror
	else:
		$AnimatedSprite2D.play("Idel" + last_direction)

	move_and_slide()


func hurt(damage):
	emit_signal("player_life_changed",health)
