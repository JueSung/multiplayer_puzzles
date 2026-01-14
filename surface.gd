extends StaticBody2D
class_name Surface
#meant for walls, etc. handled by Map

#wall types: 0,     1,    2,      3,        4
#           top, bottom, left,   right   diagonal

#unit size of wall should be same as in map
var u = 400
var t = 100 #wall hitbox thickness
var panel_sprites = []

##var panel_sprite_scene = preload("res://wall_sprite.tscn")

func setUp(size, pos, rot):
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate() #separates resource so same scene shapes are independent
	$CollisionShape2D.shape.size = size
	
	position = pos
	rotation = rot

func _ready():
	pass
	# need to hitboxes to be on for client side prediction of client side entities that interact with it
	## if get_tree().root.get_node("Main").my_ID != 1:
	## 	$CollisionShape2D.disabled = true
	
