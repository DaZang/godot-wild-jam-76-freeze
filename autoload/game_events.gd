extends Node

signal noise_level_changed(noise_level: int)
signal player_speed_changed(speed: float, delta: float)

# custom emit functions for autocompletion of parameters
func emit_noise_level_changed(noise_level: int):
	noise_level_changed.emit(noise_level)

func emit_player_speed_changed(speed: float, delta: float):
	player_speed_changed.emit(speed, delta)
