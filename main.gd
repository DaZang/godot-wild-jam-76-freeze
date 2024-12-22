extends Node2D

@onready var frames_per_second_ui: Control = %FramesPerSecondUi
@onready var pause_menu_ui: PauseMenuUi = %PauseMenuUi
@onready var world: World = %World
@onready var hud_canvas_layer: CanvasLayer = %HudCanvasLayer

const GAME_COMPLETED_MENU_SCENE = preload("res://ui/game_completed_menu.tscn")

func _ready() -> void:
	GameSettings.game_speed_setting_changed.connect(on_game_speed_setting_changed)
	world.game_completed.connect(on_game_completed)
	GameEvents.game_restart_requested.connect(on_game_restart_requested)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if pause_menu_ui.visible:
			world.get_tree().paused = false
			pause_menu_ui.hide()
		else:
			world.get_tree().paused = true
			pause_menu_ui.show()


func on_game_speed_setting_changed(value: float) -> void:
	Engine.time_scale = value
	
	
func on_game_completed() -> void:
	var game_completed_menu =  GAME_COMPLETED_MENU_SCENE.instantiate()
	hud_canvas_layer.call_deferred("add_child", game_completed_menu)
	world.get_tree().paused = true
	
	
func on_game_restart_requested() -> void:
	world.get_tree().paused = false
	world.load_level("1")
