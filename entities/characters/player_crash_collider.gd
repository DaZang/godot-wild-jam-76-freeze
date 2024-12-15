class_name PlayerCrashCollider
extends Area2D

signal collided


func _on_area_entered(area: Area2D) -> void:
	collided.emit()
