extends Node

const DUMMY = preload("res://Scenes/Actors/Dummy.tscn")
const DESIGN_SHIP = preload("res://Scenes/Actors/DesignShip.tscn")
const AST_SM = preload("res://Scenes/Objects/AsteroidSmall.tscn")
const CROSSHAIR = preload("res://Graphics/UI/green_crosshair.png")
const SHIP = preload("res://Scenes/Actors/Ship.tscn")

onready var AS1 = get_node("AsteroidSpawn1")
onready var AS2 = get_node("AsteroidSpawn2")
onready var AS3 = get_node("AsteroidSpawn3")
onready var SS1 = get_node("ShipSpawn1")
onready var SS2 = get_node("ShipSpawn2")
onready var SS3 = get_node("ShipSpawn3")
onready var SS4 = get_node("ShipSpawn4")
onready var SS5 = get_node("ShipSpawn5")

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
	var design_ship = DESIGN_SHIP.instance()
	add_child(design_ship)
	design_ship.position = SS1.global_position
	Input.set_custom_mouse_cursor(CROSSHAIR)
	
	ShipSpawner("fighter", "blue", SS2.global_position)
	ShipSpawner("fighter", "red", SS3.global_position)
	ShipSpawner("fighter", "green", SS4.global_position)
	ShipSpawner("fighter", "yellow", SS5.global_position)

func ShipSpawner(type, alliance, spawn):
	var ship = SHIP.instance()
	ship.type = type
	ship.alliance = alliance
	ship.position = spawn
	add_child(ship)
