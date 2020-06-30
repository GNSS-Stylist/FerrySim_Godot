extends HSlider

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var prop = get_node("../../Ferry/WatercraftPropulsion_Front") as WatercraftPropulsion
	var indicator = get_node("../../Ferry/NonBuoyantMeshes/PropIndicator_Front") as MeshInstance
	var propulsion = self.value
	prop.value = propulsion
	var prism = indicator.mesh as PrismMesh
	prism.size = Vector3(1, max(propulsion / 10000, 0.01), 0.5)
