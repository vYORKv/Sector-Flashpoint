extends KinematicBody2D

const SM_ASTER_01 = preload("res://Graphics/Asteroids/small_asteroid_01.png")
const SM_ASTER_02 = preload("res://Graphics/Asteroids/small_asteroid_02.png")
const SM_ASTER_03 = preload("res://Graphics/Asteroids/small_asteroid_03.png")

var alliance = "neutral"
var sprites = [SM_ASTER_01, SM_ASTER_02, SM_ASTER_03]

onready var sprite = $Sprite 

func _ready():
	randomize()
	
	sprite.set_texture(GetSprite())

func GetSprite():
	var random_sprite = sprites[randi() % sprites.size()]
	return random_sprite

func Hit(bullet):
	pass
