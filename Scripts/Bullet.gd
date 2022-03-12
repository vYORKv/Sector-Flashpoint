extends Area2D

const SPEED = 300

var velocity = Vector2()

const BLUE_BULLET = preload("res://Graphics/Bullets/blue_bullet.png")
const RED_BULLET = preload("res://Graphics/Bullets/red_bullet.png")

func _ready():
	pass

# Nowhere close to final implementation. Just wanted to see it in action
func _physics_process(delta):
	velocity.x = SPEED * delta
	translate(velocity)
