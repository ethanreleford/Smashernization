extends Node2D

var bullet: PackedScene = preload("res://scenes/abilites/auto_gun_node.tscn")
var playerInfo: CharacterBody2D
var move_speed = 100  # Speed at which the head moves toward the enemy
var fire_rate = 0.1  # Time between shots
var time_since_last_shot = 0.0
var stop_distance = 35  # Distance to maintain from the enemy

func _ready():
	$AnimatedSprite2D.play("all")

func _process(delta):
	# Look for the closest enemy
	var closest_enemy = get_closest_enemy()
	
	# If an enemy is found, move towards and shoot them
	if closest_enemy:
		moveTowardsEnemy(closest_enemy, delta)
		shootClosestEnemy(closest_enemy, delta)

# Spawns a bullet in the given direction
func spawnBullet(direction: Vector2):
	var bullet_instance = bullet.instantiate()
	bullet_instance.global_position = global_position
	bullet_instance.direction = direction
	bullet_instance.rotation = direction.angle()
	get_tree().root.add_child(bullet_instance)

# Finds the closest enemy from the list of enemies in the "Enemy" group
func get_closest_enemy() -> Area2D:
	var closest_enemy: Area2D = null
	var closest_distance = INF
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		var distance_to_enemy = playerInfo.global_position.distance_to(enemy.global_position)
		if distance_to_enemy < closest_distance:
			closest_distance = distance_to_enemy
			closest_enemy = enemy
	return closest_enemy

# Move the head towards the closest enemy, but stops at the stop_distance
func moveTowardsEnemy(closest_enemy: Area2D, delta):
	# Calculate the distance to the closest enemy
	var distance_to_enemy = global_position.distance_to(closest_enemy.global_position)
	var direction = (closest_enemy.global_position - global_position).normalized()
	# Move the head towards the enemy only if it's farther than the stop_distance
	if distance_to_enemy > stop_distance:
		global_position += direction * move_speed * delta
		
		# Calculate the target angle
	var target_angle = direction.angle()
		
		# Smoothly rotate towards the target angle
	rotation = lerp_angle(rotation, target_angle, 0.1)  # Adjust the factor for smoothness

# Shoots the closest enemy if within a certain distance
func shootClosestEnemy(closest_enemy: Area2D, delta):
	# Calculate the distance to the enemy
	var distance_to_enemy = global_position.distance_to(closest_enemy.global_position)
	
	time_since_last_shot += delta
	if time_since_last_shot >= fire_rate:
		# Shoot a bullet in the direction of the enemy
		var direction = (closest_enemy.global_position - global_position).normalized()
		spawnBullet(direction)
		time_since_last_shot = 0.0

# Sets the player info (position) for the floating eye
func _on_player_face(pos, player):
	playerInfo = player
