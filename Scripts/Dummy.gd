class_name Enemy
extends KinematicBody2D

var hitpoints = 3

const EXPLOSION = preload("res://Scenes/Objects/ShipExplosion.tscn")

onready var CenterPoint = get_node("CenterPoint")

func _ready():
	pass

func hit():
	hitpoints -= 1
	print(hitpoints)
	if hitpoints == 0:
		destroy()

func destroy():
	var center_point = CenterPoint.global_position
	var explosion = EXPLOSION.instance()
	get_parent().add_child(explosion)
#	explosion.position = center_point.position
	self.queue_free()
