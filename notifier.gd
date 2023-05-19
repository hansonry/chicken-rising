extends Node2D
class_name Notifier

var _queue := []
var _current_notification: Notification = null
@onready var _mover: Node2D = $Mover

# Called when the node enters the scene tree for the first time.
func _ready():
	_mover.visible = false
	pass # Replace with function body.

func _start_notification(notification: Notification):
	_current_notification = notification
	$Mover/Control/BoxContainer/Text.text = notification.text
	$AudioStreamPlayer.stream = notification.sound
	$Mover/Control/BoxContainer/TextureRect.texture = notification.image

	_mover.visible = true
	$AnimationPlayer.play("ShowNotification")

func _check_for_next_notification():
	if _current_notification == null:
		var next: Notification = _queue.pop_front()
		if next != null:
			_start_notification(next)

func play_sound():
	if _current_notification != null and _current_notification.sound != null:
		$AudioStreamPlayer.play()

func add_notification(notification: Notification):
	_queue.push_back(notification)
	_check_for_next_notification()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	print("Animation Done")
	_current_notification = null
	_mover.visible = false
	_check_for_next_notification()

func _on_box_container_resized():
	_mover.position.x = 300 - $Mover/Control/BoxContainer.get_size().x
