extends Node

@onready var _game_over_menu: CenterContainer = $CanvasLayer/GameOverMenu
@onready var _enemy_spawner: Node2D = $EnemySpawner
@onready var _health_potion_pawner: Node2D = $HealthPotionSpawner
@onready var _time_label: Label = $CanvasLayer/TimerUI/TimeLabel
@onready var _player_multiplayer_spawner: MultiplayerSpawner = $PlayerMultiplayerSpawner
@onready var _player_start_positions: Node2D = $PlayerStartPositions

@export var player_scene: PackedScene

var _player_spawn_index: int = 0

var _time: float = 0.0:
	set(value):
		_time = value
		_time_label.text = str(floor(_time))

func _ready():
	_player_multiplayer_spawner.spawn_function = spawn_player
	
	if multiplayer.is_server():
		multiplayer.peer_connected.connect(add_player)
		add_player(1)

func _on_player_died():
	_game_over_menu.show()
	
	_enemy_spawner.stop_timer()
	_health_potion_pawner.stop_timer()
	
	set_process(false)
	HighscoreManager.set_new_highscore(_time)

func _process(delta: float):
	_time += delta

func add_player(id: int):
	_player_multiplayer_spawner.spawn(id)

func spawn_player(id: int):
	var player: Player = player_scene.instantiate()
	player.multiplayer_id = id
	player.died.connect(_on_player_died)
	
	var spawn_maker: Marker2D = _player_start_positions.get_child(_player_spawn_index)
	player.position = spawn_maker.position
	_player_spawn_index = (_player_spawn_index + 1) % _player_start_positions.get_child_count()
	return player
