extends Spatial

export var poleColor:Color = Color(1,1,1)
var material:SpatialMaterial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Pole.mesh = $Pole.mesh.duplicate()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	material = SpatialMaterial.new()
	material.albedo_color = poleColor
	$Pole.mesh.surface_set_material(0, material)
