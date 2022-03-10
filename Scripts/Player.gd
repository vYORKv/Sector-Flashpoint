extends KinematicBody2D

const acceleration = 5
const max_speed = 5
const friction = 4
const speed = 10
const turn_speed = 0.2

#var velocity = Vector2()
var velocity = Vector2.ZERO
onready var TweenNode = get_node("Tween")

var inputs = {
	"ui_right": Vector2.RIGHT,
	"ui_left": Vector2.LEFT,
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN
}

func _ready():
	pass

#func GetInput():
#	var mouse_position = get_global_mouse_position()
#	velocity = Vector2()
#	# initial and final x-vector of basis
#	var initial_transform_x = self.transform.x
#	var final_transform_x = (mouse_position - self.global_position).normalized()
#	# interpolate
#	TweenNode.interpolate_method(self, '_set_rotation', initial_transform_x, final_transform_x, turn_speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
#	TweenNode.start()
#
#	if Input.is_action_pressed("ui_up"):
#		speed = lerp(speed, max_speed, get_process_delta_time()*acceleration)
#		velocity = Vector2(speed, 0).rotated(rotation)
#	elif Input.is_action_pressed("ui_down"):
#		speed = lerp(speed, max_speed, get_process_delta_time()*acceleration)
#		velocity = Vector2(-speed * .7, 0).rotated(rotation)
#	elif Input.is_action_pressed("ui_left"):
#		speed = lerp(speed, max_speed, get_process_delta_time()*acceleration)
#		velocity = Vector2(0, -speed * .7).rotated(rotation)
#	elif Input.is_action_pressed("ui_right"):
#		speed = lerp(speed, max_speed, get_process_delta_time()*acceleration)
#		velocity = Vector2(0, speed * .7).rotated(rotation)

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	var input_vector = Vector2.ZERO
	var direction = (mouse_position - self.position).normalized()
	# initial and final x-vector of basis
	var initial_transform_x = self.transform.x
	var final_transform_x = (mouse_position - self.global_position).normalized()
	# interpolate
	TweenNode.interpolate_method(self, '_set_rotation', initial_transform_x, final_transform_x, turn_speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	TweenNode.start()
	look_at(mouse_position)
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = (input_vector - mouse_position).normalized()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	move_and_collide(velocity)

func _set_rotation(new_transform):
	# apply tweened x-vector of basis
	self.transform.x = new_transform
	# make x and y orthogonal and normalized
	self.transform = self.transform.orthonormalized()
