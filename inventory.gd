extends Node

var items := []

var notifier: Notifier = null
@onready var stealth_box_scene : Resource = load ("res://items/stealth_box/cardboard_box.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func game_ready():
	notifier = get_node("/root/Node2D/Camera2D/Notifier")

func _component_identified(component: ItemComponent, book: ItemBook):
	print("Identifed! " + component.name)
	component.identified = true
	var notification := Notification.new()
	notification.text = "Identified " + component.unidentified_name + " as\n " + component.name
	notification.image = component.texture
	notification.sound = component.sound_on_pickup
	notifier.add_notification(notification)
	
func _identify_components_using_book(book: ItemBook):
	for item in items:
		if item is ItemComponent and not item.identified and item.identified_by == book :
			_component_identified(item, book)

func _identify_component(component: ItemComponent):
	if not component.identified:
		for item in items:
			if item is ItemBook and component.identified_by == item:
				_component_identified(component, item)

func _notify_book_got(book: ItemBook):
	var notification := Notification.new()
	notification.text = "Got Book " + book.name
	notification.image = book.texture
	notification.sound = null
	notifier.add_notification(notification)

func _notify_component_got(component: ItemComponent):
	var notification := Notification.new()
	notification.text = "Got " + component.unidentified_name
	notification.image = component.texture
	notification.sound = null
	notifier.add_notification(notification)

func _notify_box_got(component: ItemEquipment):
	var notification := Notification.new()
	notification.text = "Got " + component.name
	notification.image = component.texture
	notification.sound = null
	notifier.add_notification(notification)

func _add_box_to_player():
	get_tree().current_scene.find_child("Player").add_child( stealth_box_scene.instantiate() )



func add_item(item: Item):
	items.append(item)
	if item is ItemBook:
		_notify_book_got(item)
		_identify_components_using_book(item)
	elif item is ItemComponent:
		_notify_component_got(item)
		_identify_component(item)
	elif item is ItemEquipment:
		if item.name == "box":
			_add_box_to_player()
			_notify_box_got(item)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
