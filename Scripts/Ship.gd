extends KinematicBody2D

const ACCELERATION = 5
const FRICTION = 4
const TURN_SPEED = 0.2

enum {
	SEARCH,
	MOVE,
	ENGAGE,
	WING
}

var state = MOVE
var target = null
var target_array = []

var velocity = Vector2.ZERO
var hitpoints = 1
var shields = 0
var shields_active = true
var alliance = ""
var type = ""

var max_speed = 0
var fire_rate = 0
var reloaded = true
var can_shoot = true

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

const BLUE_FIGHTER = preload("res://Graphics/Ships/Blue_Ships/blue_fighter.png")
const BLUE_FRIGATE = preload("res://Graphics/Ships/Blue_Ships/blue_frigate.png")
const BLUE_BOMBER = preload("res://Graphics/Ships/Blue_Ships/blue_bomber.png")
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
onready var ShootTimer = $ShootTimer
onready var Gun = $Gun
onready var Aim = $Aim
onready var ShootRange = $ShootRange
onready var ShootSFX = $ShootSFX
onready var DetectionRadius = $DetectionRadius
onready var Buffer = $Buffer

func _ready():
	SetStats()
	ShootTimer.set_wait_time(fire_rate)
	ShootTimer.connect("timeout", self, "Reload")

func Reload():
	reloaded = true

func RangeCheck():
	var range_target = ShootRange.get_collider()
	if range_target and range_target.alliance != alliance:
		can_shoot = true
	else:
		can_shoot = false

func Buffer():
	var buffer_target = Buffer.get_collider()
	if buffer_target and buffer_target.alliance != alliance:
		return true

func _physics_process(delta):
#	var target_position = Vector2(5,5)
#	var direction = (target_position - self.position).normalized()
	
#	if !is_instance_valid(target_array):
#		target = null
#	else:
#		TargetCheck(target_array)
	var forward = (Aim.global_position - self.position).normalized()
	var forward_x = forward.tangent()
	
	RangeCheck()
	
	match state:
		SEARCH:
			DetectionRadius.monitoring = false
			DetectionRadius.monitoring = true
			move(delta)
		MOVE:
			move(delta)
		WING:
			pass
		ENGAGE:
			if target and is_instance_valid(target):
				var target_flank = target.get_node("Flank/CollisionShape2D")
				var t_flank_pos = target_flank.global_position
				var target_position = target.global_position
				var direction = (t_flank_pos - self.position).normalized()
				var direction_x = direction.tangent()
				look_at(target_position)
				if Buffer():
					velocity = velocity.move_toward(direction_x * max_speed, ACCELERATION * delta)
				else:
					velocity = velocity.move_toward(direction * max_speed, ACCELERATION * delta)
				if can_shoot and reloaded:
					shoot()
					reloaded = false
					ShootTimer.start()
			else:
				target = null
				state = SEARCH
	
#	velocity = velocity.move_toward(direction * max_speed, ACCELERATION * delta)
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.normal)
#		BumpSFX.play()

func move2(point):
	pass

func move(delta):
	var point = get_parent().get_node("MovePoint")
	var point_pos = point.global_position
	var direction = (point_pos - self.position)
	velocity = velocity.move_toward(direction * max_speed, ACCELERATION * delta)
	look_at(point_pos)

#func TargetCheck(array):
#	var targets = array
#	for x in targets:
#		if !is_instance_valid(x):
#			targets.remove(x)

func hit(bullet):
	if shields_active:
		Shield.look_at(bullet)
		Shield.set_frame(0)
		Shield.set_visible(true)
		Shield.play(alliance)
		shields -= 1
	else:
		hitpoints -= 1
		if hitpoints <= 0:
			destroy()
	if shields == 0:
		shields_active = false
		ShieldArea.set_deferred("monitorable", false)

func shoot():
	var bullet = BULLET.instance()
	bullet.target = "enemy"
	bullet.alliance = alliance
	get_parent().add_child(bullet)
	bullet.position = Gun.global_position
	bullet.velocity = Aim.global_position - bullet.position
	ShootSFX.play()

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
		fire_rate = .75
		shields = 2
		if alliance == "red":
			ShipPolygon.set_polygon(rfi_poly)
			HurtPolygon.set_polygon(rfi_poly)
			ShipSprite.set_texture(RED_FIGHTER)
		elif alliance == "blue":
			ShipPolygon.set_polygon(bfi_poly)
			HurtPolygon.set_polygon(bfi_poly)
			ShipSprite.set_texture(BLUE_FIGHTER)
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
		fire_rate = 1
		shields = 2
		if alliance == "red":
			ShipPolygon.set_polygon(rfr_poly)
			HurtPolygon.set_polygon(rfr_poly)
			ShipSprite.set_texture(RED_FRIGATE)
		elif alliance == "blue":
			ShipPolygon.set_polygon(bfr_poly)
			HurtPolygon.set_polygon(bfr_poly)
			ShipSprite.set_texture(BLUE_FRIGATE)
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
		fire_rate = 1
		shields = 3
		if alliance == "red":
			ShipPolygon.set_polygon(rbo_poly)
			HurtPolygon.set_polygon(rbo_poly)
			ShipSprite.set_texture(RED_BOMBER)
		elif alliance == "blue":
			ShipPolygon.set_polygon(bbo_poly)
			HurtPolygon.set_polygon(bbo_poly)
			ShipSprite.set_texture(BLUE_BOMBER)
		elif alliance == "green":
			ShipPolygon.set_polygon(gbo_poly)
			HurtPolygon.set_polygon(gbo_poly)
			ShipSprite.set_texture(GREEN_BOMBER)
		elif alliance == "yellow":
			ShipPolygon.set_polygon(ybo_poly)
			HurtPolygon.set_polygon(ybo_poly)
			ShipSprite.set_texture(YELLOW_BOMBER)

func _on_DetectionRadius_area_entered(area):
	var detected = area.get_parent()
	if detected.alliance != self.alliance:
		target = detected
		state = ENGAGE
#		target_array.push_back(target)
#		target = target_array[0]
