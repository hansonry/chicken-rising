extends Node

var items := []

@onready var notifier: Notifier = get_node("/root/Node2D/Camera2D/Notifier")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _component_identified(component: ItemComponent, book: ItemBook):
	print("Identifed! " + component.name)
	component.identified = true
	var notification := Notification.new()
	notification.text = "Identified " + component.name
	notification.image = component.texture
	notification.sound = null
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

func add_item(item: Item):
	items.append(item)
	if item is ItemBook:
		_notify_book_got(item)
		_identify_components_using_book(item)
	elif item is ItemComponent:
		_identify_component(item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
