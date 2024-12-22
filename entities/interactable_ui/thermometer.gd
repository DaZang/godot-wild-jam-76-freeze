extends Node2D

const BLOCK_SIZE = 16
const MOVE_UP_DURATION = 0.2
const MOVE_DOWN_DURATION = 1.0

var start_position: Vector2
var start_size: Vector2

var new_position: Vector2
var new_size: Vector2

var position_tween: Tween
var size_tween: Tween

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var sprite_2d: Sprite2D = %Sprite2D


func _ready():
	start_position = collision_shape_2d.position
	start_size = collision_shape_2d.shape.get_rect().size
	new_position = start_position
	new_size = start_size
	GameEvents.temperature_changed.connect(on_temperature_changed)
	
	
func on_temperature_changed(temperature: float):
	var move_duration: float
	var target_position = Vector2(start_position.x, start_position.y + 41.0- temperature)
	print("target_position: " + str(target_position))
	var target_size = Vector2(start_size.x, (start_size.y - temperature) / 2.0)
	print("target_size: " + str(target_size))
	if (target_position.y < new_position.y):
		move_duration = MOVE_UP_DURATION
	else:
		move_duration = MOVE_DOWN_DURATION
	if position_tween != null:
		position_tween.kill()
	position_tween = create_tween()
	position_tween.tween_property(self, "new_position", target_position, move_duration) \
			.set_ease(Tween.EASE_IN_OUT)
	if size_tween != null:
		size_tween.kill()
	size_tween = create_tween()
	size_tween.tween_property(self, "new_size", target_size, move_duration) \
			.set_ease(Tween.EASE_IN_OUT)
	
	
func _physics_process(_delta: float) -> void:
	collision_shape_2d.position = new_position
	collision_shape_2d.shape.extents = Vector2(new_size.x / 2.0, new_size.y * 2.5)
	sprite_2d.position = new_position
	sprite_2d.region_rect.size = new_size
