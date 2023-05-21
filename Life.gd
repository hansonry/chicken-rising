extends Control

@onready var hp = $Health as ProgressBar

func _on_player_player_life_changed(player_hearts : int):
	if(hp == null):
		hp = $Health
	hp.value = player_hearts
	if( _is_dead(player_hearts) ):
		$GameOver/AnimationPlayer.play("GameOver!")
		$RespawnTimer.start(3)
		
		
func _on_respawn_timer_timeout():
	Game_Over.restart()
		
		
func _is_dead(player_hearts:int):
	return player_hearts == 0


func _on_incubator_win_game(win):
	$YouWin/AnimationPlayer.play("Win")
	pass # Replace with function body.
