extends Node2D

var player: Player

func _ready():
	GameEvents.player_speed_changed.connect(on_player_speed_changed)
	
	
func on_player_speed_changed(speed: float):
	var old_rotation_degrees = rotation_degrees
	var new_rotation_degrees = 90 * (speed / Player.MAX_SPEED) - 45
	set_rotation_degrees(new_rotation_degrees)
	var rotation_difference_degrees = new_rotation_degrees - old_rotation_degrees
	var rotation_difference_radians = deg_to_rad(rotation_difference_degrees)
	
	if player != null:
		var player_distance = player.global_position - global_position
		var rotated_player_distance = Vector2(
			player_distance.x * cos(rotation_difference_radians) - player_distance.y * sin(rotation_difference_radians),
			player_distance.x * sin(rotation_difference_radians) + player_distance.y * cos(rotation_difference_radians)
		)
		player.velocity += rotated_player_distance
