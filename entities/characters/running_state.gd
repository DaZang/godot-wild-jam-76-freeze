class_name RunningState
extends State

var player : Player


func enter():
	player = get_parent().entity as Player
	player.sound_animation_player.play("running_sound")
	print(80)
	GameEvents.emit_noise_level_changed(80)

func exit():
	player.sound_animation_player.stop()
	

func physics_update(delta):
	if not Input.is_action_pressed("left_mouse_button"):
		transitioned.emit("GlidingState")
		return
	var acceleration_vector = player.get_global_mouse_position() - player.position
	if acceleration_vector.length() < 10:
		acceleration_vector = Vector2.ZERO
	if acceleration_vector.length() > player.max_acceleration_vector_length:
		acceleration_vector = acceleration_vector.normalized() * player.max_acceleration_vector_length
	var normalized_acceleration_vector = acceleration_vector.normalized()
	player.velocity = player.velocity.move_toward( \
			normalized_acceleration_vector * player.max_speed, player.acceleration * delta)
	GameEvents.emit_player_speed_changed(player.velocity.length(), player.max_speed, delta)
	player.move_and_slide()
