extends Node2D

onready var animation = get_node("AnimatedSprite")

var color = null

func _ready():
	if color == "red":
		animation.set_animation("red_explosion")
	elif color == "blue":
		animation.set_animation("blue_explosion")
	animation._set_playing(true)

func _on_AnimatedSprite_animation_finished():
	self.queue_free()
