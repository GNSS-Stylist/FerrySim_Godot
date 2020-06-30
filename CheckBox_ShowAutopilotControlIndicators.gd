extends CheckBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var propIndicator_Front_External = get_node("../../Ferry/NonBuoyantMeshes/PropIndicator_Front_External")
	propIndicator_Front_External.visible = self.pressed

	var propIndicator_Rear_External = get_node("../../Ferry/NonBuoyantMeshes/PropIndicator_Rear_External")
	propIndicator_Rear_External.visible = self.pressed
