extends HSlider

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var prop = get_node("../../Ferry/WatercraftPropulsion_Front") as WatercraftPropulsion
	var indicatorBase = get_node("../../Ferry/NonBuoyantMeshes/PropIndicator_Base_Front") as MeshInstance
	var indicator = get_node("../../Ferry/NonBuoyantMeshes/PropIndicator_Front") as MeshInstance
	var ferry = get_node("../../Ferry") as Spatial
	var windSim = get_node("../CheckBox_Wind") as CheckBox
	var radians = -(self.value * 2 * PI / 360) + PI
	if (windSim.pressed):
		var facing = ferry.global_transform.basis.z
		radians -= atan2(facing.x, facing.z)
	prop.direction = Vector3(sin(radians), 0, cos(radians))
	indicatorBase.rotation = Vector3(PI/2, radians, 0)
	indicator.rotation = Vector3(PI/2, radians, 0)
