extends Node


@onready var tornadoInstance = get_node("/root/World/Player/TornadoInstance")
@onready var blackHoleInstance = get_node("/root/World/Player/BlackHoleInstance")
@onready var blueShotInstance = get_node("/root/World/Player/KnifeThrowInstance")
@onready var fireAuraInstance = get_node("/root/World/Player/FireAuraInstance")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func increaseSize(sprite : AnimatedSprite2D, collision: CollisionShape2D, size : float):
	#print("increased size")
	sprite.scale = Vector2(1 + size, 1 + size)
	collision.scale = Vector2(1 + size, 1 + size)

func increaseRange(ability : Node2D, size : float):
	ability.scale = Vector2(1 + size, 1 + size)


func increaseProjectileCount(ability : Node2D):
	ability.projectileCount += 1
