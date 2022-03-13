extends KinematicBody2D

const SPEED = 300

var velocity = Vector2()
var target = null

const BLUE_BULLET = preload("res://Graphics/Bullets/blue_bullet.png")
const RED_BULLET = preload("res://Graphics/Bullets/red_bullet.png")

func _ready():
	pass

func _physics_process(delta):
	var collision = move_and_collide(velocity.normalized() * delta * SPEED)

func _on_Hitbox_area_entered(area):
	var victim = area.get_parent()
	victim.hit()
	self.queue_free()
