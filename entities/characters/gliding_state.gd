class_name GlidingState
extends State

var player : Player


func enter():
	player = get_parent().entity as Player
	GameEvents.emit_noise_level_changed(16)


func exit():
	pass
	

func physics_update(delta):
	if Input.is_action_pressed("left_mouse_button"):
		transitioned.emit("RunningState")
		return
	player.velocity = player.velocity.move_toward(Vector2.ZERO, player.friction * delta)
	GameEvents.emit_player_speed_changed(player.velocity.length(), player.max_speed, delta)
	player.move_and_slide()
	
