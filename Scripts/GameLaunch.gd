extends Node

const DUMMY = preload("res://Scenes/Actors/Dummy.tscn")

func _ready():
	var dummy = DUMMY.instance()
	add_child(dummy)
