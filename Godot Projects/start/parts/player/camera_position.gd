extends Node2D

#variable declaration
@export var camera_distance: float = 200
@onready var _player: CharacterBody2D = get_parent()
@export var position_interpolation_speed: float = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_direction: Vector2 = _player.velocity.normalized()
	var target_position: Vector2 = move_direction * camera_distance
	#interpolate between the player position and camera position
	#delta smoothens the movement and makes it fps independent
	position = position.lerp(target_position, position_interpolation_speed * delta)
	
