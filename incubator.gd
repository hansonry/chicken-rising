extends Area2D

var _started_build : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Incubator.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _start_build_process():
	_started_build = true
	$BuildingSound.play()

func _attempt_to_build():
	if Inventory.can_build_incubator() and not _started_build:
		_start_build_process()

func _on_body_entered(body):
	_attempt_to_build()


func _on_building_sound_finished():
	$Incubator.visible = true
