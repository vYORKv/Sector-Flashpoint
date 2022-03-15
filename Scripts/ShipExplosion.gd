extends Node2D

onready var animation = get_node("AnimatedSprite")
onready var SFX = get_node("SFX")

var alliance = null

func _ready():
	if alliance == "red":
		animation.set_animation("red_explosion")
	elif alliance == "blue":
		animation.set_animation("blue_explosion")
	SFX.play()
	animation.play()

func _on_AnimatedSprite_animation_finished():
	pass

func _on_SFX_finished():
	self.queue_free()
