extends CharacterBody2D

var last_direction: String = "Right"

const SPEED = 100.0

signal player_life_changed

var health = 3
var flinch = 0.0;
@export var FLINCH_CONST = 300
var flinch_dir = Vector2.ZERO

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
		
	if flinch>0:
		$AnimatedSprite2D.play("Hurt"+last_direction)
		#if hurting, override move dir.
		velocity = flinch_dir.normalized() * FLINCH_CONST * get_flinch();
		flinch -= delta;
		print("flinching in dir " + str(velocity))
	elif moving:
		$AnimatedSprite2D.play("Walk" + last_direction)
		$AnimatedSprite2D.flip_h = mirror

	else:
		$AnimatedSprite2D.play("Idel" + last_direction)

	move_and_slide()


func hurt(damage):
	health -= damage
	emit_signal("player_life_changed",health)


func cause_flinch(amnt : float , dir : Vector2):
	flinch = amnt
	flinch_dir = dir
	pass

func get_flinch():
	return flinch * flinch

func _on_hurt_box_area_entered(area : Area2D):
	hurt(1)
	var recoilDir = Vector2( (global_position.x - area.global_position.x ) , (position.y-area.global_position.x))
	cause_flinch( 0.6 , recoilDir)

