extends KinematicBody2D

const SPEED = 300

var velocity = Vector2()
var target = null
var alliance = null

const BULLET_HIT = preload("res://Scenes/Objects/BulletHit.tscn")
const BLUE_BULLET = preload("res://Graphics/Bullets/blue_bullet.png")
const RED_BULLET = preload("res://Graphics/Bullets/red_bullet.png")

onready var sprite = get_node("Sprite")
onready var BulletTimer = get_node("BulletTimer")

func _ready():
	if alliance == "blue":
		sprite.set_texture(BLUE_BULLET)
	elif alliance == "red":
		sprite.set_texture(RED_BULLET)
	BulletTimer.set_wait_time(1)
	BulletTimer.connect("timeout", self, "TimerTimeout")
	BulletTimer.start()

func TimerTimeout():
	self.queue_free()

func _physics_process(delta):
	var _collision = move_and_collide(velocity.normalized() * delta * SPEED)

func _on_Hitbox_area_entered(area):
	var bullet_position = self.global_position
	var bullet_hit = BULLET_HIT.instance()
	# Add if statements for victim.alliance here. If blue and
	# (victim.alliance == red or victim.alliance == yellow) then victim.hit
	# [ Maybe use arrays or obj for this instead of stringing 8 if statements ]
	var victim = area.get_parent()
	victim.hit(bullet_position)
	get_parent().add_child(bullet_hit)
	bullet_hit.position = bullet_position
	self.queue_free()
