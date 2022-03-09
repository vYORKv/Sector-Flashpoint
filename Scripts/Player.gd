extends KinematicBody2D

const acceleration = 8
const max_speed = 1
const friction = 60

var velocity = Vector2.ZERO

var inputs = {
	"ui_right": Vector2.RIGHT,
	"ui_left": Vector2.LEFT,
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN
}

func _ready():
	pass

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	var input_vector = Vector2.ZERO
	
	look_at(mouse_position)
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	move_and_collide(velocity)
