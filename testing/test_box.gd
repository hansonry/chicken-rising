extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _unhandled_input(event):
	# https://docs.godotengine.org/en/stable/tutorials/inputs/inputevent.html
	if event is InputEventKey:
		if event.pressed and not event.echo: 
			if event.keycode == KEY_SPACE:
				print ("Hello")
			# your logic here
