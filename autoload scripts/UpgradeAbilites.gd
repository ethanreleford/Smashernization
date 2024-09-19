extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func increaseSize(sprite : AnimatedSprite2D, collision: CollisionShape2D, size : float):
	print("increased size")
	sprite.scale = Vector2(1 + size, 1 + size)
	collision.scale = Vector2(1 + size, 1 + size)

func increaseRange(ability : Node2D, size : float):
	ability.scale = Vector2(1 + size, 1 + size)


func increaseProjectileCount(ability : Node2D):
	ability.projectileCount += 1
