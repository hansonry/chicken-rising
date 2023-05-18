extends Bad_Guy

@export var path : PathFollow2D

@onready var vision = $VisionRaycast as ScoutingVision
# Called when the node enters the scene tree for the first time.



func _ready():
	path.set_progress(0)
	# we want patroling foxes slightly faster

	
	PATROL_POINT_DIST_SQR_THRESHOLD = 30
	# we want patroling foxes to be slightly more alert
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!alert):
		next_patrol_location = path.global_position
		if _am_I_close_enough(): # progress once you've reached your point to avoid "catch up" pathing
			path.set_progress( path.progress + (SPEED * 1.5))
	else:
		#Chase down the player...The scanner should take care of this
		pass 
	pass

func _on_vision_raycast_scout_alert(player_loc:Vector2):
	next_patrol_location = player_loc
	_set_alert()
	$AlertnessTimer.start() # get bored after a bit
	pass

# Give up and stop chasing the player after a little while
func _on_alertness_timer_timeout():
	_set_lazy()
	pass # Replace with function body.

