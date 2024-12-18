extends Node2D

var player: Player

var previous_force = Vector2.ZERO

func _ready():
	GameEvents.player_speed_changed.connect(on_player_speed_changed)
	
	
func on_player_speed_changed(speed: float, delta: float):
	var old_rotation_degrees = rotation_degrees
	var target_rotation_degrees = 90 * (speed / Player.MAX_SPEED) - 45
	var new_rotation_degrees = lerp(old_rotation_degrees, target_rotation_degrees, \
			delta) # prevent feedback loop between player speed on bridge and bridge speed
	
	set_rotation_degrees(new_rotation_degrees)
	if player != null:
		var rotation_difference_degrees = new_rotation_degrees - old_rotation_degrees
		print("rotation_difference_degrees: " + str(rotation_difference_degrees))
		var rotation_difference_radians = deg_to_rad(rotation_difference_degrees)
		print("rotation_difference_radians: " + str(rotation_difference_radians))
		var player_distance_vector = player.global_position - global_position
		print("player_distance_vector: " + str(player_distance_vector))
		var rotated_player_distance_vector = Vector2(
			player_distance_vector.x * cos(rotation_difference_radians) \
					- player_distance_vector.y * sin(rotation_difference_radians),
			player_distance_vector.x * sin(rotation_difference_radians) \
					+ player_distance_vector.y * cos(rotation_difference_radians) )
		var force = rotated_player_distance_vector - player_distance_vector
		print("force: " + str(force))
		
		var added_force = force - previous_force
		GameEvents.emit_player_pushed_by_absolute_vector(added_force, delta)
		previous_force = force
