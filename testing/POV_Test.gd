extends RayCast2D

var wall_hit : bool = false
var plyr_hit : bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
var timr :Timer
var excl : Label #show when see player
var clueless : Label #show when see something else
# Called when the node enters the scene tree for the first time.
func _ready():
	timr = Timer.new();
	timr.timeout.connect(time_thing.bind())
	timr.wait_time = 3.0
	add_child(timr)
	timr.start(3.0)
	clueless = get_parent().find_child("Clueless")
	excl = get_parent().find_child("AlertInd")

func _process(delta):
	var collider = get_collider()
	
	if collider is Player and not plyr_hit:
		excl.visible = true
		clueless.visible = false
	else:
		excl.visible = false
		clueless.visible = true
	


func time_thing():
	print("Timeout done")
	force_raycast_update()
