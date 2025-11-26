extends Node

var my_ID = 1 #for instantiation
var inputs = {}

var clientToServerInfo = {}

func set_ID(id):
	my_ID = id

# Called when the node enters the scene tree for the first time.
func _ready():
	inputs = {
		"left" : false,
		"right" : false,
		"up" : false,
		"down" : false,
		"left_click" : false,
		"right_click" : false,
		"mouse_position_x" : 0,
		"mouse_position_y" : 0
	}

func _process(delta):
	#set inputs------------------------------------------------
	inputs["left"] = Input.is_action_pressed("left")
	inputs["right"] = Input.is_action_pressed("right")
	inputs["up"] = Input.is_action_pressed("up")
	inputs["down"] = Input.is_action_pressed("down")
	inputs["left_click"] = Input.is_action_pressed("left_click")
	inputs["right_click"] = Input.is_action_pressed("right_click")

	inputs["mouse_position_x"] = get_viewport().get_mouse_position().x
	inputs["mouse_position_y"] = get_viewport().get_mouse_position().y
	#-----------------------------------------------------------------------
	
	var packet = JSON.stringify(inputs)
	append_client_to_server_info("inputs", [my_ID, packet])
	
	#every frame calls send info to server
	process_send_to_server()


#add data to dictionary sorted by type and during process will send to server
func append_client_to_server_info(type, info):
	match type:
		"inputs":
			clientToServerInfo[type] = info
		_:
			print("unknown data type for sending to host")

####################################################################################################
# GENERALIZED SEND/RECIEVE PROCESS_DATA FROM CLIENT TO HOST-----------------------------------------
####################################################################################################

#generalized send info to server where info is a dictionary updated and reset every frame in main
func process_send_to_server():
	if my_ID != 1:
		rpc_id(1, "process_recieve_from_client", clientToServerInfo)
	else:
		process_recieve_from_client(clientToServerInfo)
	#resets so info doesn't just get held there forever
	clientToServerInfo = {}

# server recieve process data from client and call appropriate functions based on types of data
@rpc("any_peer", "unreliable")
func process_recieve_from_client(info):
	for type in info:
		match type:
			"inputs":
				recieve_client_inputs(info[type][0], info[type][1])			
			_:
				print("unknown process info sent to server from client sent")
####################################################################################################
#---------------------------------------------------------------------------------------------------
####################################################################################################

#recieving client inputs from client Main
func recieve_client_inputs(id, packet):
	var inputs = JSON.parse_string(packet)
	get_parent().set_player_inputs(id, inputs)
