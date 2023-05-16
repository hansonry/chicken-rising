extends Area2D

var picked_up : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _play_pickup_sound():
	var pickup_sound = get_node("SoundPickup")
	if pickup_sound != null:
		pickup_sound.playing = true

func _pick_up():
	if not picked_up:
		_play_pickup_sound()
		hide()
		picked_up = true
	
	

func _on_body_entered(body):
	_pick_up()
	pass # Replace with function body.
