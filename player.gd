extends CharacterBody2D

var last_direction: String = "Right"

const SPEED = 100.0

func _physics_process(delta):
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
		$AnimatedSprite2D.play("Walk" + last_direction)
		$AnimatedSprite2D.flip_h = mirror
	else:
		$AnimatedSprite2D.play("Idel" + last_direction)

	move_and_slide()
