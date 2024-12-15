extends Node2D

@onready var animatable_body_2d: AnimatableBody2D = %AnimatableBody2D

func _ready():
	GameEvents.player_speed_changed.connect(on_player_speed_changed)
	
	
func on_player_speed_changed(speed: float):
	animatable_body_2d.set_rotation_degrees(90 * (speed / Player.MAX_SPEED) - 45)
