extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var positionupdatesPerSecond = 10 as int
var timeAfterPositionUpdate = 0 as float
#var destHost = "localhost" as String
#var destHost = "192.168.1.54" as String
var destHost = "127.0.0.1" as String
var destPort = 65511 as int
var serverPort = 65512 as int
var serverPeer:PacketPeerUDP
var clientPeer:PacketPeerUDP
var autopilotCommandTimeout = 5/8 as float
var timeAfterAutopilotCommand = 1e9 as float
var autopilotActive = false
#var peer

# Called when the node enters the scene tree for the first time.
func _ready():
	clientPeer = PacketPeerUDP.new()
	clientPeer.set_dest_address(destHost, destPort)

#	if (clientPeer.listen(destPort, destHost) != OK):
#		printt("UDP sender: Error listening on port: " + str(destPort) + " in server: " + "*")
#	else:
#		printt("UDP sender: Listening on port: " + str(destPort) + " in server: " + "*")
		
	serverPeer = PacketPeerUDP.new()
	if (serverPeer.listen(serverPort) != OK):
		printt("UDP receiver: Error listening on port: " + str(serverPort))
	else:
		printt("UDP receiver: Listening on port: " + str(serverPort))
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (clientPeer != null) && (serverPeer != null):
		timeAfterAutopilotCommand += delta
		timeAfterPositionUpdate += delta
		if timeAfterPositionUpdate >= 1.0/positionupdatesPerSecond:
			while timeAfterPositionUpdate >= 1.0/positionupdatesPerSecond:
				timeAfterPositionUpdate -= 1.0/positionupdatesPerSecond
				
			var antenna1 = get_node("Ferry/AntennaRig1")	# How to do this:	as AntennaRig
			var antenna2 = get_node("Ferry/AntennaRig2")	# How to do this:	as AntennaRig
			var antenna3 = get_node("Ferry/AntennaRig3")	# How to do this:	as AntennaRig

			var antenna1AbsPos = antenna1.global_transform.origin
			var antenna2AbsPos = antenna2.global_transform.origin
			var antenna3AbsPos = antenna3.global_transform.origin

			var antenna1RelPos = antenna1.transform.origin
			var antenna2RelPos = antenna2.transform.origin
			var antenna3RelPos = antenna3.transform.origin

			var text = """%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f"""\
				% [antenna1AbsPos.x, antenna1AbsPos.y, antenna1AbsPos.z,\
				antenna2AbsPos.x, antenna2AbsPos.y, antenna2AbsPos.z, \
				antenna3AbsPos.x, antenna3AbsPos.y, antenna3AbsPos.z, \
				antenna1RelPos.x, antenna1RelPos.y, antenna1RelPos.z, \
				antenna2RelPos.x, antenna2RelPos.y, antenna2RelPos.z, \
				antenna3RelPos.x, antenna3RelPos.y, antenna3RelPos.z]
				
			clientPeer.put_packet(text.to_ascii())
			
		while (serverPeer.get_available_packet_count() > 0):
			var recvBytes = serverPeer.get_packet() as PoolByteArray
			var recvString = recvBytes.get_string_from_ascii();
			printt("UDP-packet received: " + recvString)
			var floats = recvString.split_floats(";",false) as PoolRealArray
			
			match floats[0]:
				1.0:
					if (floats.size() >= 13):
						var x_axis = Vector3(floats[1+0*4+0], floats[1+0*4+1], floats[1+0*4+2])
						var y_axis = Vector3(floats[1+1*4+0], floats[1+1*4+1], floats[1+1*4+2])
						var z_axis = Vector3(floats[1+2*4+0], floats[1+2*4+1], floats[1+2*4+2])
		
		#				var x_axis = Vector3(floats[0*4+0], floats[1*4+0], floats[2*4+0])
		#				var y_axis = Vector3(floats[0*4+1], floats[1*4+1], floats[2*4+1])
		#				var z_axis = Vector3(floats[0*4+2], floats[1*4+2], floats[2*4+2])
		
						var origin = Vector3(floats[1+0*4+3], floats[1+1*4+3], floats[1+2*4+3])
						
						var transform = Transform(x_axis, y_axis, z_axis, origin)
						
						var indicator = get_node("Indicator")
						indicator.transform = transform
					else:
						printt("UDP-packet received: Not enough floats for matrix.")
				2.0:
					if (floats.size() >= 5):
						timeAfterAutopilotCommand = 0;
						var prop_front = get_node("Ferry/WatercraftPropulsion_Front_External") as WatercraftPropulsion
						var indicator_front = get_node("Ferry/NonBuoyantMeshes/PropIndicator_Front_External") as MeshInstance
#						var radians = -(self.value * 2 * PI / 360) + PI
						var radians = floats[1]
						prop_front.direction = Vector3(-sin(radians), 0, cos(radians))
						indicator_front.rotation = Vector3(PI/2, -radians, 0)

						var propulsion_front = floats[2]
						prop_front.value = propulsion_front
						var prism_front = indicator_front.mesh as PrismMesh
						prism_front.size = Vector3(1, max(propulsion_front / 10000, 0.01), 0.5)

						var prop_rear = get_node("Ferry/WatercraftPropulsion_Rear_External") as WatercraftPropulsion
						var indicator_rear = get_node("Ferry/NonBuoyantMeshes/PropIndicator_Rear_External") as MeshInstance
#						var radians = -(self.value * 2 * PI / 360) + PI
						radians = floats[3]
						prop_rear.direction = Vector3(-sin(radians), 0, cos(radians))
						indicator_rear.rotation = Vector3(PI/2, -radians, 0)

						var propulsion_rear = floats[4]
						prop_rear.value = propulsion_rear
						var prism_rear = indicator_rear.mesh as PrismMesh
						prism_rear.size = Vector3(1, max(propulsion_rear / 10000, 0.01), 0.5)
					else:
						printt("UDP-packet received: Not enough floats for propulsions.")
						
				3.0:
					if (floats.size() >= 3):
						var target = get_node("Target") as Spatial
						var East = floats[1]
						var South = floats[2]
						var radians = floats[3]
						
						var x_axis = Vector3(-cos(radians), 0, -sin(radians))
						var y_axis = Vector3(0, 1, 0)
						var z_axis = Vector3(sin(radians), 0, -cos(radians))

						var origin = Vector3(East, 0, South)
						
						var transform = Transform(x_axis, y_axis, z_axis, origin)
						
						target.transform = transform;
					
					else:
						printt("UDP-packet received: Not enough floats for destination.")

				_:
					printt("UDP-packet received: Unknown frame type.")
		if (timeAfterAutopilotCommand < autopilotCommandTimeout):
			autopilotActive = true
		else:
			autopilotActive = false

			var prop_front = get_node("Ferry/WatercraftPropulsion_Front_External") as WatercraftPropulsion
			var indicator_front = get_node("Ferry/NonBuoyantMeshes/PropIndicator_Front_External") as MeshInstance
			var radians = 0
			prop_front.direction = Vector3(-sin(radians), 0, cos(radians))
			prop_front.value = 0;
			indicator_front.rotation = Vector3(PI/2, -radians, 0)		
			var prism_front = indicator_front.mesh as PrismMesh
			prism_front.size = Vector3(1, 0.01, 0.5)

			var prop_rear = get_node("Ferry/WatercraftPropulsion_Rear_External") as WatercraftPropulsion
			var indicator_rear = get_node("Ferry/NonBuoyantMeshes/PropIndicator_Rear_External") as MeshInstance
			prop_rear.direction = Vector3(-sin(radians), 0, cos(radians))
			prop_rear.value = 0;
			indicator_rear.rotation = Vector3(PI/2, -radians, 0)		
			var prism_rear = indicator_rear.mesh as PrismMesh
			prism_rear.size = Vector3(1, 0.01, 0.5)
			
func coordsEUSToNED(coords):
	var eus = coords as Vector3
	return Vector3(-eus[2], eus[0], -eus[1])
	
func coordsNEDToEUS(coords):
	var ned = coords as Vector3
	return Vector3(ned[1], -ned[2], -ned[0])
	
