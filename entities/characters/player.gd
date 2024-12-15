class_name Player
extends CharacterBody2D

const START_POSITION = Vector2(25, 294)

@export var ACCELERATION = 200
const MAX_SPEED = 300
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
		if acceleration_vector.length() > MAX_ACCELERATION_VECTOR_LENGTH:
			acceleration_vector = acceleration_vector.normalized() * MAX_ACCELERATION_VECTOR_LENGTH
		var normalized_acceleration_vector = acceleration_vector.normalized()
		velocity = velocity.move_toward(normalized_acceleration_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		GameEvents.emit_noise_level_changed(16)
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	GameEvents.emit_player_speed_changed(velocity.length())
	move_and_slide()


func on_collided():
	global_position = START_POSITION
	velocity = Vector2.ZERO
