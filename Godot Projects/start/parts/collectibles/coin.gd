extends Collectible

#Variable declaration
@export var value: int = 1

#we only espect Player node to trigger this signal
func _on_area_2d_body_entered(body):
	body.add_coins(value)
	queue_free()
