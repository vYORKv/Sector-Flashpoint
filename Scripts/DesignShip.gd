extends KinematicBody2D

onready var Polygon = $CollisionPolygon2D

func _ready():
	var poly = Polygon.get_polygon() # Will need to use polygon array to set shapes for each ship on spawn
	print("Design  ", poly)
