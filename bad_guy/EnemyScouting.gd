extends RayCast2D

@onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	print(str(parent.get_class()))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
