class_name Player extends CharacterBody2D

#siganls
signal  died

#node refrence caching
@onready var _health_label: Label = $HealthLabel
@onready var _coin_label: Label = $CoinLabel
@onready var _shoot_timer = $ShootTimer
@onready var _camera_position: Node2D = $CameraPosition

#Variable declaration
@export var shoot_distance: float = 400
@export var projectile_scene: PackedScene = preload("res://parts/projectile/projectile.tscn")
@export var max_speed: float = 500
@export var acceleration: float = 2500
@export var deacceleration: float = 1500

var speed: float = 0
var steer_vector: Vector2 = Vector2.ZERO
var multiplayer_id: int = 0

const MAX_HEALTH: int = 10

@export_range(0, MAX_HEALTH) var health: int = 10:
	get:
		return health
	set(new_value): #you can not type hint
		var new_health = clamp(new_value, 0, MAX_HEALTH)
		if health > 0 and new_health == 0:
			died.emit()
			set_physics_process(false)
			_shoot_timer.stop
		health = new_health
		update_health_label()

@export var number_of_coins: int = 0:
	get:
		return number_of_coins
	set(new_value):
		number_of_coins = new_value
		update_coin_label()


#functions

#called once the object enters a tree, it gets called before _ready
func _enter_tree(): 
	set_multiplayer_authority(multiplayer_id)

func add_health_points(difference: int):
	health += difference #this will call the health set
	#keep it whithin range 0 and 10
	#health = clamp(health, 0, MAX_HEALTH)
	#update_health_label()

func update_health_label():
	if not is_instance_valid(_health_label):
		return
	_health_label.text = str(health) + "/" + str(MAX_HEALTH)

func update_coin_label():
	if not is_instance_valid(_coin_label):
		return
	_coin_label.text = "Coins: " + str(number_of_coins)

func add_coins(value: int):
	number_of_coins = number_of_coins + value

func get_hit():
	health -= 1

#Main Functions
func _ready():
	#add_health_points(-2)
	update_health_label()
	update_coin_label()
	
	#only spawn bullets in server side
	if not multiplayer.is_server():
		_shoot_timer.stop()
	
	#if we dont own the node, queue it free & stop it
	if not is_multiplayer_authority():
		_camera_position.queue_free()
		set_physics_process(false)

func _physics_process(delta: float):
	#Input  is a singleton
	#get_vector gives an input unit vector
	var input_direction: Vector2 = Input.get_vector('move_left', "move_right", "move_up", "move_down")
	#velocity = input_direction * 100 #velocity already exist in characther body 2d (no need to declare)
	if input_direction != Vector2.ZERO:
		#velocity = velocity.move_toward(input_direction * max_speed, acc"acceleration"eleration * delta)
		#calculate steer_vector
		steer_vector = (input_direction * max_speed) - velocity
		#calculate speed
		speed = acceleration * delta
		#now add it to velocity
		velocity += steer_vector * speed * delta
	else:
		#velocity = velocity.move_toward(Vector2.ZERO, deacceleration * delta)
		#calculate steer vector
		steer_vector = Vector2.ZERO - velocity
		#calculate speed
		speed = deacceleration * delta
		#lets add it to velocity
		velocity += steer_vector * speed * delta
	#print(velocity.length())
	move_and_slide() #it multiplies velocity by delta by default



func _on_shoot_timer_timeout():
	var closest_enemy: Enemy
	var smallest_distance: float = INF
	
	var all_enemies: Array = get_tree().get_nodes_in_group("enemy")
	
	for enemy in all_enemies:
		var distance_to_enemy: float = global_position.distance_to(enemy.global_position)
		if distance_to_enemy < smallest_distance:
			closest_enemy = enemy
			smallest_distance = distance_to_enemy
		
		if not closest_enemy:
			return
		
		if smallest_distance > shoot_distance:
			return
		
		var new_projectile: Projectile = projectile_scene.instantiate()
		new_projectile.target = closest_enemy
		get_parent().add_child(new_projectile)
		new_projectile.global_position = global_position
