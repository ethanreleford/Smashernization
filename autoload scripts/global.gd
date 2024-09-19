extends Node

var coin: PackedScene = preload("res://scenes/items/xp.tscn")
var rng = RandomNumberGenerator.new()


func _ready():
	pass

func _process(delta):
	pass

func takeDamage(enemy: CharacterBody2D, damage: int):
	if not enemy.is_dead:
		enemy.health -= damage
		if enemy.health <= 0:
			enemy.get_node("Model").modulate = Color.RED
			await get_tree().create_timer(0.05).timeout
			enemy.get_node("Model").modulate = Color.WHITE
			death(enemy)
		else:
			enemy.get_node("Model").modulate = Color.RED
			await get_tree().create_timer(0.05).timeout
			enemy.get_node("Model").modulate = Color.WHITE

func death(enemy: CharacterBody2D):
	if enemy.is_dead:
		return  # Prevent the enemy from dying multiple times

	enemy.is_dead = true
	enemy.get_node("Area2D/ProjectileCollision").call_deferred("set_disabled", true)
	enemy.get_node("PlayerCollision").call_deferred("set_disabled", true)
	enemy.get_node("Model").play("death")
	await get_tree().create_timer(0.7).timeout

	if enemy != null:
		var enemy_position = enemy.global_position
		drop_coin(enemy_position)  # Drop the coin once
		enemy.queue_free()

func drop_coin(position: Vector2):
	
	if rng.randi_range(0, 10) > 4:
		var coin_instance = coin.instantiate()
		coin_instance.global_position = position
		coin_instance.global_position.y += 15
		get_tree().root.add_child(coin_instance)
