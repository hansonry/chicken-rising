extends Control

@onready var hp = $Health as ProgressBar

# Called when the node enters the scene tree for the first time.

func _on_player_player_life_changed(player_hearts : int):
	if(hp == null):
		hp = $Health
	hp.value = player_hearts

