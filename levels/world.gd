class_name World
extends Node2D

signal game_completed

var current_level_id = "1"

@onready var snow_fall_shader_color_rect: ColorRect = $SnowFallShaderColorRect


func _ready():
	load_level("1")
	GameEvents.level_completed.connect(on_level_completed)
	GameSettings.snow_fall_visual_fx_enabled_setting_changed \
			.connect(on_snow_fall_visual_fx_enabled_setting_changed)


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
		load_level("5")
	elif event.is_action_pressed("load_level_6"):
		load_level("6")
		pass
	elif event.is_action_pressed("load_level_7"):
		load_level("7")
		pass
	elif event.is_action_pressed("load_level_8"):
		load_level("8")
		pass
	elif event.is_action_pressed("load_level_9"):
		load_level("9")
		pass
		

func load_level(level_id: String):
	var level_scene = load("res://levels/" + "level" + level_id + ".tscn")
	if level_scene == null:
		print("new level scene can not be loaded")
		game_completed.emit()
		return
	var old_level = get_tree().get_first_node_in_group("level")
	if old_level != null:
		old_level.queue_free()
	var new_level = level_scene.instantiate()
	call_deferred("add_child", new_level)
	call_deferred("move_child", new_level, 0)
	current_level_id = level_id


func on_level_completed():
	load_level(str(current_level_id.to_int() + 1))


func on_snow_fall_visual_fx_enabled_setting_changed(toggled_on: bool) -> void:
	if toggled_on:
		snow_fall_shader_color_rect.show()
	else:
		snow_fall_shader_color_rect.hide()
