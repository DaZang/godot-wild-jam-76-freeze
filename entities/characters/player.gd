class_name Player
extends CharacterBody2D

const START_POSITION = Vector2(25, 294)

@export var acceleration = 300
@export var max_speed = 350
@export var max_acceleration_vector_length = 40
@export var friction = 60

@onready var player_crash_collider: PlayerCrashCollider = %PlayerCrashCollider

var input_vector = Vector2.ZERO
var boarded_bridge: Node2D


func _ready():
	player_crash_collider.bridge_boarded.connect(on_bridge_boarded)
	player_crash_collider.bridge_left.connect(on_bridge_left)
	player_crash_collider.collided.connect(on_collided)
	
	
func _physics_process(delta):
	if Input.is_action_pressed("left_mouse_button"):
		GameEvents.emit_noise_level_changed(80)
		var acceleration_vector = get_global_mouse_position() - position
		if acceleration_vector.length() < 10:
			acceleration_vector = Vector2.ZERO
		if acceleration_vector.length() > max_acceleration_vector_length:
			acceleration_vector = acceleration_vector.normalized() * max_acceleration_vector_length
		var normalized_acceleration_vector = acceleration_vector.normalized()
		velocity = velocity.move_toward(normalized_acceleration_vector * max_speed, acceleration * delta)
	else:
		GameEvents.emit_noise_level_changed(16)
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	GameEvents.emit_player_speed_changed(velocity.length(), max_speed, delta)
	move_and_slide()
	
	
func on_bridge_boarded(bridge: Node2D):
	self.boarded_bridge = bridge
	bridge.player = self
	
	
func on_bridge_left():
	self.boarded_bridge.player = null
	self.boarded_bridge = null


func on_collided():
	global_position = START_POSITION
	velocity = Vector2.ZERO


func push_player(vector: Vector2, delta):
	var added_velocity = vector / delta
	print("before velocity: " + str(velocity))
	print("added velocity: " + str(added_velocity))
	velocity += added_velocity
	print("after velocity: " + str(velocity))
