extends CharacterBody2D


const SPEED = 100.0

func _physics_process(delta):
	var moving :bool = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("Left", "Right")
	var directionY = Input.get_axis("Up", "Down")
	if directionX:
		moving = true
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directionY:
		moving = true
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if moving:
		$AnimatedSprite2D.play("Walk")
	else:
		$AnimatedSprite2D.play("Idel")

	move_and_slide()
