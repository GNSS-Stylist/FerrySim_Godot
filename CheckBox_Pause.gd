extends CheckBox

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.pressed:
		if not get_tree().paused:
			get_tree().set_pause(true)
	else:
		if get_tree().paused:
			get_tree().set_pause(false)
