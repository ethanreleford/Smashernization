extends Node

var coin: PackedScene = preload("res://scenes/items/xp.tscn")

func _ready():
	pass

func takeDamage(enemy: CharacterBody2D, damage: int):
	enemy.health -= damage
	#print(enemy.health)
	# Check if the enemy is dead
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
	enemy.is_dead = true
	enemy.get_node("Area2D/ProjectileCollision").call_deferred("set_disabled", true)
	enemy.get_node("PlayerCollision").call_deferred("set_disabled", true)
	enemy.get_node("Model").play("death")
	await get_tree().create_timer(0.7).timeout

	if enemy != null:
		# Store the position before the enemy is freed
		var enemy_position = enemy.global_position
		#print(enemy_position)
		# Drop the coin before freeing the enemy
		drop_coin(enemy_position)  # Pass the position, not the enemy itself
		enemy.queue_free()
	else:
		print("null")

func drop_coin(position: Vector2):
	var coin_instance = coin.instantiate()
	coin_instance.global_position = position  # Use the stored position
	coin_instance.global_position.y += 15
	get_tree().root.add_child(coin_instance)
