extends Node2D

onready var animation = $AnimatedSprite

func _ready():
	animation.play()

func _on_AnimatedSprite_animation_finished():
	self.queue_free()
