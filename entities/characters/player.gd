class_name Player
extends CharacterBody2D

@export var ACCELERATION = 200
@export var MAX_SPEED = 2
@export var MAX_ACCELERATION_VECTOR_LENGTH = 40
@export var FRICTION = 50

var input_vector = Vector2.ZERO


func _ready():
	pass
	
	
func _physics_process(delta):
	#var target_position = get_global_mouse_position()
	#var direction = (target_position - global_position).normalized()
	#var movement = direction * MAX_SPEED
#
	#velocity = velocity.move_toward(movement, ACCELERATION * delta)
	if Input.is_action_pressed("left_mouse_button"):
		var acceleration_vector = get_global_mouse_position() - position
		if acceleration_vector.length() < 20:
			acceleration_vector = Vector2.ZERO
		var capped_acceleration_multiplier = min(acceleration_vector.length(), MAX_ACCELERATION_VECTOR_LENGTH) \
			/ MAX_ACCELERATION_VECTOR_LENGTH
		acceleration_vector = acceleration_vector * capped_acceleration_multiplier
		velocity = velocity.move_toward(acceleration_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()
