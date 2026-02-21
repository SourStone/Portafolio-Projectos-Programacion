class_name Projectile extends Node2D

@export var speed: float = 600.0 #dont make it too slow or issues may appear!
var target: Node2D

func _physics_process(delta):
	if target:
		global_position = global_position.move_toward(target.global_position, speed * delta)
		look_at(target.global_position)


func _on_enemy_detection_area_body_entered(body):
	body.get_hit()
	queue_free()

