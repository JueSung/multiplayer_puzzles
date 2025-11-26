extends Node
class_name Lobby

#basically only handles the instantiation of a server, adding/removing players, and disconecting server

signal player_connected(peer_id, player_info)
signal player_disconnected(peer_id)
signal server_disconnected

signal upon_join(peer_id) #also runs set_id

var server_ip = "localhost"
var server_port = 8080
var MAX_CONNECTIONS = 10 #optimal prob 4-6, 8

#dictionary containing player info and player id as keys
var players = {}

# This is the local player info. This should be modified locally
# before the connection is made. It will be passed to every other peer.
# For example, the value of "name" can be set to something the player
# entered in a UI scene.
var player_info = {"name": "Name"}

var players_loaded = 0

func fetch_public_ip():
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", _on_request_completed)
	http_request.request("https://api64.ipify.org")

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		server_ip = body.get_string_from_utf8()
		print("Public IP:", server_ip)
	else:
		print("Failed to fetch public IP.")


func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

#called by host from the host_game button
func create_game():
	#these two are used for port forwarding when host is a player. Does not work
	#fetch_public_ip()
	#---------
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_server(server_port, MAX_CONNECTIONS)
	if result != OK:
		print("Failed to create server")
		return
	multiplayer.multiplayer_peer = peer
	print("Server started on port", server_port)
	
	players[1] = player_info
	
	upon_join.emit(1) # also calls set_id, id = 1
	player_connected.emit(1, player_info)

func join_game(ip, port):
	#get server ip and port from lineedits
	server_ip = ip
	server_port = int(port)
	#----------
	
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_client(server_ip, server_port)
	if result != OK:
		print("Failed to connect to server")
		get_parent().get_node("HUD").get_node("WaitingToStart").text = "Failed to connect to server\nplease return to main menu"
		return
	multiplayer.multiplayer_peer = peer
	print("Connected to server at", server_ip, ":", server_port)
		

#i think only called by main for after host/join game but needs to delete multiplayer peer to go back to main page
func remove_multiplayer_peer():
	multiplayer.multiplayer_peer = null


# When the server decides to start the game from a UI scene,
# do Lobby.load_game.rpc(filepath)
@rpc("call_local", "reliable")
func load_game(game_scene_path):
	get_tree().change_scene_to_file(game_scene_path)


# Every peer will call this when they have loaded the game scene.
@rpc("any_peer", "call_local", "reliable")
func player_loaded():
	if multiplayer.is_server():
		players_loaded += 1
		if players_loaded == players.size():
			$/root/Main.start_game()
			players_loaded = 0


# When a peer connects, send them my player info.
# This allows transfer of all desired data for each player, not only the unique ID.
#when player first connects, they register themself. Then for 1 host and 2 additional joining the order is:
#1st hosts: 2 adds 1
#2 joins: 2 adds 2, 2 adds 1, 1 adds 2
#3 joins: 3 adds 3, 3 adds 1, 2 adds 3, 1 adds 3, 3 adds 2
func _on_player_connected(id):
	_register_player.rpc_id(id, player_info)
#          |
#          |
#          V
@rpc("any_peer", "reliable")
func _register_player(new_player_info):
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	#player_connected = signal to main add_player
	player_connected.emit(new_player_id, new_player_info)


func _on_player_disconnected(id):
	players.erase(id)
	player_disconnected.emit(id)


func _on_connected_ok():
	var peer_id = multiplayer.get_unique_id()
	upon_join.emit(peer_id) ##used to be set_id
	players[peer_id] = player_info
	player_connected.emit(peer_id, player_info)

func _on_connected_fail():
	multiplayer.multiplayer_peer = null
	print("no server :( or connection failed")

func _on_server_disconnected():
	multiplayer.multiplayer_peer = null
	players.clear()
	server_disconnected.emit()

func is_the_host():
	return multiplayer.is_server()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
