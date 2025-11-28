extends CharacterBody2D
class_name Player
#set camera zoom to .7

var main = null
var my_ID

const SPEED = 840# * 3
const GRAVITY = 900

#user input info ---------
var left = false
var right = false
var up = false
var down = false
var left_click = false
var right_click = false
var mouse_position = Vector2(0,0)
#-------------------------

var task_locations = []
var inTask = false #whether in a task or not

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
		print("RAN")
		velocity.y += GRAVITY * delta
	
	if up:
		velocity.y = -1000
	
	
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


func update_game_state(dataa):
	global_position = dataa["position"]
