extends Area2D
class_name StealthBox

var player : Player
var is_in_use = false



# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.stop()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _enter_tree():
	player = get_parent();
	
	
func _input(event):
	if event.is_action_pressed("Box"):
		if not is_in_use:
			is_in_use = true
			$AnimationPlayer.play("Flip_Open_Side")
			print("box on!")
		else:
			is_in_use = false
			$AnimationPlayer.play_backwards("Flip_Open_Side")
			print("box off!")
