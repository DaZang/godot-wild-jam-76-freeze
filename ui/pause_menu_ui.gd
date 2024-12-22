class_name PauseMenuUi
extends Control

@onready var game_speed_slider: HSlider = %GameSpeedSlider
@onready var snow_fall_visual_fx_button: CheckButton = %SnowFallVisualFxButton
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SfxSlider


func _ready() -> void:
	music_slider.value = GameSettings.music_level_setting
	sfx_slider.value = GameSettings.sfx_level_setting
	game_speed_slider.value = GameSettings.game_speed_setting
	snow_fall_visual_fx_button.set_pressed(GameSettings.snow_fall_visual_fx_enabled_setting)


func _on_game_speed_slider_value_changed(value: float) -> void:
	GameSettings.game_speed_setting = value
	

func _on_snow_fall_visual_fx_button_toggled(toggled_on: bool) -> void:
	GameSettings.snow_fall_visual_fx_enabled_setting = toggled_on
	
	
func _on_music_slider_value_changed(value: float) -> void:
	GameSettings.music_level_setting = value


func _on_sfx_slider_value_changed(value: float) -> void:
	GameSettings.sfx_level_setting = value
