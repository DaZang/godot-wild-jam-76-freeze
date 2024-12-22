class_name GlidingState
extends State

var player : Player

@onready var glide_audio_stream_player_2d: AudioStreamPlayer2D = %GlideAudioStreamPlayer2D
@onready var temperature_sinking_timer: Timer = $TemperatureSinkingTimer


func enter():
	player = get_parent().entity as Player
	glide_audio_stream_player_2d.play()
	GameEvents.emit_noise_level_changed(16)
	temperature_sinking_timer.start()


func exit():
	glide_audio_stream_player_2d.stop()
	temperature_sinking_timer.stop()


func physics_update(delta):
	glide_audio_stream_player_2d.volume_db = \
			min( -60 + sqrt(player.velocity.length()) * 4.5 + player.glide_default_volume_db, \
			player.glide_default_volume_db)
	if Input.is_action_pressed("left_mouse_button"):
		transitioned.emit("RunningState")
		return
	player.velocity = player.velocity.move_toward(Vector2.ZERO, player.friction * delta)
	GameEvents.emit_player_speed_changed(player.velocity.length(), player.max_speed, delta)
	player.move_and_slide()
	


func _on_temperature_sinking_timer_timeout() -> void:
	if player.temperature >= 1.0:
		player.temperature -= 1.0
		GameEvents.emit_temperature_changed(player.temperature)
