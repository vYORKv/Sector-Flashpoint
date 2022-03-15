class_name Enemy
extends KinematicBody2D

var hitpoints = 1
var shields = 3
var shields_active = true
var alliance = "red"

const EXPLOSION = preload("res://Scenes/Objects/ShipExplosion.tscn")

onready var ShieldArea = get_node("ShieldArea")
onready var Shield = get_node("Shield")
onready var polygon = get_node("CollisionPolygon2D")

func _ready():
	var poly = polygon.get_polygon() # Will need to use polygon array to set shapes for each ship on spawn
	print(poly)

func hit(bullet):
	if shields_active:
		Shield.look_at(bullet)
		Shield.set_frame(0)
		Shield.set_visible(true)
		Shield.play()
		shields -= 1
		print(shields)
	else:
		hitpoints -= 1
		if hitpoints == 0:
			destroy()
	if shields == 0:
		shields_active = false
		ShieldArea.set_deferred("monitorable", false)

func destroy():
	var explosion = EXPLOSION.instance()
	explosion.alliance = alliance
	get_parent().add_child(explosion)
	explosion.position = self.position
	self.queue_free()

func _on_Shield_animation_finished():
	Shield.set_visible(false)
