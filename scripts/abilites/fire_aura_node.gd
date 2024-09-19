extends RigidBody2D

var angle : float = 0.0
var radius : float = 50.0  # Adjust this to set the radius of the circular path
var speed : float = 10.0 # Speed of rotation in radians per second
var damage : int = 50
@onready var global_vars = get_node("/root/Global")

func _ready():
	$AnimatedSprite2D.play("default")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	angle += delta * speed
	position = Vector2(
		cos(angle) * radius,
		sin(angle) * radius
	) + Vector2.ZERO  # Center of the circular path, adjust if needed

func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		await global_vars.takeDamage(area.get_parent(), damage)

func despawn():
	await get_tree().create_timer(9.5).timeout
	print("despawned")
	queue_free()
