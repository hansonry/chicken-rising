extends RayCast2D
class_name ScoutingVision


@onready var parent = get_parent() as Bad_Guy
@onready var DEBUG := parent.DEBUG as bool

signal scout_alert

var base_angle = 0.0 as float
var fov_offset_angle = 0.0 as float
@export var LAZY_SCAN_SPEED = PI
@export var ALERT_SCAN_SPEED = 4*PI
@onready var scan_speed_rad_per_sec = PI # PLACEHOLDER -- bc some weird process_physics bug, it needs to be set before onready

@export var fov_in_degrees : float = 60;
@onready var fov_max_in_rads = deg_to_rad(fov_in_degrees) # around 60 degress total

# Called when the node enters the scene tree for the first time.
func _ready():
	scan_speed_rad_per_sec = LAZY_SCAN_SPEED
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if DEBUG:
		queue_redraw() # show the scanning
	

func _physics_process(delta):
	if is_colliding():
		var collider : CollisionObject2D = get_collider()
		if collider is Player: 
			scout_alert.emit(get_collision_point())
		if collider is StealthBox:
			pass # 
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

