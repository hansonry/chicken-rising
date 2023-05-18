class_name Item
extends Resource

@export var name : String = ""
@export var texture: Texture2D = null
@export var sound_on_pickup: AudioStream = null

func _init(the_name : String = ""):
	name = the_name

