class_name Enemy
extends KinematicBody2D

var hitpoints = 3
var alliance = "red"

const EXPLOSION = preload("res://Scenes/Objects/ShipExplosion.tscn")

func _ready():
	pass

func hit():
	hitpoints -= 1
	print(hitpoints)
	if hitpoints == 0:
		destroy()

func destroy():
	var explosion = EXPLOSION.instance()
	explosion.color = "red"
	get_parent().add_child(explosion)
	explosion.position = self.position
	self.queue_free()
