extends Node2D

const level_1_scene = preload("res://levels/level1/level1.tscn")


func _ready():
	var level = level_1_scene.instantiate()
	add_child(level)
	var window_list = DisplayServer.get_window_list()
	if DisplayServer.get_screen_count() >= 3:
		DisplayServer.window_set_current_screen(2, window_list[0])
