extends KinematicBody2D

var hitpoints = 1
var shields = 3
var shields_active = true
var alliance = ""
var type = ""

var max_speed = 0
var fire_rate = 0

var rfi_poly = PoolVector2Array([Vector2(-7, -2), Vector2(-7, 2), Vector2(-6, 5), Vector2(-4, 7), Vector2(1, 7), Vector2(4, 6), Vector2(6, 5), Vector2(7, 4), Vector2(7, -4), Vector2(6, -5), Vector2(4, -6), Vector2(1, -7), Vector2(-4, -7), Vector2(-6, -5)])
var bfi_poly = PoolVector2Array([Vector2(-7, 6), Vector2(-3, 6), Vector2(1, 5), Vector2(1, 2), Vector2(6, 2), Vector2(7, 1), Vector2(7, -1), Vector2(6, -2), Vector2(1, -2), Vector2(1, -5), Vector2(-3, -6), Vector2(-7, -6)])
var gfi_poly = PoolVector2Array([Vector2(6, 4), Vector2(6, -4), Vector2(2, -4), Vector2(2, -7), Vector2(-3, -7), Vector2(-6, -4), Vector2(-6, 4), Vector2(-3, 7), Vector2(2, 7), Vector2(2, 4)])
var yfi_poly = PoolVector2Array([Vector2(6, 1), Vector2(6, -1), Vector2(3, -4), Vector2(3, -5), Vector2(5, -5), Vector2(5, -6), Vector2(0, -6), Vector2(0, -7), Vector2(-3, -7), Vector2(-6, -4), Vector2(-6, 4), Vector2(-3, 7), Vector2(0, 7), Vector2(0, 6), Vector2(5, 6), Vector2(5, 5), Vector2(3, 5), Vector2(3, 4)])
var rfr_poly = PoolVector2Array([Vector2(4, 6), Vector2(4, 3), Vector2(7, 3), Vector2(8, 2), Vector2(8, -2), Vector2(7, -3), Vector2(4, -3), Vector2(4, -6), Vector2(1, -7), Vector2(-5, -7), Vector2(-7, -5), Vector2(-7, 5), Vector2(-5, 7), Vector2(1, 7)])
var bfr_poly = PoolVector2Array([Vector2(-7, 6), Vector2(-3, 6), Vector2(6, 3), Vector2(7, 2), Vector2(7, -2), Vector2(6, -3), Vector2(-3, -6), Vector2(-7, -6)])
var gfr_poly = PoolVector2Array([Vector2(4, 7), Vector2(4, 6), Vector2(3, 5), Vector2(3, 3), Vector2(5, 2), Vector2(6, 1), Vector2(6, -1), Vector2(5, -2), Vector2(3, -3), Vector2(3, -5), Vector2(4, -6), Vector2(4, -7), Vector2(-1, -7), Vector2(-5, -3), Vector2(-5, 3), Vector2(-1, 7)])
var yfr_poly = PoolVector2Array([Vector2(3, 6), Vector2(3, 4), Vector2(4, 4), Vector2(7, 1), Vector2(7, -1), Vector2(4, -4), Vector2(3, -4), Vector2(3, -6), Vector2(-1, -7), Vector2(-4, -7), Vector2(-7, -4), Vector2(-7, 4), Vector2(-4, 7), Vector2(-1, 7)])
var rbo_poly = PoolVector2Array([Vector2(1, 7), Vector2(4, 6), Vector2(6, 5), Vector2(8, 3), Vector2(8, -3), Vector2(6, -5), Vector2(4, -6), Vector2(1, -7), Vector2(-4, -7), Vector2(-6, -5), Vector2(-7, -2), Vector2(-7, 2), Vector2(-6, 5), Vector2(-4, 7)])
var bbo_poly = PoolVector2Array([Vector2(-1, 7), Vector2(1, 6), Vector2(1, 5), Vector2(6, 5), Vector2(6, 1), Vector2(7, 1), Vector2(7, -1), Vector2(6, -1), Vector2(6, -5), Vector2(1, -5), Vector2(1, -6), Vector2(-1, -7), Vector2(-4, -7), Vector2(-4, -2), Vector2(-5, -2), Vector2(-5, 2), Vector2(-4, 2), Vector2(-4, 7)])
var gbo_poly = PoolVector2Array([Vector2(1, 7), Vector2(3, 6), Vector2(6, 3), Vector2(6, -3), Vector2(3, -6), Vector2(1, -7), Vector2(-4, -7), Vector2(-4, -5), Vector2(-5, -3), Vector2(-5, 3), Vector2(-4, 5), Vector2(-4, 7)])
var ybo_poly = PoolVector2Array([Vector2(2, 8), Vector2(2, 4), Vector2(6, 4), Vector2(8, 2), Vector2(8, -2), Vector2(6, -4), Vector2(2, -4), Vector2(2, -8), Vector2(-7, -8), Vector2(-7, 8)])

const BlUE_FIGHTER = preload("res://Graphics/Ships/Blue_Ships/blue_fighter.png")
const BlUE_FRIGATE = preload("res://Graphics/Ships/Blue_Ships/blue_frigate.png")
const BlUE_BOMBER = preload("res://Graphics/Ships/Blue_Ships/blue_bomber.png")
const RED_FIGHTER = preload("res://Graphics/Ships/Red_Ships/red_fighter.png")
const RED_FRIGATE = preload("res://Graphics/Ships/Red_Ships/red_frigate.png")
const RED_BOMBER = preload("res://Graphics/Ships/Red_Ships/red_bomber.png")
const GREEN_FIGHTER = preload("res://Graphics/Ships/Green_Ships/green_fighter.png")
const GREEN_FRIGATE = preload("res://Graphics/Ships/Green_Ships/green_frigate.png")
const GREEN_BOMBER = preload("res://Graphics/Ships/Green_Ships/green_bomber.png")
const YELLOW_FIGHTER = preload("res://Graphics/Ships/Yellow_Ships/yellow_fighter.png")
const YELLOW_FRIGATE = preload("res://Graphics/Ships/Yellow_Ships/yellow_frigate.png")
const YELLOW_BOMBER = preload("res://Graphics/Ships/Yellow_Ships/yellow_bomber.png")

const BULLET = preload("res://Scenes/Objects/Bullet.tscn")
const EXPLOSION = preload("res://Scenes/Objects/ShipExplosion.tscn")

onready var ShipSprite = $Sprite
onready var ShipPolygon = $ShipPolygon
onready var HurtPolygon = $Hurtbox/HurtPolygon
onready var ShieldArea = $ShieldArea
onready var Shield = $Shield

func _ready():
	SetStats()

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

func SetStats():
	if type == "fighter":
		max_speed = 3
		fire_rate = 0
		if alliance == "red":
			ShipPolygon.set_polygon(rfi_poly)
			HurtPolygon.set_polygon(rfi_poly)
			ShipSprite.set_texture(RED_FIGHTER)
		elif alliance == "blue":
			ShipPolygon.set_polygon(bfi_poly)
			HurtPolygon.set_polygon(bfi_poly)
			ShipSprite.set_texture(BlUE_FIGHTER)
		elif alliance == "green":
			ShipPolygon.set_polygon(gfi_poly)
			HurtPolygon.set_polygon(gfi_poly)
			ShipSprite.set_texture(GREEN_FIGHTER)
		elif alliance == "yellow":
			ShipPolygon.set_polygon(yfi_poly)
			HurtPolygon.set_polygon(yfi_poly)
			ShipSprite.set_texture(YELLOW_FIGHTER)
	elif type == "frigate":
		max_speed = 3
		fire_rate = 0
		if alliance == "red":
			ShipPolygon.set_polygon(rfr_poly)
			HurtPolygon.set_polygon(rfr_poly)
			ShipSprite.set_texture(RED_FRIGATE)
		elif alliance == "blue":
			ShipPolygon.set_polygon(bfr_poly)
			HurtPolygon.set_polygon(bfr_poly)
			ShipSprite.set_texture(BlUE_FRIGATE)
		elif alliance == "green":
			ShipPolygon.set_polygon(gfr_poly)
			HurtPolygon.set_polygon(gfr_poly)
			ShipSprite.set_texture(GREEN_FRIGATE)
		elif alliance == "yellow":
			ShipPolygon.set_polygon(yfr_poly)
			HurtPolygon.set_polygon(yfr_poly)
			ShipSprite.set_texture(YELLOW_FRIGATE)
	elif type == "bomber":
		max_speed = 3
		fire_rate = 0
		if alliance == "red":
			ShipPolygon.set_polygon(rbo_poly)
			HurtPolygon.set_polygon(rbo_poly)
			ShipSprite.set_texture(RED_BOMBER)
		elif alliance == "blue":
			ShipPolygon.set_polygon(bbo_poly)
			HurtPolygon.set_polygon(bbo_poly)
			ShipSprite.set_texture(BlUE_BOMBER)
		elif alliance == "green":
			ShipPolygon.set_polygon(gbo_poly)
			HurtPolygon.set_polygon(gbo_poly)
			ShipSprite.set_texture(GREEN_BOMBER)
		elif alliance == "yellow":
			ShipPolygon.set_polygon(ybo_poly)
			HurtPolygon.set_polygon(ybo_poly)
			ShipSprite.set_texture(YELLOW_BOMBER)

func _on_DetectionRadius_area_entered(area):
	print("detected")
	var detected = area.get_parent()
	print(detected.alliance)
