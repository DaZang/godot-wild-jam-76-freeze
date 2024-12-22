class_name Player
extends CharacterBody2D

const START_POSITION = Vector2(25, 294)
const START_TEMPERATURE = 50.0

@export var acceleration = 300
@export var max_speed = 350
@export var max_acceleration_vector_length = 40
@export var friction = 60

@onready var player_crash_collider: PlayerCrashCollider = %PlayerCrashCollider
@onready var glide_audio_stream_player_2d: AudioStreamPlayer2D = %GlideAudioStreamPlayer2D

var glide_default_volume_db : float
var temperature: float
var sound_animation_player # is accessed in state machine before this node is ready
var input_vector = Vector2.ZERO
var boarded_bridge: Node2D


func _enter_tree():
	sound_animation_player = %SoundAnimationPlayer # is accessed in state machine before this node is ready
	temperature = START_TEMPERATURE


func _ready():
	player_crash_collider.bridge_boarded.connect(on_bridge_boarded)
	player_crash_collider.bridge_left.connect(on_bridge_left)
	player_crash_collider.collided.connect(on_collided)
	glide_default_volume_db = glide_audio_stream_player_2d.volume_db
	
	
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
	velocity += added_velocity
