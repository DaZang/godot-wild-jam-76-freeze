extends Node2D

@onready var area_2d: Area2D = $Area2D


func _ready():
	area_2d.body_entered.connect(on_body_entered)
	
	
func on_body_entered(body: Node2D):
	if body is Player:
		GameEvents.emit_level_completed()
