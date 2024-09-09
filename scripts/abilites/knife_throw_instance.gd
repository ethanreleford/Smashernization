extends CharacterBody2D

var speed: float = 200.0
var direction: Vector2 = Vector2.ZERO
@onready var player = get_parent().get_node("Player")



func _process(delta):
	print(player)
	# Move in the initial direction
	position += direction * speed * delta


func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.queue_free()
		queue_free()
	else:
		await get_tree().create_timer(10).timeout
		queue_free()
