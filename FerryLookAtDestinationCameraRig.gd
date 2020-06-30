extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var filteredLookAt = Vector3(0,0,0) as Vector3
var filteringMultiplier = 0.7

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
# Should interpolate using quaternions or something.
# This coordinate "interpolation" by 1st order filter doesn't work too well
# (but well enough for now and is better than sudden jump anyway)
	var ferry = get_node("../Ferry")
	var ferryTranslation = ferry.global_transform.origin

	var filter_Pow = pow(filteringMultiplier, delta)
	filteredLookAt = filter_Pow * filteredLookAt + (1 - filter_Pow) * get_node("../Target").transform.origin
	self.look_at(filteredLookAt + Vector3.UP * 0, Vector3.UP)
#	get_node("LookAtDestinationCamera").look_at(filteredLookAt, Vector3.UP)

	var newTranslation = ferryTranslation - ferry.global_transform.basis.z * 6
	newTranslation += Vector3.UP * 4
	newTranslation -= ferryTranslation.y * Vector3.UP
	self.transform.origin = newTranslation
