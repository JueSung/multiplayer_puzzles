extends CharacterBody2D
class_name Player
#set camera zoom to .7

var main = null
var my_ID # id of the client that owns this player, not of main, matches with is_multiplayer_authority()
var process_fn # type function - process function either server or client - see _ready() for clarification
# time delta of game tick speed aka speed of sending clients updated game state information
var tick_length = 1.0/20
var accumulator = 0.0

const SPEED = 840# * 3
const GRAVITY = 2800

var JUMP_VELOCITY = -1 * sqrt(GRAVITY * 2 * 240)

#user input info ---------
var left = false
var right = false
var up = false
var down = false
var left_click = false
var right_click = false
var mouse_position = Vector2(0,0)
#-------------------------

var inputs = {
	"left" : false,
	"right" : false,
	"up" : false,
	"down" : false,
	"left_click" : false,
	"right_click" : false,
	"mouse_position_x" : 0.0,
	"mouse_position_y" : 0.0
} # used for client side prediction
var inputs_queue = [] # used for client side prediction
var data = {
	"position" : Vector2(0.0, 0.0),
	"velocity" : Vector2(0.0, 0.0),
	"rotation" : 0.0
}
# basically same as data, but the target_states we will be lerping to
var target_state = {
	"position" : Vector2(0.0, 0.0),
	"velocity" : Vector2(0.0, 0.0),
	"rotation" : 0.0
}
# offsets for reconcillation with authority state, lerped at exponential rate
var reconcillation_offset = {
	"position" : Vector2(0.0, 0.0),
	"velocity" : Vector2(0.0, 0.0),
	"rotation" : 0.0
}

func set_ID(id):
	my_ID = id

var temp_thing

func _ready():
	main = get_tree().root.get_node("Main")
	
	if main.my_ID != 1 and not is_multiplayer_authority(): # is client and doesn't control this player\
		set_physics_process(false)
		## process_fn = _render_process
		## $CollisionShape2D.disabled = true # need hitboxes on for client side prediction
		
	else:
		if main.my_ID == 1:# and not is_multiplayer_authority():
			set_process(false)
			process_fn = _server_process
		else:
			process_fn = _client_prediction_process
		
		if is_multiplayer_authority():
			inputs = main.get_node("Multiplayer_Processing").get_node("ToServer").get_inputs()
			temp_thing = inputs
			inputs_queue = main.get_node("Multiplayer_Processing").get_node("ToServer").get_inputs_queue()
		
		data["position"] = global_position
		data["velocity"] = velocity
		data["rotation"] = global_rotation
		
		

func _process(delta):
	_render_process(delta) # CHANGE just put it here

func _physics_process(delta):
	process_fn.call(delta) # CHANGE just put it here
	
func _server_process(delta):
	var direction_x = 0
	#left, right
	if inputs["right"]:
		direction_x += 1
	if inputs["left"]:
		direction_x -= 1
	
	if not is_on_floor():
		if velocity.y <= 0 || inputs["up"]:
			velocity.y += GRAVITY * delta
		else:
			velocity.y += GRAVITY * 1.5 * delta 
		
	if inputs["up"] and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif not inputs["up"] and not is_on_floor() and velocity.y < 0:
		velocity.y -= (5 * velocity.y) * delta
		
	
	velocity.x = move_toward(velocity.x, direction_x * SPEED, SPEED * delta * 30)
	##if direction:
	##	direction = direction.normalized()
	##	velocity = velocity.move_toward(direction * SPEED, SPEED * delta * 30)
	##else:
	##	velocity.x = move_toward(velocity.x, 0, 20 * SPEED * delta)
		
	
	move_and_slide()
	
	data["position"] = global_position
	data["rotation"] = global_rotation

# only difference between client_prediction_process and server_process is that 
# global_position/rotation/other rendered states gets set back to
# the original global_position to be lerped by _render_process
func _client_prediction_process(delta):
	accumulator = 0.0
	# temporary states to set variables back later, but also data is used as original state for linear interpolation
	data["position"] = global_position
	data["velocity"] = velocity
	data["rotation"] = global_rotation
	
	global_position = target_state["position"]
	velocity = target_state["velocity"]
	global_rotation = target_state["rotation"]
	
	var direction_x = 0
	#left, right
	if inputs["right"]:
		direction_x += 1
	if inputs["left"]:
		direction_x -= 1
	
	if not is_on_floor():
		if velocity.y <= 0 || inputs["up"]:
			velocity.y += GRAVITY * delta
		else:
			velocity.y += GRAVITY * 1.5 * delta 
		
	if inputs["up"] and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif not inputs["up"] and not is_on_floor() and velocity.y < 0:
		velocity.y -= (5 * velocity.y) * delta
		
	
	velocity.x = move_toward(velocity.x, direction_x * SPEED, SPEED * delta * 30)
	##if direction:
	##	direction = direction.normalized()
	##	velocity = velocity.move_toward(direction * SPEED, SPEED * delta * 30)
	##else:
	##	velocity.x = move_toward(velocity.x, 0, 20 * SPEED * delta)
		
	
	move_and_slide()
	
	target_state["position"] = global_position
	target_state["velocity"] = velocity # prob not used but whatever
	target_state["rotation"] = global_rotation
	
	# data is used as original state for linear interpolation
	global_position = data["position"]
	velocity = data["velocity"]
	global_rotation = data["rotation"]

# used by update_data to "catch up" after snapping to authority state, and now reapplying inputs, basically
# same as _client_prediction_process but using different dictionaries cuz need to calculate offsets as result
# state is the whatever state it is in the catch up process
# used_inputs are just inputs how they would be used here if they were the inputs, but not actually using inputs variable
# delta is just tick_length
func catch_up(state, used_inputs, delta):
	# temporary states to set variables back later, but also data is used as original state for linear interpolation
	var prev_global_position = global_position
	var prev_velocity = velocity
	var prev_rotation = global_rotation
	
	global_position = state["position"]
	velocity = state["velocity"]
	global_rotation = state["rotation"]
	
	var direction_x = 0
	#left, right
	if used_inputs["right"]:
		direction_x += 1
	if used_inputs["left"]:
		direction_x -= 1
	
	if not is_on_floor():
		if velocity.y <= 0 || used_inputs["up"]:
			velocity.y += GRAVITY * delta
		else:
			velocity.y += GRAVITY * 1.5 * delta 
		
	if used_inputs["up"] and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif not used_inputs["up"] and not is_on_floor() and velocity.y < 0:
		velocity.y -= (5 * velocity.y) * delta
		
	
	velocity.x = move_toward(velocity.x, direction_x * SPEED, SPEED * delta * 30)
	##if direction:
	##	direction = direction.normalized()
	##	velocity = velocity.move_toward(direction * SPEED, SPEED * delta * 30)
	##else:
	##	velocity.x = move_toward(velocity.x, 0, 20 * SPEED * delta)
		
	
	move_and_slide()
	
	state["position"] = global_position
	state["velocity"] = velocity # prob not used but whatever
	state["rotation"] = global_rotation
	
	# data is used as original state for linear interpolation
	global_position = prev_global_position
	velocity = prev_velocity
	global_rotation = prev_rotation
	
	# don't need to return state, since state is passed by alias


# different than _server_process, each state interpolates to render states
func _render_process(delta):
	accumulator += delta
	if not is_multiplayer_authority():
		if accumulator > tick_length:
			accumulator -= tick_length
	
	# weight for interpolation based on how fast _process runs and the game's tick speed is
	var lerp_weight = accumulator / tick_length
	var offset_lerp_weight = delta / tick_length # lerp_weight for exponential interpolation for reoncillation_offset

	for key in data:
		match key:
			"position":
				# INTERPOLATE - note - never reaches exact position, for fast moving objects, will want to use 
				# linear interpolation where in update_state, store a calculated step that will be added to variable
				# every frame where the step size is based on start/end position and difference in rendering tick
				# speed and game update tick speed
				global_position = lerp(data["position"], target_state["position"], lerp_weight) + reconcillation_offset["position"]
				# lerp reconcillation_offset exponentially
				if is_multiplayer_authority():
					reconcillation_offset["position"] = lerp(reconcillation_offset["position"], Vector2(0,0), offset_lerp_weight)
				print(reconcillation_offset["position"])
			"rotation":
				global_rotation = lerp(data["rotation"], target_state["rotation"], lerp_weight) + reconcillation_offset["rotation"]
			"velocity":
				pass # do nothing
			_:
				print("player node - idk what this data type is that wants to be rendered")
	
func get_data():
	return data

# only run on server
func update_inputs(inputss): # CHANGE LATER, in ToServer figure out diff between inputs and player_inputs and figure out how to incorporate either/both into this system
	inputs = inputss
	left = inputss["left"]
	right = inputss["right"]
	up = inputss["up"]
	down = inputss["down"]
	left_click = inputss["left_click"]
	right_click = inputss["right_click"]
	mouse_position.x = inputss["mouse_position_x"]
	mouse_position.y = inputss["mouse_position_y"]

# recieve new state from server, need to snap to new authoritative state, and predict for all sets of inputs after last_input_num
func update_state(authority_state, last_inputs_num):
	if not is_multiplayer_authority():
		for key in authority_state:
			match key:
				"position":
					target_state[key] = authority_state[key] # CHANGE to reconcillation_offset
				# no longer doing just 'position = authority_state["position"]', we interpolating now
				"velocity":
					pass # we don't care about velocity for entities that are only being rendered and not predicted
				"rotation":
					target_state[key] = authority_state[key]
				_:
					print("player object update state, unknown state type")
		return
	#else: # is client owned
	for key in authority_state:
		match key:
			"position":
				target_state[key] = authority_state[key]
			"velocity":
				target_state[key] = authority_state[key]
			"rotation":
				target_state[key] = authority_state[key]
			_:
				print("player object update state, unknown state type")
		
	# now for client side prediction
	if len(inputs_queue) == 0:
		return
	# step 1: remove all unnecessary saved input sets (the ones occured before the authority state that's now been recieved
	while inputs_queue[0][0] <= last_inputs_num:
		inputs_queue.remove_at(0)
		if len(inputs_queue) == 0:
			return
	
	# step2: apply input sets that occured after authority state time to predict current state using fixed tick rate
	var state = authority_state.duplicate()
	for i in range(len(inputs_queue)):
		# else apply inputs and run appropriate _process function for fixed tick length
		# state gets updated by alias, so need for return value or anything like that
		catch_up(state, inputs_queue[i][1], tick_length) # prediction by applying inputs thru _process at fixed tick rate
	
	print("D")
	# calculate offsets
	for key in reconcillation_offset:
		reconcillation_offset[key] += target_state[key] - state[key]
		target_state[key] = state[key] # kinda silly but it works, this way, the target_state = state + reoncillation_offset
		# and then you can just lerp offset to zero
		# this also means with this change here, nothing visually actually changes, but you can lerp offset to zero again hooray
