extends AnimatableBody2D

const BLOCK_SIZE = 16

var start_position: Vector2
var start_size: Vector2

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var sprite_2d: Sprite2D = %Sprite2D


func _ready():
	start_position = collision_shape_2d.position
	start_size = collision_shape_2d.shape.get_rect().size
	GameEvents.noise_level_changed.connect(on_noise_level_changed)
	
	
func on_noise_level_changed(noise_level: int):
	var target_position = Vector2(start_position.x, start_position.y - (noise_level/2  - BLOCK_SIZE))
	var target_size = Vector2(start_size.x, start_size.y + noise_level - BLOCK_SIZE)
	#var tween = create_tween()
	#tween.tween_property(self, "")
	
	collision_shape_2d.position = target_position
	collision_shape_2d.shape.extents = target_size / 2
	sprite_2d.position = target_position
	sprite_2d.region_rect.size = target_size
