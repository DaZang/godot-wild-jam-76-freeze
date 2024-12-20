extends Control

@onready var frames_per_second_label = %FramesPerSecondLabel


func _on_timer_timeout():
	frames_per_second_label.text = str(Engine.get_frames_per_second())
