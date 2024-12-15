class_name Player
extends CharacterBody2D

const START_POSITION = Vector2(25, 294)

@export var ACCELERATION = 200
@export var MAX_SPEED = 2
@export var MAX_ACCELERATION_VECTOR_LENGTH = 40
@export var FRICTION = 50

@onready var player_crash_collider: PlayerCrashCollider = %PlayerCrashCollider

var input_vector = Vector2.ZERO


func _ready():
	player_crash_collider.collided.connect(on_collided)
	
	
func _physics_process(delta):
	if Input.is_action_pressed("left_mouse_button"):
		GameEvents.emit_noise_level_changed(80)
		var acceleration_vector = get_global_mouse_position() - position
		if acceleration_vector.length() < 10:
			acceleration_vector = Vector2.ZERO
		var capped_acceleration_multiplier = min(acceleration_vector.length(), MAX_ACCELERATION_VECTOR_LENGTH) \
			/ MAX_ACCELERATION_VECTOR_LENGTH
		acceleration_vector = acceleration_vector * capped_acceleration_multiplier
		velocity = velocity.move_toward(acceleration_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		GameEvents.emit_noise_level_changed(16)
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()


func on_collided():
	global_position = START_POSITION
	velocity = Vector2.ZERO
