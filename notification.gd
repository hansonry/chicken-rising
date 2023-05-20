extends RefCounted
class_name Notification

var text : String = "";
var image : Texture2D = null
var sound : AudioStream = null

func _init(the_text: String = "", 
		the_image: Texture2D = null, 
		the_sound: AudioStream = null):
	text = the_text
	image = the_image
	sound  = the_sound
