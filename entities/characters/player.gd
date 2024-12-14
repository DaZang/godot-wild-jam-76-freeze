class_name Player
extends CharacterBody2D

@export var ACCELERATION = 1100
@export var MAX_SPEED = 1000
@export var FRICTION = 1100

var input_vector = Vector2.ZERO


func _ready():
	pass
	
	
func _physics_process(delta):
	var vect = get_global_mouse_position() - position
	velocity = velocity.move_toward(vect * MAX_SPEED, ACCELERATION * delta)
