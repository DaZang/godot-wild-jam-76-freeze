extends Node2D

const BLOCK_SIZE = 16

var start_position: Vector2
var start_size: Vector2

var new_position: Vector2
var new_size: Vector2

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var sprite_2d: Sprite2D = %Sprite2D


func _ready():
	start_position = collision_shape_2d.position
	start_size = collision_shape_2d.shape.get_rect().size
	new_position = start_position
	new_size = start_size
	GameEvents.noise_level_changed.connect(on_noise_level_changed)
	
	
func on_noise_level_changed(noise_level: int):
	var target_position = Vector2(start_position.x, start_position.y - (noise_level/2.0  - BLOCK_SIZE))
	var target_size = Vector2(start_size.x, start_size.y + noise_level - BLOCK_SIZE)
	var position_tween = create_tween()
	position_tween.tween_property(self, "new_position", target_position, 0.5).set_ease(Tween.EASE_IN_OUT)
	var size_tween = create_tween()
	size_tween.tween_property(self, "new_size", target_size, 0.5).set_ease(Tween.EASE_IN_OUT)
	
	
func _physics_process(_delta: float) -> void:
	collision_shape_2d.position = new_position
	collision_shape_2d.shape.extents = new_size / 2
	sprite_2d.position = new_position
	sprite_2d.region_rect.size = new_size
