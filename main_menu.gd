extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _start_game():
	get_tree().change_scene_to_file("res://start.tscn")

func _unhandled_input(ev):
	if ev is InputEvent and not ev is InputEventMouseMotion:
		_start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
