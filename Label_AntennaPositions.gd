extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var antenna1 = get_node("../../Ferry/AntennaRig1/Antenna")	# How to do this:	as AntennaRig
	var antenna2 = get_node("../../Ferry/AntennaRig2/Antenna")	# How to do this:	as AntennaRig
	var antenna3 = get_node("../../Ferry/AntennaRig3/Antenna")	# How to do this:	as AntennaRig
	var antenna1Pos = antenna1.global_transform.origin
	var antenna2Pos = antenna2.global_transform.origin
	var antenna3Pos = antenna3.global_transform.origin
	
	self.text = """Antenna A: %.3f, %.3f, %.3f
	Antenna B: %.3f, %.3f, %.3f
	Antenna C: %.3f, %.3f, %.3f""" % [antenna1Pos.x, antenna1Pos.y, antenna1Pos.z, antenna2Pos.x, antenna2Pos.y, antenna2Pos.z, antenna3Pos.x, antenna3Pos.y, antenna3Pos.z]
