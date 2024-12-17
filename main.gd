extends Node2D

const level_1_scene = preload("res://levels/level1/level1.tscn")


func _ready():
	var level = level_1_scene.instantiate()
	add_child(level)
	var window_list = DisplayServer.get_window_list()
	if DisplayServer.get_screen_count() >= 3:
		DisplayServer.window_set_current_screen(2, window_list[0])


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("load_level_1"):
		load_level("1")
	elif event.is_action_pressed("load_level_2"):
		load_level("2")
	elif event.is_action_pressed("load_level_3"):
		load_level("3")
	elif event.is_action_pressed("load_level_4"):
		load_level("4")
	elif event.is_action_pressed("load_level_5"):
		#load_level("5")
		pass
	elif event.is_action_pressed("load_level_6"):
		#load_level("6")
		pass
	elif event.is_action_pressed("load_level_7"):
		#load_level("7")
		pass
	elif event.is_action_pressed("load_level_8"):
		#load_level("8")
		pass
	elif event.is_action_pressed("load_level_9"):
		#load_level("9")
		pass
		


func load_level(level_id: String):
	print("load level " + level_id)
	var level_scene = load("res://levels/level" + level_id + "/level" + level_id + ".tscn")
	var old_level = get_tree().get_first_node_in_group("level")
	old_level.queue_free()
	var new_level = level_scene.instantiate()
	add_child(new_level)
