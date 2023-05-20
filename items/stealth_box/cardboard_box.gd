extends Area2D
class_name StealthBox

var player : Player

func _unhandled_input(event):
	if event.is_action_type():
		
		pass
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.stop()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _enter_tree():
	player = get_parent();
