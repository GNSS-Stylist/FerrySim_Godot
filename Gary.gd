extends KinematicBody

var camera_angle_y = 0
var camera_angle_x = 0
var mouse_sensitivity = 0.3
var camera_change = Vector2()

var velocity = Vector3()
var direction = Vector3()
var velocityMultiplier = 1.0

#fly variables
const FLY_SPEED = 20
const FLY_ACCEL = 4

var mouse_captured = false

func _ready():
	var manipulator = get_node("ManipulatorCollisionShape")
	var capsule = get_node("Capsule")
	var manipulatorMeshes = get_node("ManipulatorMeshes")

	manipulator.disabled = true
	manipulator.visible = true
	capsule.disabled = true
	manipulatorMeshes.visible = false

	var rmbManipulator = get_node("RMBManipulatorCollisionShape")
	var rmbManipulatorMeshes = get_node("RMBManipulatorMeshes")
	rmbManipulator.disabled = true
	rmbManipulator.visible = true
	rmbManipulatorMeshes.visible = false

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):

	camSwitch()
	
	if mouse_captured:
		aim()
		fly(delta)
		var manipulator = get_node("ManipulatorCollisionShape")
		var capsule = get_node("Capsule")
		var manipulatorMeshes = get_node("ManipulatorMeshes")

		if Input.is_action_just_pressed("mouse_left"):
			manipulator.disabled = false
			manipulator.visible = false
			capsule.disabled = false
			manipulatorMeshes.visible = true
		if Input.is_action_just_released("mouse_left"):
			manipulator.disabled = true
			manipulator.visible = true
			capsule.disabled = true
			manipulatorMeshes.visible = false

		var rmbManipulator = get_node("RMBManipulatorCollisionShape")
		var rmbManipulatorMeshes = get_node("RMBManipulatorMeshes")
		if Input.is_action_just_pressed("mouse_right"):
			rmbManipulator.disabled = false
			rmbManipulator.visible = false
			rmbManipulatorMeshes.visible = true
		if Input.is_action_just_released("mouse_right"):
			rmbManipulator.disabled = true
			rmbManipulator.visible = true
			rmbManipulatorMeshes.visible = false
	
	if Input.is_action_just_pressed('toggle_mouse'):
		if mouse_captured:
			mouse_captured = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			mouse_captured = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		camera_change = event.relative

func fly(delta):
	# reset the direction of the player
	direction = Vector3()
	
	# get the rotation of the camera
	var aim = $Head/FirstPersonCamera.get_global_transform().basis
	
	# check input and change direction
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
	if Input.is_action_pressed("move_right"):
		direction += aim.x
	if Input.is_action_pressed("move_up"):
		direction += aim.y
	if Input.is_action_pressed("move_down"):
		direction -= aim.y
	if Input.is_action_pressed("movement_speed_down") and velocityMultiplier > 0.1:
		velocityMultiplier /= 1.02
	if Input.is_action_pressed("movement_speed_up") and velocityMultiplier < 10:
		velocityMultiplier *= 1.02
	if Input.is_action_just_pressed("create_new_box"):
		var rootNode = get_node("/root")
		var boxScene = load("res://BasicCube.tscn")
		var box = boxScene.instance()
		box.transform = get_node("ManipulatorMeshes/ManipulatorExtension").global_transform
		rootNode.add_child(box)
	
	direction = direction.normalized()
	
	# where would the player go at max speed
	var target = direction * FLY_SPEED
	
	# calculate a portion of the distance to go
	velocity = velocity.linear_interpolate(target, FLY_ACCEL * delta)
	
	# move
	var _discard = move_and_slide(velocity * velocityMultiplier)
	
func camSwitch():
	if Input.is_action_pressed("camera_1"):
		$Head/FirstPersonCamera.current = true
	if Input.is_action_pressed("camera_2"):
		var camera = get_node("../InterpolatedCamera")
		camera.current = true
	if Input.is_action_pressed("camera_3"):
		var camera = get_node("../Ferry/FerryFollowCamera")
		camera.current = true
	if Input.is_action_pressed("camera_4"):
		var camera = get_node("../Ferry/FerryTopCamera")
		camera.current = true
	if Input.is_action_pressed("camera_5"):
		var camera = get_node("../Target/TargetOrthoCamera")
		camera.current = true
	if Input.is_action_pressed("camera_6"):
		var camera = get_node("../TopCamera_NorthUp")
		camera.current = true
	if Input.is_action_pressed("camera_7"):
		var camera = get_node("../TopCamera_NorthUp_Ortho")
		camera.current = true
	if Input.is_action_pressed("camera_8"):
		var camera = get_node("../LookAtDestinationCameraRig/LookAtDestinationCamera")
		camera.current = true
	if Input.is_action_pressed("camera_9"):
		var camera = get_node("../Ferry/AntennaLoopOrthoCamera")
		camera.current = true
	
func aim():
	if camera_change.length() > 0:
#		$Head.rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))
		transform.basis = Basis()
		camera_angle_y -= camera_change.x * mouse_sensitivity
		camera_angle_x -= camera_change.y * mouse_sensitivity
		
		if camera_angle_x < -90:
			camera_angle_x = -90
		if camera_angle_x > 90:
			camera_angle_x = 90
		
		rotate_x(deg2rad(camera_angle_x))
		rotate_y(deg2rad(camera_angle_y))
		
		


##		var change = -camera_change.y * mouse_sensitivity
##		if change + camera_angle_x < 90 and change + camera_angle_x > -90:
#			$Head/Camera.rotate_x(deg2rad(change))
##			rotate_x(deg2rad(change))
#			camera_angle_x += change
		camera_change = Vector2()
