class_name State
extends Node

@warning_ignore("unused_signal") # used in inheriting state classes
signal transitioned(new_state_name: StringName)
 
func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	pass
 
func physics_update(_delta: float) -> void:
	pass
