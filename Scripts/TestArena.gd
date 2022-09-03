extends Node2D

const DUMMY = preload("res://Scenes/Actors/Dummy.tscn")
const DESIGN_SHIP = preload("res://Scenes/Actors/DesignShip.tscn")
const AST_SM = preload("res://Scenes/Objects/AsteroidSmall.tscn")
const CROSSHAIR = preload("res://Graphics/UI/green_crosshair.png")
const SHIP = preload("res://Scenes/Actors/Ship.tscn")
const PLAYER = preload("res://Scenes/Actors/Player.tscn")

onready var AS1 = $AsteroidSpawn1
onready var AS2 = $AsteroidSpawn2
onready var AS3 = $AsteroidSpawn3
onready var AS4 = $AsteroidSpawn4
onready var AS5 = $AsteroidSpawn5
onready var AS6 = $AsteroidSpawn6
onready var SS1 = $ShipSpawn1
onready var SS2 = $ShipSpawn2
onready var SS3 = $ShipSpawn3
onready var SS4 = $ShipSpawn4
onready var SS5 = $ShipSpawn5
onready var SS6 = $ShipSpawn6
onready var SS7 = $ShipSpawn7
onready var SS8 = $ShipSpawn8
onready var SS9 = $ShipSpawn9
onready var SS10 = $ShipSpawn10
onready var SS11 = $ShipSpawn11
onready var SS12 = $ShipSpawn12
onready var SS13 = $ShipSpawn13
onready var SS14 = $ShipSpawn14
onready var SS15 = $ShipSpawn15
onready var PS = $PlayerSpawn
onready var DUMMY_T = $Dummy

var s1 = null
var s2 = null
var s3 = null
var s4 = null
var s5 = null
var s6 = null
var s7 = null
var s8 = null
var s9 = null
var s10 = null
var s11 = null
var s12 = null
var s13 = null
var s14 = null
var s15 = null

var dummy_dead = false

#var ship_array = [s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11]

func _ready():
	PlayerSpawner()
#	var dummy = DUMMY.instance()
#	add_child(dummy)
	var a1 = AST_SM.instance()
	var a2 = AST_SM.instance()
	var a3 = AST_SM.instance()
	var a4 = AST_SM.instance()
	var a5 = AST_SM.instance()
	var a6 = AST_SM.instance()
	add_child(a1)
	add_child(a2)
	add_child(a3)
	add_child(a4)
	add_child(a5)
	add_child(a6)
	a1.position = AS1.global_position
	a2.position = AS2.global_position
	a3.position = AS3.global_position
	a4.position = AS4.global_position
	a5.position = AS5.global_position
	a6.position = AS6.global_position
#	var design_ship = DESIGN_SHIP.instance()
#	add_child(design_ship)
#	design_ship.position = SS1.global_position
	Input.set_custom_mouse_cursor(CROSSHAIR)

func _input(event):
	if event.is_action_pressed("ui_home"):
		SpawnShips()

func SpawnShips():
#	s1 = ShipSpawner("fighter", "blue", SS1.global_position)
#	s2 = ShipSpawner("fighter", "blue", SS2.global_position)
#	s3 = ShipSpawner("fighter", "blue", SS3.global_position)
#	s4 = ShipSpawner("fighter", "red", SS4.global_position)
#	s5 = ShipSpawner("fighter", "red", SS5.global_position)
#	s6 = ShipSpawner("fighter", "red", SS6.global_position)
#	s7 = ShipSpawner("fighter", "red", SS7.global_position)
	s8 = ShipSpawner("fighter", "yellow", SS8.global_position)
	s9 = ShipSpawner("fighter", "yellow", SS9.global_position)
	s10 = ShipSpawner("fighter", "yellow", SS10.global_position)
	s11 = ShipSpawner("fighter", "yellow", SS11.global_position)
#	s12 = ShipSpawner("fighter", "green", SS12.global_position)
#	s13 = ShipSpawner("fighter", "green", SS13.global_position)
#	s14 = ShipSpawner("fighter", "green", SS14.global_position)
#	s15 = ShipSpawner("fighter", "green", SS15.global_position)

func _physics_process(delta):
	if is_instance_valid(DUMMY_T):
		pass
	else:
		dummy_dead = true
	if dummy_dead == true:
		print("THE DUMMY IS DEAD")
#	if is_instance_valid(ship_array):
#		ShipSpawner("fighter", "blue", SS1.global_position)
#		ShipSpawner("fighter", "yellow", SS2.global_position)
#		ShipSpawner("fighter", "green", SS3.global_position)
#		ShipSpawner("fighter", "red", SS4.global_position)

func PlayerSpawner():
	var player = PLAYER.instance()
	add_child(player)
	player.position = PS.global_position

func ShipSpawner(type, alliance, spawn):
	var ship = SHIP.instance()
	ship.type = type
	ship.alliance = alliance
	ship.position = spawn
	add_child(ship)
