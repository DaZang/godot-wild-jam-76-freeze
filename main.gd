extends Node2D

const level_scene = preload("res://levels/level1/level1.tscn")


func _ready():
	var level = level_scene.instantiate()
	add_child(level)
