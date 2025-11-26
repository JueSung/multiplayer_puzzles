extends Node2D
class_name Map
#rn theres only one possible map

var main

#unit = 200
var u = 400
var t = 100#wall thickness
var l = 100 #length of location task area thing

##var SS = preload("res://surface.tscn")
##var FS = preload("res://floor_sprite.tscn")

var walls = [] #just a list of all the walls
var floors = [] #just a list of all the floors


func _ready():
	randomize()
	main = get_tree().root.get_node("Main")
	
	## wallSetUp()
	
	## floorSetUp() #set up sprites for floor
	

func start_game(): #called when game starts
	pass

"""
func wallSetUp():
	#wall types: 0,     1,    2,      3,        4
#           top, bottom, left,   right   diagonal

	##Main Area
	#Q1 right
	var instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(3 * u + 0.5 * t, -1.5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	
	#Q1 up
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(1.5 * u,-3 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	
	#Q2 up
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * u, t), Vector2(-2 * u, -3 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	
	#Q2 left
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(-3 * u - 0.5 * t, -2 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	
	#Q3 left
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(-3 * u - 0.5 * t, 1.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	
	#Q3 down
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(-1.5 * u, 3 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	
	#Q4 down
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * u, t), Vector2(2 * u, 3 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	
	#Q4 right
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(3 * u + 0.5 * t, 2 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	
	##Pink Area
	#1
	instance = SS.instantiate()
	instance.setUp(Vector2(4 * u, t), Vector2(-5 * u, -1 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#2
	instance = SS.instantiate()
	instance.setUp(Vector2(4 * u,  t), Vector2(-5 * u, 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#3
	instance = SS.instantiate()
	instance.setUp(Vector2(t, u), Vector2(-7 * u + 0.5 * t, -1.5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#4
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(-7 * u + 0.5 * t, u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#5
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(-8.5 * u, -2 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#6
	instance = SS.instantiate()
	instance.setUp(Vector2(t, u), Vector2(-10 * u - 0.5 * t, -1.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#7
	instance = SS.instantiate()
	instance.setUp(Vector2(u, t), Vector2(-10.5 * u, -1 * u -0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#8
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(-11 * u + 0.5 * t, -2 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#9
	instance = SS.instantiate()
	instance.setUp(Vector2(3* u, t), Vector2(-9.5 * u, -3 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#10
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(-8 * u + 0.5 * t, -4.5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#11
	instance = SS.instantiate()
	instance.setUp(Vector2(u, t), Vector2(-8.5 * u, -6 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#12
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(-10 * u - 0.5 * t, -7 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#13
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * u, t), Vector2(-11 * u, -6 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#14
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 6 * u), Vector2(-12 * u - 0.5 * t, -3 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#15
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * u, t), Vector2(-11 * u, 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#16
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(-10 * u - 0.5 * t, 1 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#17
	instance = SS.instantiate()
	instance.setUp(Vector2(u, t), Vector2(-9.5 * u, 2 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#18
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(-9 * u -0.5 * t, 3.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#19
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(-8 * u + 0.5 * t, 3 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#20
	instance = SS.instantiate()
	instance.setUp(Vector2(u, t), Vector2(-7.5 * u, 2 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#21
	instance = SS.instantiate()
	instance.setUp(Vector2(t, u), Vector2(-9 * u + 0.5 * t, -6.5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	
	##Blue
	#1
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(-1 * u - 0.5 * t, -4.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#2
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(0.5 * t, -4.5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#3
	instance = SS.instantiate()
	instance.setUp(Vector2(8 * u, t), Vector2(4 * u, -6 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#4
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * u, t), Vector2(8 * u, -7 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#5
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(7 * u+ 0.5 * t, -8.5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#6
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(5.5 * u, -10 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#7
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(2.5 * u, -7 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#8
	instance = SS.instantiate()
	instance.setUp(Vector2(t, u), Vector2(1 * u + 0.5 * t, -7.5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#9
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * sqrt(2) * u, t), Vector2(0.5 * t / sqrt(2), -9 * u - 0.5 * t / sqrt(2)), PI/4.0, 4)
	add_child(instance)
	walls.append(instance)
	#10
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(-2.5 * u, -10 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#11
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(-4 * u - 0.5 * t, -9 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#12
	instance = SS.instantiate()
	instance.setUp(Vector2(6 * u, t), Vector2(-7 * u, -8 * u - 0.5  * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#13
	instance = SS.instantiate()
	instance.setUp(Vector2(5 * u, t), Vector2(-6.5 * u, -7 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#14
	instance = SS.instantiate()
	instance.setUp(Vector2(t, u), Vector2(-4 * u - 0.5 * t, -6.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#15
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(-2.5 * u, -6 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#16
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(4 * u - 0.5 * t, -8.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	
	##Yellow
	#1
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(4.5 * u, 1 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#2
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(4.5 * u, -0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#3
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(6 * u - 0.5 * t, -1.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#4
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * u, t), Vector2(7 * u, -3 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#5
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(8 * u - 0.5 * t, -4.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#6
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 4 * u), Vector2(9 * u + 0.5 * t, -5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#7
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * u, t), Vector2(10 * u, -3 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#8
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(11 * u - 0.5 * t, -4 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#9
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(12.5 * u, -5 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#10
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(14 * u + 0.5 * t, -4 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#11
	instance = SS.instantiate()
	instance.setUp(Vector2(u, t), Vector2(14.5 * u, -3 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#12
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(15 * u + 0.5 * t, -2 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#13
	instance = SS.instantiate()
	instance.setUp(Vector2(u, t), Vector2(15.5 * u, -1 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#14
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(16 * u + 0.5 * t, 0.5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#15
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * u, t), Vector2(15 * u, 2 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#16
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 4 * u), Vector2(14 * u + 0.5 * t, 4 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#17
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(13 * u - 0.5 * t, 3.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#18
	instance = SS.instantiate()
	instance.setUp(Vector2(7 * u, t), Vector2(9.5 * u, 2 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#19
	instance = SS.instantiate()
	instance.setUp(Vector2(t, u), Vector2(6 * u - 0.5 * t, 1.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#20
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(8 * u + 0.5 * t, -1 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#21
	instance = SS.instantiate()
	instance.setUp(Vector2(6 * u, t), Vector2(11 * u, -2 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#22
	instance = SS.instantiate()
	instance.setUp(Vector2(t, u), Vector2(14 * u - 0.5 * t, -1.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#23
	instance = SS.instantiate()
	instance.setUp(Vector2(u, t), Vector2(13.5 * u, -1 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#24
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(13 * u - 0.5 * t, 0), 0, 2)
	add_child(instance)
	walls.append(instance)
	#25
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * u, t), Vector2(12 * u, 1 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#26
	instance = SS.instantiate()
	instance.setUp(Vector2(t, u), Vector2(11 * u + 0.5 * t, 0.5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#27
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(9.5 * u, -0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	
	##Green
	#1
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(-0.5 * t, 4.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#2
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(u + 0.5 * t, 4.5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#3
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(2.5 * u, 6 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#4
	instance = SS.instantiate()
	instance.setUp(Vector2(t, u), Vector2(4 * u - 0.5 * t, 5.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#5
	instance = SS.instantiate()
	instance.setUp(Vector2(9 * u, t), Vector2(8.5 * u, 5 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#6
	instance = SS.instantiate()
	instance.setUp(Vector2(7 * u, t), Vector2(10.5 * u, 6 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#7
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(7 * u + 0.5 * t,7 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#8
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * u, t), Vector2(6 * u, 8 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#9
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(5 * u + 0.5 * t, 9 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#10
	instance = SS.instantiate()
	instance.setUp(Vector2(u ,t), Vector2(5.5 * u, 10 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#11
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(6 * u + 0.5 * t, 11.5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#12
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(4.5 * u, 13 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#13
	instance = SS.instantiate()
	instance.setUp(Vector2(t, u), Vector2(3 * u - 0.5 * t, 12.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#14
	instance = SS.instantiate()
	instance.setUp(Vector2(4 * u, t), Vector2(u, 12 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#15
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(-1 * u - 0.5 * t, 10.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#16
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * u, t), Vector2(-2 * u, 9 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#17
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 4 * u), Vector2(-3 * u - 0.5 * t, 7 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#18
	instance = SS.instantiate()
	instance.setUp(Vector2(6 * u, t), Vector2(-6 * u, 5 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#19
	instance = SS.instantiate()
	instance.setUp(Vector2(6 * u, t), Vector2(-5 * u, 4 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#20
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(-2 * u + 0.5 * t, 5 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#21
	instance = SS.instantiate()
	instance.setUp(Vector2(2 * u, t), Vector2(-1 * u, 6 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#22
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(2.5 * u, 7 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#23
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 3 * u), Vector2(4 * u - 0.5 * t, 8.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#24
	instance = SS.instantiate()
	instance.setUp(Vector2(u, t), Vector2(3.5 * u, 10 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#25
	instance = SS.instantiate()
	instance.setUp(Vector2(t, u), Vector2(3 * u - 0.5 * t, 10.5 * u), 0, 2)
	add_child(instance)
	walls.append(instance)
	#26
	instance = SS.instantiate()
	instance.setUp(Vector2(3 * u, t), Vector2(1.5 * u, 11 * u - 0.5 * t), 0, 0)
	add_child(instance)
	walls.append(instance)
	#27
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(0.5 * t, 10 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	#28
	instance = SS.instantiate()
	instance.setUp(Vector2(u, t), Vector2(0.5 * u, 9 * u + 0.5 * t), 0, 1)
	add_child(instance)
	walls.append(instance)
	#29
	instance = SS.instantiate()
	instance.setUp(Vector2(t, 2 * u), Vector2(u + 0.5 * t, 8 * u), 0, 3)
	add_child(instance)
	walls.append(instance)
	
	print(main.my_ID)
	if main.my_ID != 1:
		for i in range(len(walls)):
			walls[i].get_node("CollisionShape2D").disabled = true
	
	
	#create all map elements
	#floor
	var floor = SurfaceScene.instantiate()
	floor.setUp(Vector2(1920, 40), Vector2(1920/2, 1080), 0)
	add_child(floor)
	#walls
	var wall_instance = SurfaceScene.instantiate()
	wall_instance.setUp(Vector2(40,1080), Vector2(0, 540), 0)
	add_child(wall_instance)
	
	wall_instance = SurfaceScene.instantiate()
	wall_instance.setUp(Vector2(40,1080), Vector2(1920, 540), 0)
	add_child(wall_instance)
	
	#ceiling
	var ceiling = SurfaceScene.instantiate()
	ceiling.setUp(Vector2(1920,40), Vector2(1920/2, 0), 0)
	add_child(ceiling)
	
	#ledges
	var ledge = SurfaceScene.instantiate()
	ledge.setUp(Vector2(1920/5.0, 20), Vector2(1920/10.0, 540), 0)
	add_child(ledge)
	
	ledge = SurfaceScene.instantiate()
	ledge.setUp(Vector2(1920/5, 20), Vector2(1920 - 1920/10, 540), 0)
	add_child(ledge)
	
	var task_location = preload("res://task_location.tscn").instantiate()
	task_location.position = Vector2(1920/5.0, 540)
	add_child(task_location)

func floorSetUp():
	var floor_instance
	#Central area (left -> right, then top -> bottom)
	floors.append([])
	
	for i in range(36):
		floor_instance = FS.instantiate()
		floor_instance.get_node("blue").visible = true
		floor_instance.position = Vector2(-2.5 * u + i/6 * u,-2.5 * u + i%6 * u)
		add_child(floor_instance)
		floors[0].append(floor_instance)
	
	#pink
	floors.append([])
	
	#mid right hallway
	for i in range(4):
		floor_instance = FS.instantiate()
		floor_instance.get_node("pink").visible = true
		floor_instance.position = Vector2(-6.5 * u + i * u,-0.5 * u)
		add_child(floor_instance)
		floors[1].append(floor_instance)
	
	#lower hallway
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("pink").visible = true
		floor_instance.position = Vector2(-8.5 * u, 2.5 * u + i * u)
		add_child(floor_instance)
		floors[1].append(floor_instance)
	for i in range(2):
		floor_instance = FS.instantiate()
		floor_instance.get_node("pink").visible = true
		floor_instance.position = Vector2(-7.5 * u + i * u, 4.5 * u)
		add_child(floor_instance)
		floors[1].append(floor_instance)
	
	#middle left hallway
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("pink").visible = true
		floor_instance.position = Vector2(-11.5 * u, -2.5 * u + i * u)
		add_child(floor_instance)
		floors[1].append(floor_instance)
	floor_instance = FS.instantiate()
	floor_instance.get_node("pink").visible = true
	floor_instance.position = Vector2(-10.5 * u, -0.5 * u)
	add_child(floor_instance)
	floors[1].append(floor_instance)
	
	#upper hallway
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("pink").visible = true
		floor_instance.position = Vector2(-9.5 * u + i * u, -7.5 * u)
		add_child(floor_instance)
		floors[1].append(floor_instance)
	floor_instance = FS.instantiate()
	floor_instance.get_node("pink").visible = true
	floor_instance.position = Vector2(-9.5 * u, -6.5 * u)
	add_child(floor_instance)
	floors[1].append(floor_instance)
	
	#upper room
	for i in range(12):
		floor_instance = FS.instantiate()
		floor_instance.get_node("pink").visible = true
		floor_instance.position = Vector2(-11.5 * u + i / 3 * u, -5.5 * u + i%3 * u)
		add_child(floor_instance)
		floors[1].append(floor_instance)
	
	#lower room
	for i in range(12):
		floor_instance = FS.instantiate()
		floor_instance.get_node("pink").visible = true
		floor_instance.position = Vector2(-9.5 * u + i%3*u, -1.5 * u + i/3 * u)
		add_child(floor_instance)
		floors[1].append(floor_instance)
	
	#blue
	floors.append([])
	
	#left hall
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("blue").visible = true
		floor_instance.position = Vector2(-6.5 * u + i * u, -7.5 * u)
		add_child(floor_instance)
		floors[2].append(floor_instance)
	
	#middle lower hall
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("blue").visible = true
		floor_instance.position = Vector2(-0.5 * u, -5.5 * u + i * u)
		add_child(floor_instance)
		floors[2].append(floor_instance)
		
	#middle middle hall
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("blue").visible = true
		floor_instance.position = Vector2(1.5 * u + i * u, -6.5 * u)
		add_child(floor_instance)
		floors[2].append(floor_instance)
	
	#right hall
	for i in range(2):
		floor_instance = FS.instantiate()
		floor_instance.get_node("blue").visible = true
		floor_instance.position = Vector2(7.5 * u + i * u, -6.5 * u)
		add_child(floor_instance)
		floors[2].append(floor_instance)
	floor_instance = FS.instantiate()
	floor_instance.get_node("blue").visible = true
	floor_instance.position = Vector2(8.5 * u, -5.5 * u)
	add_child(floor_instance)
	floors[2].append(floor_instance)
	
	#left room
	for i in range(16):
		floor_instance = FS.instantiate()
		floor_instance.get_node("blue").visible = true
		floor_instance.position = Vector2(-3.5 * u + i/4 * u, -9.5 * u + i%4 * u)
		add_child(floor_instance)
		floors[2].append(floor_instance)
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("blue").visible = true
		floor_instance.position = Vector2(0.5 * u, -8.5 * u + i * u)
		add_child(floor_instance)
		floors[2].append(floor_instance)
	
	#right room
	for i in range(12):
		floor_instance = FS.instantiate()
		floor_instance.get_node("blue").visible = true
		floor_instance.position = Vector2(4.5 * u + i%3 * u, -9.5 * u + i/3 * u)
		add_child(floor_instance)
		floors[2].append(floor_instance)
	
	#yellow
	floors.append([])
	
	#up hallway
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("yellow").visible = true
		floor_instance.position = Vector2(8.5 * u, -4.5 * u + i * u)
		add_child(floor_instance)
		floors[3].append(floor_instance)
	
	#up middle hall
	for i in range(2):
		floor_instance = FS.instantiate()
		floor_instance.get_node("yellow").visible = true
		floor_instance.position = Vector2(9.5 * u + i * u, -2.5 * u)
		add_child(floor_instance)
		floors[3].append(floor_instance)
	
	#right up hall
	for i in range(2):
		floor_instance = FS.instantiate()
		floor_instance.get_node("yellow").visible = true
		floor_instance.position = Vector2(14.5 * u, -2.5 * u + i * u)
		add_child(floor_instance)
		floors[3].append(floor_instance)
	
	#left hall
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("yellow").visible = true
		floor_instance.position = Vector2(3.5 * u + i * u, 0.5 * u)
		add_child(floor_instance)
		floors[3].append(floor_instance)
	
	#middle hall
	for i in range(2):
		floor_instance = FS.instantiate()
		floor_instance.get_node("yellow").visible = true
		floor_instance.position = Vector2(11.5 * u + i * u, 1.5 * u)
		add_child(floor_instance)
		floors[3].append(floor_instance)
	
	#right bottom hall
	for i in range(4):
		floor_instance = FS.instantiate()
		floor_instance.get_node("yellow").visible = true
		floor_instance.position = Vector2(13.5 * u, 2.5 * u + i * u)
		add_child(floor_instance)
		floors[3].append(floor_instance)
	floor_instance = FS.instantiate()
	floor_instance.get_node("yellow").visible = true
	floor_instance.position = Vector2(12.5 * u, 5.5 * u)
	add_child(floor_instance)
	floors[3].append(floor_instance)
	
	#top room
	for i in range(9):
		floor_instance = FS.instantiate()
		floor_instance.get_node("yellow").visible = true
		floor_instance.position = Vector2(11.5 * u + i/3 * u, -4.5 * u + i%3 * u)
		add_child(floor_instance)
		floors[3].append(floor_instance)
	
	#left room
	for i in range(10):
		floor_instance = FS.instantiate()
		floor_instance.get_node("yellow").visible = true
		floor_instance.position = Vector2(6.5 * u + i%2 * u, -2.5 * u + i/2 * u)
		add_child(floor_instance)
		floors[3].append(floor_instance)
	for i in range(6):
		floor_instance = FS.instantiate()
		floor_instance.get_node("yellow").visible = true
		floor_instance.position = Vector2(8.5 * u + i%3 * u, 0.5 * u + i/3 * u)
		add_child(floor_instance)
		floors[3].append(floor_instance)
	
	#right room
	for i in range(9):
		floor_instance = FS.instantiate()
		floor_instance.get_node("yellow").visible = true
		floor_instance.position = Vector2(13.5 * u + i/3 * u, -0.5 * u + i%3 * u)
		add_child(floor_instance)
		floors[3].append(floor_instance)
	
	#green
	floors.append([])
	
	#left hall
	for i in range(4):
		floor_instance = FS.instantiate()
		floor_instance.get_node("green").visible = true
		floor_instance.position = Vector2(-5.5 * u + i * u, 4.5 * u)
		add_child(floor_instance)
		floors[4].append(floor_instance)
	floor_instance = FS.instantiate()
	floor_instance.get_node("green").visible = true
	floor_instance.position = Vector2(-2.5 * u, 5.5 * u)
	add_child(floor_instance)
	floors[4].append(floor_instance)
	
	#mid top hall
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("green").visible = true
		floor_instance.position = Vector2(0.5 * u, 3.5 * u + i * u)
		add_child(floor_instance)
		floors[4].append(floor_instance)
	
	#mid mid hall
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("green").visible = true
		floor_instance.position = Vector2(1.5 * u + i * u, 6.5 * u)
		add_child(floor_instance)
		floors[4].append(floor_instance)
	
	#right hall
	for i in range(5):
		floor_instance = FS.instantiate()
		floor_instance.get_node("green").visible = true
		floor_instance.position = Vector2(7.5 * u + i * u, 5.5 * u)
		add_child(floor_instance)
		floors[4].append(floor_instance)
	
	#bottom left hall
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("green").visible = true
		floor_instance.position = Vector2(-0.5 * u, 9.5 * u + i * u)
		add_child(floor_instance)
		floors[4].append(floor_instance)
	for i in range(3):
		floor_instance = FS.instantiate()
		floor_instance.get_node("green").visible = true
		floor_instance.position = Vector2(0.5 * u + i * u, 11.5 * u)
		add_child(floor_instance)
		floors[4].append(floor_instance)
	
	#right bottom hall
	for i in range(2):
		floor_instance = FS.instantiate()
		floor_instance.get_node("green").visible = true
		floor_instance.position = Vector2(4.5 * u, 8.5 * u + i * u)
		add_child(floor_instance)
		floors[4].append(floor_instance)
	
	#left room
	for i in range(12):
		floor_instance = FS.instantiate()
		floor_instance.get_node("green").visible = true
		floor_instance.position = Vector2(-2.5 * u + i%4 * u, 6.5 * u + i/4 * u)
		add_child(floor_instance)
		floors[4].append(floor_instance)

	#right top room
	for i in range(9):
		floor_instance = FS.instantiate()
		floor_instance.get_node("green").visible = true
		floor_instance.position = Vector2(4.5 * u + i%3 * u, 5.5 * u + i/3 * u)
		add_child(floor_instance)
		floors[4].append(floor_instance)

	#right bottom
	for i in range(9):
		floor_instance = FS.instantiate()
		floor_instance.get_node("green").visible = true
		floor_instance.position = Vector2(3.5 * u + i%3 * u, 10.5 * u + i/3 * u)
		add_child(floor_instance)
		floors[4].append(floor_instance)

"""
