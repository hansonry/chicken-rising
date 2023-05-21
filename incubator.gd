extends Area2D

var _started_build : bool = false
signal win_game(win : bool)

@onready var _rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Incubator.visible = false
	$CPUParticles2D.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $AnimationPlayer.is_playing():
		$Incubator.position.x = _rng.randf_range(-5, 5);
	if not _started_build and Inventory.can_build_incubator():
		$CPUParticles2D.visible = true

func _start_build_process():
	_started_build = true
	$CPUParticles2D.visible = false
	$AnimationPlayer.play("Build", -1, 1 / $BuildingSound.stream.get_length() )
	$Incubator.visible = true	
	$BuildingSound.play()



func _attempt_to_build():
	if Inventory.can_build_incubator() and not _started_build:
		_start_build_process()

func _on_body_entered(body):
	_attempt_to_build()


func _on_building_sound_finished():
	$Incubator.visible = true
	$Incubator.position.x = 0


func _on_animation_player_animation_finished(anim_name):
	print("win")
	win_game.emit(true)
