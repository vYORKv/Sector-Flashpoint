class_name Enemy
extends KinematicBody2D

var hitpoints = 3

func _ready():
	pass

func hit():
	hitpoints -= 1
	print(hitpoints)
	if hitpoints == 0:
		destroy()

func destroy():
	print("DEAD")
	self.queue_free()
