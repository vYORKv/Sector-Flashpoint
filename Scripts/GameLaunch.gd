extends Node

const DUMMY = preload("res://Scenes/Actors/Dummy.tscn")
const AST_SM = preload("res://Scenes/Objects/AsteroidSmall.tscn")

onready var AS1 = get_node("AsteroidSpawn1")
onready var AS2 = get_node("AsteroidSpawn2")
onready var AS3 = get_node("AsteroidSpawn3")

func _ready():
	var dummy = DUMMY.instance()
	add_child(dummy)
	var a1 = AST_SM.instance()
	var a2 = AST_SM.instance()
	var a3 = AST_SM.instance()
	add_child(a1)
	add_child(a2)
	add_child(a3)
	a1.position = AS1.global_position
	a2.position = AS2.global_position
	a3.position = AS3.global_position
