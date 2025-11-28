extends Node

var players_IDs = [] #for host, #in order as joined from host perspective
var players_inputs = {} #dictionary of player id : dictionary of inputs
var player_datas = {}

var objects_datas = {}
var objects_to_be_deleted = []

var clientToServerInfo = {}

#player_datas + objects_datas + task_infos
var states = {
} 

var my_ID

func set_id(id):
	my_ID = id
	
	if my_ID == 1:
		set_process(true)

func _ready():
	$Lobby.player_loaded.rpc_id(1)
	
	#initialize process to be not run, when set id, id = 1 will have process running
	set_process(false)


func upon_join(peer_id):
	get_parent().upon_join(peer_id)
	set_id(peer_id)


#recieved from lobby _register_player when player joins both server and clients
func register_player(peer_id, _player_info):
	players_IDs.append(peer_id)
	
	get_parent().add_player(peer_id)

#signal recieved from lobby _on_player_disconnected if any peer disconnecs
func player_disconnected(peer_id):
	players_IDs.remove_at(players_IDs.find(peer_id))
	players_inputs.erase(peer_id)
	
	get_parent().remove_player(peer_id)
	remove_player(peer_id)

func remove_player(peer_id):
	player_datas.erase(peer_id)
	if my_ID == 1:
		$ToClient.send_delete_player(peer_id)

#for client when/if server disconnects -- called by 
func server_disconnected():
	return_to_title_page()

func start_game():
	$ToClient.send_start_game()
	
func end_game():
	objects_datas = {}
	$ToClient.send_end_game()
	

func return_to_title_page():
	get_parent().return_to_title_page()
	player_datas = {}
	players_inputs = {}
	players_IDs = []
	objects_datas = {}
	
func set_player_inputs(id, inputs):
	players_inputs[id] = inputs

#only runs if my_ID == 1
func _process(delta):
	var player_objects = get_parent().get_player_objects()
	# update player_objects input values
	for id in player_objects: #enhanced for loop
		if id in players_inputs:
			player_objects[id].update_inputs(players_inputs[id])
		# update player_datas
		player_datas[id] = player_objects[id].get_data()
	
	if get_parent().is_inGame():
		var objects = get_parent().get_objects()
		# update object datas from objects
		for key in objects:
			if is_instance_valid(objects[key]):
				objects_datas[key] = objects[key].get_data()
		
		#$Multiplayer_Processing.send_object_states(objects_datas) #handles objects to be added via seeing new objects
		states["player_datas"] = player_datas
		states["objects_datas"] = objects_datas
		
		$ToClient.send_delete_objects(objects_to_be_deleted)
		objects_to_be_deleted = []
	
	$ToClient.send_states(states)

# ran by clients::_____________________
func update_player_datas(player_datass):
	player_datas = player_datass	
	#for id in player_datas:
		#if player_objects.has(id) and is_instance_valid(player_objects[id]):
			#player_objects[id].update_game_state(player_datass[id])
	
func update_object_states(objects_datass):
	var objects = get_parent().get_objects()
	for key in objects_datass:
		#handle new objects, creation
		if not objects.has(key):
			var type = objects_datass[key]["type"]
			match type:
				##"Sawblade":
				##	var obj = Scenes[type].instantiate()
				##	objects[key] = obj
				##	add_child(obj)
				##"Boom":
				##	var obj = Scenes[type].instantiate()
				##	objects[key] = obj
				##	add_child(obj)
				_: #else
					pass
		else:
			if is_instance_valid(objects[key]):
				objects[key].update_game_state(objects_datass[key])

#only for clients # not sure if works bc if enhanced for loop gets messed up when you delete during
func client_delete_objects(objects_to_be_deletedd):
	var objects = get_parent().get_objects()
	for i in range(len(objects_to_be_deletedd)):
		var key = objects_to_be_deletedd[i]
		if objects.has(key) and is_instance_valid(objects[key]):
			get_parent().remove_object(key)
			objects_datas.erase(key)
		
