@tool
extends Area2D

var picked_up : bool = false

func _setup_item():
		if item != null:
			$SoundPickup.stream = item.sound_on_pickup
			$Sprite2D.texture = item.texture
		else:
			$SoundPickup.stream = null
			$Sprite2D.texture = null
	

@export var item : Item = null :
	set(new_item):
		item = new_item
		_setup_item()
		

# Called when the node enters the scene tree for the first time.
func _ready():
	_setup_item()
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
		Inventory.add_item(ItemComponent.new("Circuit board"))
		picked_up = true
	
	

func _on_body_entered(body):
	_pick_up()
	pass # Replace with function body.
