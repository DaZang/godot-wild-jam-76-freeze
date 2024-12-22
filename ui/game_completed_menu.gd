extends Control

func _on_restart_game_button_pressed() -> void:
	GameEvents.emit_game_restart_requested()
	queue_free()
