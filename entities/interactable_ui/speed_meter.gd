extends Node2D

var player: Player

var current_velocity = Vector2.ZERO

func _ready():
	GameEvents.player_speed_changed.connect(on_player_speed_changed)
	
	
func on_player_speed_changed(speed: float):
	var old_rotation_degrees = rotation_degrees
	var new_rotation_degrees = 90 * (speed / Player.MAX_SPEED) - 45
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
		var added_velocity = rotated_player_distance_vector - player_distance_vector
		print("rotated_player_distance: " + str(added_velocity))
		player.velocity += added_velocity
