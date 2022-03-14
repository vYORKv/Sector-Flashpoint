extends Node2D

onready var animation = get_node("AnimatedSprite")

var alliance = null

func _ready():
	if alliance == "red":
		animation.set_animation("red_explosion")
	elif alliance == "blue":
		animation.set_animation("blue_explosion")
	animation._set_playing(true)

func _on_AnimatedSprite_animation_finished():
	self.queue_free()
