extends Node
class_name Multiplayer_Processing
#handles game state related multiplayer network stuff
#also for now client input and client specific rendering stuff

var inputs = {}
var my_ID = 1 #for instantiation
#var in_a_game = false #only collects inputs if in a game

var clientToServerInfo = {}

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
	

func set_ID(id):
	my_ID = id

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
	##send_inputs_to_server(packet)
	
	#every frame calls send info to server
	process_send_to_server()
	#resets so info doesn't just get held there forever
	clientToServerInfo = {}

#for sending info from client to server -----------------------------
func append_client_to_server_info(key, info):
	if key == "task":
		if not clientToServerInfo.has(key):
			clientToServerInfo[key] = []
		clientToServerInfo[key].append(info)
	else:
		clientToServerInfo[key] = info
	
#get inputs from own Multiplayer_Processing to own Main
#now sends to a general send info to main bc tasks that updates per frame
##func send_inputs_to_server(packet: Variant):
##	if my_ID != 1:
##		get_parent().append_client_to_server_info(my_ID, packet)
	#	rpc_id(1, "recieve_client_inputs", my_ID, packet)
##	else:
	#	recieve_client_inputs(1, packet)

#recieving client inputs from client Main
##@rpc("any_peer", "unreliable") #now send via recieve_info_from_client()
func recieve_client_inputs(id, packet):
	var inputs = JSON.parse_string(packet)
	get_parent().set_player_inputs(id, inputs)

#generalized send info to server where info is a dictionary updated and reset every frame in main
func process_send_to_server():
	if my_ID != 1:
		rpc_id(1, "process_recieve_from_client", clientToServerInfo)
	else:
		process_recieve_from_client(clientToServerInfo)
@rpc("any_peer", "unreliable")
func process_recieve_from_client(info):
	for key in info:
		match key:
			"inputs":
				recieve_client_inputs(info[key][0], info[key][1])
			"task":
				get_parent().get_node("Multiplayer_Tasks").recieve_process_update_task(info[key])
			
			_:
				print("unknown process info sent to server from client sent")
	
#from server main send out signal to start games to clients
func start_the_games(mode):
	#peer id 0 means all peers besides self
	rpc_id(0, "recieve_start_game", mode)

#recieve start game signal from server, tells client main to start game
@rpc("any_peer", "reliable")
func recieve_start_game(mode):
	get_parent().start_game(mode)

#recieve update information for a particular object based on some id string thing

#called by main to send out updated player info
#func send_player_info(player_datas):
#	rpc_id(0, "recieve_player_info", player_datas)

#@rpc("any_peer", "reliable")
#func recieve_player_info(player_datas):
#	get_parent().update_player_datas(player_datas)
	
#called by server to send out msg to clients to delete a particular player bc dead prob
func send_delete_player(id):
	rpc_id(0, "recieve_delete_player", id)

@rpc("any_peer", "reliable")
func recieve_delete_player(id):
	get_parent().delete_player(id)

#called by main to send out updates for object game states; handles creation of objects by seeing new objects
#func send_object_states(objects_datas):
#	rpc_id(0, "recieve_object_states", objects_datas)

#recieve object game states and new objects for creation
#@rpc("any_peer", "reliable")
#func recieve_object_states(objects_datas):
#	get_parent().update_object_states(objects_datas)

#called by main to send out updates for both player and object states
func send_states(states):
	rpc_id(0, "recieve_states", states)

@rpc("any_peer", "unreliable")
func recieve_states(states):
	for key in states:
		match key:
			"player_datas":
				get_parent().update_player_datas(states[key])
			"objects_datas":
				get_parent().update_object_states(states[key])
			_:
				print("unknown type of state sent server to client \'recieve_states\' in multiplayer_processing")
	##7/30/2025 was when change was made
	##get_parent().update_player_datas(states["player_datas"])
	##get_parent().update_object_states(states["objects_datas"])
	##get_parent().currMap.task_board.update_states(states["task_elements_times"])
	##get_parent().get_node("Multiplayer_Tasks").recieve_process_update_task(states["task"])

#send info to delete object
func send_delete_objects(objects_to_be_deleted):
	if len(objects_to_be_deleted) > 0:
		rpc_id(0, "recieve_delete_objects", objects_to_be_deleted)

#recieve information to delete object
@rpc("any_peer", "reliable")
func recieve_delete_objects(objects_to_be_deleted):
	get_parent().client_delete_objects(objects_to_be_deleted)

#called by server, send msg to end game to clients
func send_end_game():
	rpc_id(0, "recieve_end_game")

#client recieve msg from server to end game
@rpc("any_peer", "reliable")
func recieve_end_game():
	get_parent().end_game()


#player stuff-----------------------------------------------
#id is id num of player object, function_name is function name, args is list of arguments for function
func send_to_server_player_function(id, function_name, args):
	rpc_id(1, "recieve_from_client_player_function", id, function_name, args)

@rpc("any_peer", "reliable")
func recieve_from_client_player_function(id, function_name, args):
	var player = get_parent().get_player_objects()[id]
	player.callv(function_name, args)

#-------------------------------------------------

#input stuff
func _input(event):
	
	if event.is_action_pressed("ESC"):
		print("Hit ESC")






#is called by main when game starts
func is_in_a_game(id):
	pass
	#my_ID = id
	#in_a_game = true
