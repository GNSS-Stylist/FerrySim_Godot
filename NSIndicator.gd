extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ferry = get_node("../Ferry")
	var newTranslation = ferry.global_transform.origin
	newTranslation[1] = transform.origin[1]
	transform.origin = newTranslation
