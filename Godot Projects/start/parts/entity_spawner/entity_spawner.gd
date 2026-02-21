extends Node2D

@export var entity_scene: PackedScene
@export var spawn_interval: float = 1.5
@export var start_interval: float = 1.5
@export var end_interval: float = 0.6
@export var time_delta: float = 0.2

var _current_spawn_interval: float = 0

@onready var _positions: Node2D = $Positions
@onready var _spawn_timer: Timer = $SpawnTimer

#Ready fuction
func _ready():
	start_timer()
	_current_spawn_interval = start_interval

func spawn_entity():
	var random_position: Marker2D = _positions.get_children().pick_random()
	var new_entity: Node2D = entity_scene.instantiate()
	new_entity.position = random_position.position
	add_child(new_entity)

#Timer Functions
func start_timer():
	_spawn_timer.start(_current_spawn_interval)

func stop_timer():
	_spawn_timer.stop()

#Signals
func _on_spawn_timer_timeout():
	spawn_entity()
	_current_spawn_interval = clamp(_current_spawn_interval - time_delta, end_interval, start_interval)
	print('current spawn interval: ' + str(_current_spawn_interval))
