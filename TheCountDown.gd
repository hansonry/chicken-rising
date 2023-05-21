extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var minutes = floor( round($CountDownTimer.time_left) / 60 )
	var seconds =  (round( $CountDownTimer.time_left ) as int) % 60 
	var time = "Doomsday Timer! -- "+"%02d:%02d" % [minutes, seconds]
	$CountDownLabel.text = time
	pass
