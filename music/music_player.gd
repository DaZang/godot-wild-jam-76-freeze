extends AudioStreamPlayer

enum Direction {
	UP,
	DOWN
}

var initial_music_volume_db: float

const DAMPEN_MUSIC_TRANSITION_INTERVAL = 0.45


func _ready() -> void:
	initial_music_volume_db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	GameEvents.noise_level_changed.connect(on_noise_level_changed)
	
	
func on_noise_level_changed(noise_level: int) -> void:
	var music_bus_index = AudioServer.get_bus_index("Music")
	var music_bus_effects_count = AudioServer.get_bus_effect_count(music_bus_index)
	if noise_level < 50:
		slide_volume(music_bus_index, Direction.DOWN)
		slide_filter(music_bus_index, music_bus_effects_count, Direction.DOWN)
		#toggle_eq10(music_bus_index, music_bus_effects_count, true)
	else:
		slide_volume(music_bus_index, Direction.UP)
		slide_filter(music_bus_index, music_bus_effects_count, Direction.UP)
		#toggle_eq10(music_bus_index, music_bus_effects_count, false)


func toggle_eq10(bus_index: int, music_bus_effects_count: int, enabled : bool) -> void: 
	for effect_index in music_bus_effects_count:
		var audio_effect = AudioServer.get_bus_effect(bus_index, effect_index) as AudioEffect
		if audio_effect is AudioEffectEQ10:
			AudioServer.set_bus_effect_enabled(bus_index, effect_index, enabled)


func slide_volume(bus_index: int, direction: Direction) -> void:
	var slide_volume_tween = create_tween()
	if direction == Direction.UP:
		slide_volume_tween.tween_method(set_volume.bind(bus_index), \
				AudioServer.get_bus_volume_db(bus_index), initial_music_volume_db, \
				DAMPEN_MUSIC_TRANSITION_INTERVAL) 
	if direction == Direction.DOWN:
		slide_volume_tween.tween_method(set_volume.bind(bus_index), \
				AudioServer.get_bus_volume_db(bus_index), initial_music_volume_db - 5.0, \
				DAMPEN_MUSIC_TRANSITION_INTERVAL)
		
		
func set_volume(new_volume_db: float, bus_index: int) -> void:
	AudioServer.set_bus_volume_db(bus_index, new_volume_db)


func slide_filter(bus_index: int, music_bus_effects_count: int, direction: Direction) -> void:
	var slide_filter_tween = create_tween()
	for effect_index in music_bus_effects_count:
		var audio_effect = AudioServer.get_bus_effect(bus_index, effect_index) as AudioEffect
		if audio_effect is AudioEffectFilter:
			if direction == Direction.UP:
				slide_filter_tween.tween_property(audio_effect, "cutoff_hz", 20000, \
				DAMPEN_MUSIC_TRANSITION_INTERVAL)
			if direction == Direction.DOWN:
				slide_filter_tween.tween_property(audio_effect, "cutoff_hz", 2000, \
				DAMPEN_MUSIC_TRANSITION_INTERVAL)
