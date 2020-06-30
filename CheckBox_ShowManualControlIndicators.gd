extends CheckBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var propIndicator_Front = get_node("../../Ferry/NonBuoyantMeshes/PropIndicator_Front")
	var propIndicator_Base_Front = get_node("../../Ferry/NonBuoyantMeshes/PropIndicator_Base_Front")
	propIndicator_Front.visible = self.pressed
	propIndicator_Base_Front.visible = self.pressed

	var propIndicator_Rear = get_node("../../Ferry/NonBuoyantMeshes/PropIndicator_Rear")
	var propIndicator_Base_Rear = get_node("../../Ferry/NonBuoyantMeshes/PropIndicator_Base_Rear")
	propIndicator_Rear.visible = self.pressed
	propIndicator_Base_Rear.visible = self.pressed
