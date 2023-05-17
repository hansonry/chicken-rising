extends RayCast2D
class_name ScoutingVision


@onready var parent = get_parent() as Baddie
@onready var DEBUG := parent.DEBUG as bool

@onready var alertLabel := get_parent().find_child("AlertLabel") as Label
signal scout_alert

var base_angle = 0.0 as float
var fov_offset_angle = 0.0 as float
const LAZY_SCAN_SPEED = PI
const ALERT_SCAN_SPEED = 4*PI
var scan_speed_rad_per_sec = LAZY_SCAN_SPEED # 90 degrees

@export var fov_in_degrees : float = 60;
@onready var fov_max_in_rads = deg_to_rad(fov_in_degrees) # around 60 degress total

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if DEBUG:
		queue_redraw() # show the scanning
	

func _physics_process(delta):
	if is_colliding():
		scout_alert.emit(get_collision_point())
		if DEBUG:
			alertLabel.visible = true
	elif DEBUG:
		alertLabel.visible = false
	_move_player_scanner(delta)


func _move_player_scanner(delta):
	#rotate raycast to scan direction
	rotation = base_angle + fov_offset_angle - (fov_max_in_rads/2)
	#Incr offset of scan
	fov_offset_angle += scan_speed_rad_per_sec * delta
	fov_offset_angle = fmod (fov_offset_angle , fov_max_in_rads) # constrain FOV

func set_scan_angle(scan_angle: float):
	base_angle = scan_angle
	
	
func scan_lazy():
	scan_speed_rad_per_sec = LAZY_SCAN_SPEED
	
	
func scan_alert():
	scan_speed_rad_per_sec = ALERT_SCAN_SPEED

func _draw():
	if DEBUG:
		draw_line(Vector2.ZERO , target_position , Color.RED)

