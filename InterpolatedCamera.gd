extends InterpolatedCamera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var targetObject = get_node("../Ferry")
	var targetLookAtPos = targetObject.translation
	var verticalOffset = Vector3(0,-10, 0)
	targetLookAtPos += verticalOffset
#	var east = Vector3(1,0,0)
#	var up = Vector3(0,1,0).rotated(east, 0.1)
	var up = Vector3(0,1,0)
	look_at(targetLookAtPos, up)
#	pass
