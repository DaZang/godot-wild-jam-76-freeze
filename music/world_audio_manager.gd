extends Node

enum Direction {
	UP,
	DOWN
}

const DAMPEN_MUSIC_TRANSITION_INTERVAL = 0.45

var music_bus_index: int
var sfx_bus_index: int
var full_music_volume_db: float
var full_sfx_volume_db: float
var current_noise_level: int


func _ready() -> void:
	music_bus_index = AudioServer.get_bus_index("Music")
	sfx_bus_index = AudioServer.get_bus_index("SFX")
	full_music_volume_db = AudioServer.get_bus_volume_db(music_bus_index)
	full_sfx_volume_db = AudioServer.get_bus_volume_db(sfx_bus_index)
	GameSettings.music_level_setting_changed.connect(on_music_level_setting_changed)
	GameSettings.sfx_level_setting_changed.connect(on_sfx_level_setting_changed)
	GameEvents.noise_level_changed.connect(on_noise_level_changed)
	
	
func on_music_level_setting_changed(value: float) -> void:
	full_music_volume_db = linear_to_db(value)
	set_audio_based_on_current_noise_level()
	
func on_sfx_level_setting_changed(value: float) -> void:
	full_sfx_volume_db = linear_to_db(value)
	set_audio_based_on_current_noise_level()
	
	
func on_noise_level_changed(noise_level: int) -> void:
	current_noise_level = noise_level
	set_audio_based_on_current_noise_level()
	

func set_audio_based_on_current_noise_level() -> void:
	set_music_based_on_current_noise_level()
	set_sfx_based_on_current_noise_level()
	
	
func set_music_based_on_current_noise_level() -> void:
	var music_bus_effects_count = AudioServer.get_bus_effect_count(music_bus_index)
	if current_noise_level < 50:
		fade_volume(music_bus_index, Direction.DOWN)
		fade_filter_frequency(music_bus_index, music_bus_effects_count, Direction.DOWN)
		#toggle_eq10(music_bus_index, music_bus_effects_count, true)
	else:
		fade_volume(music_bus_index, Direction.UP)
		fade_filter_frequency(music_bus_index, music_bus_effects_count, Direction.UP)
		#toggle_eq10(music_bus_index, music_bus_effects_count, false)


func set_sfx_based_on_current_noise_level() -> void:
	AudioServer.set_bus_volume_db(sfx_bus_index, full_sfx_volume_db)


func toggle_eq10(bus_index: int, music_bus_effects_count: int, enabled : bool) -> void: 
	for effect_index in music_bus_effects_count:
		var audio_effect = AudioServer.get_bus_effect(bus_index, effect_index) as AudioEffect
		if audio_effect is AudioEffectEQ10:
			AudioServer.set_bus_effect_enabled(bus_index, effect_index, enabled)


func fade_volume(bus_index: int, direction: Direction) -> void:
	var fade_volume_tween = create_tween()
	if direction == Direction.UP:
		fade_volume_tween.tween_method(set_volume.bind(bus_index), \
				AudioServer.get_bus_volume_db(bus_index), full_music_volume_db, \
				DAMPEN_MUSIC_TRANSITION_INTERVAL) 
	if direction == Direction.DOWN:
		fade_volume_tween.tween_method(set_volume.bind(bus_index), \
				AudioServer.get_bus_volume_db(bus_index), full_music_volume_db - 6.5, \
				DAMPEN_MUSIC_TRANSITION_INTERVAL)
		
		
func set_volume(new_volume_db: float, bus_index: int) -> void:
	AudioServer.set_bus_volume_db(bus_index, new_volume_db)


func fade_filter_frequency(bus_index: int, music_bus_effects_count: int, direction: Direction) -> void:
	var fade_filter_frequency_tween = create_tween()
	for effect_index in music_bus_effects_count:
		var audio_effect = AudioServer.get_bus_effect(bus_index, effect_index) as AudioEffect
		if audio_effect is AudioEffectFilter:
			if direction == Direction.UP:
				fade_filter_frequency_tween.tween_property(audio_effect, "cutoff_hz", 20000, \
				DAMPEN_MUSIC_TRANSITION_INTERVAL)
			if direction == Direction.DOWN:
				fade_filter_frequency_tween.tween_property(audio_effect, "cutoff_hz", 1000, \
				DAMPEN_MUSIC_TRANSITION_INTERVAL)
