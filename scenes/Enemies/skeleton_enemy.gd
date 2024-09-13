extends CharacterBody2D


var coin: PackedScene = preload("res://scenes/items/xp.tscn")

var speed : int = 10
var health : int = 150
var is_dead: bool = false


@onready var player = get_parent().get_parent().get_node("Player")


func _ready():
	$AnimatedSprite2D.play("run")

func _physics_process(delta):
	if is_dead == false:
		follow_Player(delta)



func follow_Player(delta):
	var playerPosition = (player.global_position - global_position).normalized()
	position +=  playerPosition * delta * speed
	move_and_collide(Vector2.ZERO + (velocity*speed))
	if playerPosition.x < 0 :
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func takeDamage(damage: int):
	health -= damage
	if health <= 0:
		$AnimatedSprite2D.modulate = Color.RED
		await get_tree().create_timer(0.05).timeout
		$AnimatedSprite2D.modulate = Color.WHITE
		death()
	else:
		$AnimatedSprite2D.modulate = Color.RED
		await get_tree().create_timer(0.05).timeout
		$AnimatedSprite2D.modulate = Color.WHITE


func death():
	is_dead = true
	$Area2D/ProjectileCollision.call_deferred("set_disabled", true)
	$PlayerCollision.call_deferred("set_disabled", true)
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(0.7).timeout
	dropCoin()
	queue_free() 

func dropCoin():
	var coin_instance = coin.instantiate()
	coin_instance.global_position = global_position
	coin_instance.global_position.y += 15
	get_tree().root.add_child(coin_instance)
	
