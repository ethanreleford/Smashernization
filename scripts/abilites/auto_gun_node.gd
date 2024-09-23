extends Node2D

var speed: float = 200.0
var direction: Vector2 = Vector2.ZERO
var damage: int = 25
var penetration: int = 3

@onready var global_vars = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		await global_vars.takeDamage(area.get_parent(), damage)
		penetrated()
	await get_tree().create_timer(10).timeout
	queue_free()


func penetrated():
	if penetration <= 0:
		$AnimatedSprite2D2.visible = true
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled", true)
		$AnimatedSprite2D2.play("blood")
		direction = Vector2.ZERO
		await get_tree().create_timer(0.12).timeout
		queue_free()
	else:
		$AnimatedSprite2D2.visible = true
		$AnimatedSprite2D2.play("blood")
		await get_tree().create_timer(0.12).timeout
		$AnimatedSprite2D2.visible = false
		penetration -= 1
