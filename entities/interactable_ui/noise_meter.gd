extends AnimatableBody2D

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var sprite_2d: Sprite2D = %Sprite2D

var start_position: Vector2
var start_size: Vector2


func _ready():
	start_position = collision_shape_2d.position
	start_size = collision_shape_2d.shape.get_rect().size
	GameEvents.noise_level_changed.connect(on_noise_level_changed)
	
	
func on_noise_level_changed(noise_level: int):
	var new_position = Vector2(start_position.x, start_position.y - (noise_level  - 16))
	var new_size = Vector2(start_size.x, start_size.y + noise_level - 16)
	
	collision_shape_2d.position = new_position
	collision_shape_2d.shape.extents = new_size / 2
	sprite_2d.position = new_position
	sprite_2d.scale = Vector2(1, noise_level / 20)
