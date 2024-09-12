extends CharacterBody2D

var speed: float = 200.0
var direction: Vector2 = Vector2.ZERO
var damage: int = 50




func _process(delta):
	position += direction * speed * delta

func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		#print(area)
		area.get_parent().takeDamage(damage)
		$Sprite2D.visible = false
		$AnimatedSprite2D2.visible = true
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled", true)
		$AnimatedSprite2D2.play("blood")
		direction = Vector2.ZERO
		await get_tree().create_timer(0.12).timeout
		queue_free()
	else:
		await get_tree().create_timer(10).timeout
		#print(area)
		queue_free()
