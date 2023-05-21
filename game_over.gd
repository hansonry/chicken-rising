extends Node


func restart():
	var err = get_tree().reload_current_scene()
	print( str(err) )
