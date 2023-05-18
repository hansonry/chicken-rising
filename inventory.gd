extends Node

var items := []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _component_identified(component: ItemComponent, book: ItemBook):
	print("Identifed! " + component.name)
	component.identified = true
	
func _identify_components_using_book(book: ItemBook):
	for item in items:
		if item is ItemComponent and not item.identified and item.identified_by == book :
			_component_identified(item, book)

func _identify_component(component: ItemComponent):
	if not component.identified:
		for item in items:
			if item is ItemBook and component.identified_by == item:
				_component_identified(component, item)

func add_item(item: Item):
	items.append(item)
	if item is ItemBook:
		_identify_components_using_book(item)
	elif item is ItemComponent:
		_identify_component(item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
