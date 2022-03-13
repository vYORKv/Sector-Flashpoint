class_name Ally
extends KinematicBody2D

const ACCELERATION = 5
const FRICTION = 4
const SPEED = 10
const TURN_SPEED = 0.2

var velocity = Vector2.ZERO
var combat_speed = true
var max_speed = 3
var can_shoot = true
var fire_rate = .5
var alliance = "blue"

const BULLET = preload("res://Scenes/Objects/Bullet.tscn")
const EXPLOSION = preload("res://Scenes/Objects/ShipExplosion.tscn")

onready var TweenNode = get_node("Tween")
onready var Thruster = get_node("Thruster")
onready var Gun = get_node("Gun")
onready var Aim = get_node("Aim")
onready var ShootTimer = get_node("ShootTimer")

func _ready():
	ShootTimer.set_wait_time(fire_rate)
	ShootTimer.connect("timeout", self, "TimerTimeout")

func debug():
	pass

func TimerTimeout():
	can_shoot = true

func _input(event):
	if event.is_action_pressed("combat_speed"):
		if combat_speed == true:
			max_speed = max_speed * .45
			combat_speed = false
			print(max_speed)
		else:
			max_speed = 3
			combat_speed = true
			print(max_speed)
	if event.is_action_pressed("shoot"):
		if can_shoot:
			shoot()
			can_shoot = false
			ShootTimer.start()
	if event.is_action_pressed("ui_accept"):
		destroy()

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - self.position).normalized()
	var direction_x = direction.tangent()
	
	# initial and final x-vector of basis
	var initial_transform_x = self.transform.x
	var final_transform_x = (mouse_position - self.global_position).normalized()
	# interpolate
	TweenNode.interpolate_method(self, '_set_rotation', initial_transform_x, 
	final_transform_x, TURN_SPEED, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	TweenNode.start()
	look_at(mouse_position)
	
	if Input.get_action_strength("forward"):
		velocity = velocity.move_toward(direction * max_speed, ACCELERATION * delta)
		Thruster.set_visible(true)
	elif Input.get_action_strength("reverse"):
		velocity = velocity.move_toward(-direction * (max_speed * .6), ACCELERATION * delta)
		Thruster.set_visible(false)
	elif Input.get_action_strength("strafe_left"):
		velocity = velocity.move_toward(direction_x * (max_speed * .6), ACCELERATION * delta)
		Thruster.set_visible(false)
	elif Input.get_action_strength("strafe_right"):
		velocity = velocity.move_toward(-direction_x * (max_speed * .6), ACCELERATION * delta)
		Thruster.set_visible(false)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		Thruster.set_visible(false)
	move_and_collide(velocity)

func _set_rotation(new_transform):
	# apply tweened x-vector of basis
	self.transform.x = new_transform
	# make x and y orthogonal and normalized
	self.transform = self.transform.orthonormalized()

func shoot():
	var bullet = BULLET.instance()
	bullet.target = "enemy"
	bullet.color = "blue"
	get_parent().add_child(bullet)
	bullet.position = Gun.global_position
	bullet.velocity = Aim.global_position - bullet.position

func hit():
	pass

func destroy():
	var explosion = EXPLOSION.instance()
	explosion.color = "blue"
	get_parent().add_child(explosion)
	explosion.position = self.position
#	self.queue_free()
