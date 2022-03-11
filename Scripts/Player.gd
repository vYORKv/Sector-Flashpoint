extends KinematicBody2D

const acceleration = 5
const friction = 4
const speed = 10
const turn_speed = 0.2

var velocity = Vector2.ZERO
var combat_speed = true
var max_speed = 3

onready var TweenNode = get_node("Tween")

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("combat_speed"):
		if combat_speed == true:
			max_speed = max_speed * .45
			combat_speed = false
		else:
			max_speed = 3
			combat_speed = true

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - self.position).normalized()
	var direction_x = direction.tangent()
	
	# initial and final x-vector of basis
	var initial_transform_x = self.transform.x
	var final_transform_x = (mouse_position - self.global_position).normalized()
	# interpolate
	TweenNode.interpolate_method(self, '_set_rotation', initial_transform_x, 
	final_transform_x, turn_speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	TweenNode.start()
	look_at(mouse_position)
	
	if Input.get_action_strength("forward"):
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	elif Input.get_action_strength("reverse"):
		velocity = velocity.move_toward(-direction * (max_speed * .6), acceleration * delta)
	elif Input.get_action_strength("strafe_left"):
		velocity = velocity.move_toward(direction_x * (max_speed * .6), acceleration * delta)
	elif Input.get_action_strength("strafe_right"):
		velocity = velocity.move_toward(-direction_x * (max_speed * .6), acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	move_and_collide(velocity)
	print(max_speed)

func _set_rotation(new_transform):
	# apply tweened x-vector of basis
	self.transform.x = new_transform
	# make x and y orthogonal and normalized
	self.transform = self.transform.orthonormalized()
