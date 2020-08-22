extends ImmediateGeometry

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var antenna1 = get_node("../Ferry/AntennaRig1")
	var antenna2 = get_node("../Ferry/AntennaRig2")
	var antenna3 = get_node("../Ferry/AntennaRig3")
	var debugIndicator = get_node("../DebugIndicator")

	clear()
	if (debugIndicator.visible):
		# Draw lines from debug indicator center to antenna centers
		# to make it easier to see the angles between these and
		# the "planar orientation lines"
		
		begin(Mesh.PRIMITIVE_LINES)
		add_vertex(debugIndicator.global_transform.origin)
		add_vertex(debugIndicator.global_transform.origin + (antenna1.global_transform.origin - debugIndicator.global_transform.origin).normalized() * 10)
		end()
		begin(Mesh.PRIMITIVE_LINES)
		add_vertex(debugIndicator.global_transform.origin)
		add_vertex(debugIndicator.global_transform.origin + (antenna2.global_transform.origin - debugIndicator.global_transform.origin).normalized() * 10)
		end()
		begin(Mesh.PRIMITIVE_LINES)
		add_vertex(debugIndicator.global_transform.origin)
		add_vertex(debugIndicator.global_transform.origin + (antenna3.global_transform.origin - debugIndicator.global_transform.origin).normalized() * 10)
		end()
