extends RigidBody2D

var speed: float = 200.0
var direction: Vector2 = Vector2.ZERO
var damage: int = 100

@onready var global_vars = get_node("/root/Global")


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		await global_vars.takeDamage(area.get_parent(), damage)


func _on_search_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		direction = (area.global_position - global_position).normalized()
