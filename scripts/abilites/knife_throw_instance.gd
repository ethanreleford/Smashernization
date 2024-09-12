extends Node2D

var projectile: PackedScene = preload("res://scenes/abilites/knife_throw_node.tscn")
var canShoot = true
var direction: Vector2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fireProjectile()


func fireProjectile():
	if canShoot:
		canShoot = false
		print(direction)

		# First projectile instantiation
		var projectile_instance = projectile.instantiate()
		projectile_instance.global_position = global_position
		get_tree().root.add_child(projectile_instance)
		projectile_instance.rotation += direction.angle()
		projectile_instance.direction = direction

		# Delay before firing the next projectile
		await get_tree().create_timer(0.2).timeout

		# Second projectile instantiation
		var projectile_instance1 = projectile.instantiate()
		projectile_instance1.global_position = global_position + (Vector2(10,11) * fixKnifeTrajectory(direction)) 
		get_tree().root.add_child(projectile_instance1)
		projectile_instance1.rotation += direction.angle()
		projectile_instance1.direction = direction

		await get_tree().create_timer(1).timeout
		canShoot = true

func fixKnifeTrajectory(givenDirection: Vector2) -> Vector2:
	print(givenDirection)
	if givenDirection.x > 0 and givenDirection.y > 0:
		return Vector2(1,0)
	elif givenDirection.x == 0:
		return Vector2(1, givenDirection.y)
	elif givenDirection.y == 0:
		return Vector2(givenDirection.x, 1)
	return Vector2(0,1)

func _on_player_face(pos, player):
	direction = pos
