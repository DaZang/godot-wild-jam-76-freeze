class_name PlayerCrashCollider
extends Area2D

signal collided

var collided_water_hole_areas: Array[Area2D]
var collided_bridge_blocks_areas: Array[Area2D]


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("water_hole"):
		collided_water_hole_areas.append(area)
		if collided_bridge_blocks_areas.is_empty():
			collided.emit()
	if area.is_in_group("bridge"):
		collided_bridge_blocks_areas.append(area)


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("water_hole"):
		var found_index = collided_water_hole_areas.find(area)
		if found_index != -1:
			collided_water_hole_areas.remove_at(found_index)
	if area.is_in_group("bridge"):
		var found_index = collided_bridge_blocks_areas.find(area)
		if found_index != -1:
			collided_bridge_blocks_areas.remove_at(found_index)
		if collided_bridge_blocks_areas.is_empty() and not collided_water_hole_areas.is_empty():
			collided.emit()
