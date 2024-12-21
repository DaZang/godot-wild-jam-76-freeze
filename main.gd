extends Node2D

@onready var frames_per_second_ui: Control = %FramesPerSecondUi
@onready var pause_menu_ui: PauseMenuUi = %PauseMenuUi
@onready var world: Node2D = %World


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if pause_menu_ui.visible:
			pause_menu_ui.hide()
			world.get_tree().paused = false
		else:
			pause_menu_ui.show()
			world.get_tree().paused = true
