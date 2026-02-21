class_name Enemy extends CharacterBody2D


@onready var _navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

@onready var max_speed: float = 300.0
@onready var acceleration: float = 1500.0
@onready var deceleration: float = 1500.0

var target: Player

func _ready():
	#this alows us to get the player node and use it for navigation
	#by putting the player node inside a group
	var player_nodes: Array = get_tree().get_nodes_in_group("player")  #will give an array of the nodes that belong to the player group
	if not player_nodes.is_empty():
		target = player_nodes[0] 

func _physics_process(delta: float):
	
	#probando
	var player_nodes: Array = get_tree().get_nodes_in_group("player")  #will give an array of the nodes that belong to the player group
	if not player_nodes.is_empty():
		target = player_nodes[0] 
	#fin prueba
	
	#set target position for the navigation agent
	_navigation_agent_2d.target_position = target.global_position #this case is the player itself
	#do we have to move? if not, stop
	if _navigation_agent_2d.is_navigation_finished():
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	#otherwise move to the target and repeat
	else:
		var next_position: Vector2 = _navigation_agent_2d.get_next_path_position()
		var direction_to_next_position: Vector2 = global_position.direction_to(next_position)
		velocity = velocity.move_toward(direction_to_next_position * max_speed, acceleration * delta)
	move_and_slide()
   


func _on_area_2d_body_entered(body):
	#make sure is a player node
	if not body.is_in_group("player"):
		return #if not do nothing!
	#tell the node it got hit
	body.get_hit()
	#free the enemy spawn from the scene
	queue_free()

func get_hit():
	queue_free()
