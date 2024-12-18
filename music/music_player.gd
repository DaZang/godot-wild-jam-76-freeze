extends AudioStreamPlayer


func _ready() -> void:
	GameEvents.noise_level_changed.connect(on_noise_level_changed)
	
	
func on_noise_level_changed(noise_level: int) -> void:
	var music_bus_index = AudioServer.get_bus_index("Music")
	var music_bus_effects_count = AudioServer.get_bus_effect_count(music_bus_index)
	if noise_level < 50:
		#var dampen_music_tween = create_tween()
		#dampen_music_tween.
		toggle_eq10(music_bus_index, music_bus_effects_count, true)
	else:
		pass
		toggle_eq10(music_bus_index, music_bus_effects_count, false)


func toggle_eq10(music_bus_index: int, music_bus_effects_count: int, enabled : bool) -> void: 
	for effect_index in music_bus_effects_count:
		var audio_effect = AudioServer.get_bus_effect(music_bus_index, effect_index) as AudioEffect
		if audio_effect is AudioEffectEQ10:
			AudioServer.set_bus_effect_enabled(music_bus_index, effect_index, enabled)
