extends Control

@onready var hearts = $Hearts as TextureRect

var heart_pxls=16
# Called when the node enters the scene tree for the first time.

func _on_player_player_life_changed(player_hearts :float):
	hearts.texture.scale = heart_pxls * player_hearts
	print("Hearts changed to " + str(player_hearts))

