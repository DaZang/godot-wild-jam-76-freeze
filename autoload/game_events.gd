extends Node

signal noise_level_changed(noise_level: int)
signal temperature_changed(temperature: float)
signal player_speed_changed(speed: float, max_speed: float, delta: float)
signal level_completed()
signal game_restart_requested()

# custom emit functions for autocompletion of parameters

func emit_noise_level_changed(noise_level: int):
	noise_level_changed.emit(noise_level)


func emit_temperature_changed(temperature: float):
	temperature_changed.emit(temperature)
	

func emit_player_speed_changed(speed: float, max_speed: float, delta: float):
	player_speed_changed.emit(speed, max_speed, delta)


func emit_level_completed():
	level_completed.emit()
	

func emit_game_restart_requested():
	game_restart_requested.emit()
