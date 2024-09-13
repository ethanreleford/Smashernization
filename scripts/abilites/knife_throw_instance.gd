extends Node2D

var projectile: PackedScene = preload("res://scenes/abilites/knife_throw_node.tscn")
var canShoot = true
var direction: Vector2
var itemLevel: float
var cooldown: float = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fireProjectile()


func fireProjectile():
	if canShoot:
		canShoot = false
		#print(direction)

		# First projectile instantiation
		var projectile_instance = projectile.instantiate()
		projectile_instance.global_position = global_position
		get_tree().root.add_child(projectile_instance)
		projectile_instance.rotation += direction.angle()
		projectile_instance.direction = direction
		print("1")
		# Delay before firing the next projectile
		await get_tree().create_timer(0.2).timeout

		# Second projectile instantiation
		var projectile_instance1 = projectile.instantiate()
		projectile_instance1.global_position = global_position + (Vector2(11,11) * fixKnifeTrajectory(direction))
		get_tree().root.add_child(projectile_instance1)
		projectile_instance1.rotation += direction.angle()
		projectile_instance1.direction = direction
		print("2")
		await get_tree().create_timer(0.2).timeout
		
		# Second projectile instantiation
		var projectile_instance3 = projectile.instantiate()
		projectile_instance3.global_position = global_position + (Vector2(-11,-11) * fixKnifeTrajectory(direction))
		get_tree().root.add_child(projectile_instance3)
		projectile_instance3.rotation += direction.angle()
		projectile_instance3.direction = direction

		print("3")
		await get_tree().create_timer(0.2).timeout
		# fourth projectile instantiation
		var projectile_instance2 = projectile.instantiate()
		projectile_instance2.global_position = global_position + (Vector2(7,7) * fixKnifeTrajectory(direction))
		get_tree().root.add_child(projectile_instance2)
		projectile_instance2.rotation += direction.angle()
		projectile_instance2.direction = direction
		print("4")
		await get_tree().create_timer(cooldown).timeout
		decreaseCooldown()
		canShoot = true

func fixKnifeTrajectory(givenDirection: Vector2) -> Vector2:
	print(givenDirection)
	if givenDirection.x > 0 and givenDirection.y > 0:
		return Vector2(0,1)
	elif givenDirection.x > 0 and givenDirection.y < 0:
		return Vector2(0,1)
	elif givenDirection.x < 0 and givenDirection.y > 0:
		return Vector2(0,1)
	elif givenDirection.x < 0 and givenDirection.y < 0:
		return Vector2(0,1)
	elif givenDirection.x == 0:
		return Vector2(1, givenDirection.y)
	elif givenDirection.y == 0:
		return Vector2(givenDirection.x, 1)
	return Vector2(0,1)

func decreaseCooldown():
	cooldown = cooldown * .8

func _on_player_face(pos, player):
	direction = pos
