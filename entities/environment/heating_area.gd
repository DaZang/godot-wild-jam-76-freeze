extends Area2D

var player: Player

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		timer.start()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null
		timer.stop()


func _on_timer_timeout() -> void:
	if player.temperature <= 77.0:
		player.temperature += 3.0
		GameEvents.emit_temperature_changed(player.temperature)
