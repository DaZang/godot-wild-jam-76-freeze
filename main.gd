extends Node2D

const level_1_scene = preload("res://levels/level1/level1.tscn")


func _ready():
	var level = level_1_scene.instantiate()
	add_child(level)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("load_level_1"):
		load_level("1")
	elif event.is_action_pressed("load_level_2"):
		load_level("2")
	elif event.is_action_pressed("load_level_3"):
		pass


func load_level(level_id: String):
	print("load level " + level_id)
	var level_scene = load("res://levels/level" + level_id + "/level" + level_id + ".tscn")
	var old_level = get_tree().get_first_node_in_group("level")
	old_level.queue_free()
	var new_level = level_scene.instantiate()
	add_child(new_level)
