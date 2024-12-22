extends Node

signal music_level_setting_changed
signal sfx_level_setting_changed
signal game_speed_setting_changed
signal snow_fall_visual_fx_enabled_setting_changed

var game_speed_setting: float:
	set(value):
		game_speed_setting = value
		game_speed_setting_changed.emit(value)
		
var snow_fall_visual_fx_enabled_setting: bool:
	set(value):
		snow_fall_visual_fx_enabled_setting = value
		snow_fall_visual_fx_enabled_setting_changed.emit(value)
		
var music_level_setting: float:
	set(value):
		music_level_setting = value
		music_level_setting_changed.emit(value)
		
var sfx_level_setting: float:
	set(value):
		sfx_level_setting = value
		sfx_level_setting_changed.emit(value)
		


func _ready():
	var music_bus_index = AudioServer.get_bus_index("Music")
	music_level_setting = db_to_linear(AudioServer.get_bus_volume_db(music_bus_index))
	var sfx_bus_index = AudioServer.get_bus_index("SFX")
	sfx_level_setting = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_index))
	game_speed_setting = Engine.time_scale
	snow_fall_visual_fx_enabled_setting = true
