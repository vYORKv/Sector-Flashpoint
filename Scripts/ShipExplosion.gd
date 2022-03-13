extends Node2D

onready var animation = get_node("AnimatedSprite")

func _ready():
	animation.set_animation("red_explosion")
	animation._set_playing(true)

func _on_AnimatedSprite_animation_finished():
	self.queue_free()
