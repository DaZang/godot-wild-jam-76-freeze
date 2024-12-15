extends Node

signal noise_level_changed(noise_level: int)


func emit_noise_level_changed(noise_level: int):
	noise_level_changed.emit(noise_level)
