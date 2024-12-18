extends Node

signal noise_level_changed(noise_level: int)
signal player_speed_changed(speed: float, delta: float)
signal player_pushed_by_absolute_vector(vector: Vector2)


func emit_noise_level_changed(noise_level: int):
	noise_level_changed.emit(noise_level)

func emit_player_speed_changed(speed: float, delta: float):
	player_speed_changed.emit(speed, delta)
	
func emit_player_pushed_by_absolute_vector(vector: Vector2, delta: float):
	player_pushed_by_absolute_vector.emit(vector, delta)
