class_name Enemy
extends KinematicBody2D

var hitpoints = 1
var shields = 3
var shields_active = true
var alliance = "red"

var rf_poly = PoolVector2Array([Vector2(7.08706, -4.2319), Vector2(7.00831, 4.27257), Vector2(1.02369, 7.26488), Vector2(-4.33098, 7.26488), Vector2(-6.22086, 5.06002), Vector2(-7.24455, 1.91022), Vector2(-7.24455, -2.10578), Vector2(-6.06337, -5.17684), Vector2(-4.09474, -7.06672), Vector2(0.944939, -7.14546)]
)
var bf_poly = PoolVector2Array([Vector2(7.0625, -0.0625), Vector2(7.0625, 1.03125), Vector2(6, 2.0625), Vector2(1, 5.03125), Vector2(-2.96875, 6.0625), Vector2(-7.03125, 6.03125), Vector2(-6.9375, -6), Vector2(-3.03125, -6), Vector2(0.96875, -5), Vector2(6, -2), Vector2(7, -0.96875)]
)

const EXPLOSION = preload("res://Scenes/Objects/ShipExplosion.tscn")

onready var ShieldArea = get_node("ShieldArea")
onready var Shield = get_node("Shield")
onready var Polygon = get_node("CollisionPolygon2D")

func _ready():
	var poly = Polygon.get_polygon() # Will need to use polygon array to set shapes for each ship on spawn
	print("Dummy  ", poly)
	Polygon.set_polygon(rf_poly)

func hit(bullet):
	if shields_active:
		Shield.look_at(bullet)
		Shield.set_frame(0)
		Shield.set_visible(true)
		Shield.play(alliance)
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
