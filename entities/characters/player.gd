class_name Player
extends CharacterBody2D

@export var ACCELERATION = 1100
@export var MAX_SPEED = 1000
@export var FRICTION = 1100

var input_vector = Vector2.ZERO


func _ready():
	pass
	
	
func _physics_process(delta):
	var target_position = get_global_mouse_position()
	var direction = (target_position - global_position).normalized()
	var movement = direction * MAX_SPEED
	#fun version of following cursor with acceleration,
	#kinda looks like a skating snowball
	velocity = velocity.move_toward(movement, ACCELERATION * delta)
	move_and_slide()
	
	#following the cursor without acceleration
	#if global_position.distance_to(target_position) > 10:
		#global_position += movement
