extends CharacterBody2D
class_name Player
#set camera zoom to .7

var main = null
var my_ID

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

var data = {}

func set_ID(id):
	my_ID = id


func _ready():
	main = get_tree().root.get_node("Main")
	
	if main.my_ID != 1:
		$CollisionShape2D.disabled = true
		
		set_process(false)
	else:
		data["position"] = global_position
		
	

func _process(delta):
	
	var direction_x = 0
	#left, right
	if right:
		direction_x += 1
	if left:
		direction_x -= 1
	
	if not is_on_floor():
		if velocity.y <= 0 || up:
			velocity.y += GRAVITY * delta
		else:
			velocity.y += GRAVITY * 1.5 * delta 
	
	if up and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif not up and not is_on_floor() and velocity.y < 0:
		velocity.y -= (5 * velocity.y) * delta
	
	
	velocity.x = move_toward(velocity.x, direction_x * SPEED, SPEED * delta * 30)
	"""if direction:
		direction = direction.normalized()
		velocity = velocity.move_toward(direction * SPEED, SPEED * delta * 30)
	else:
		velocity.x = move_toward(velocity.x, 0, 20 * SPEED * delta)"""
		
	
	move_and_slide()
	
	data["position"] = position


func get_data():
	return data

func update_inputs(inputs):
	left = inputs["left"]
	right = inputs["right"]
	up = inputs["up"]
	down = inputs["down"]
	left_click = inputs["left_click"]
	right_click = inputs["right_click"]
	mouse_position.x = inputs["mouse_position_x"]
	mouse_position.y = inputs["mouse_position_y"]


func update_state(dataa):
	for key in dataa:
		match key:
			"position":
				global_position = dataa["position"]
			_:
				print("unknown updating player data type")
