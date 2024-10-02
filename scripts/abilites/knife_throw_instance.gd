extends Node2D

var projectile: PackedScene = preload("res://scenes/abilites/knife_throw_node.tscn")
var canShoot = true
var direction: Vector2
var level : int = 0
var cooldown: float = 0.2
var playerInfo : CharacterBody2D
var spawn : bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn = false
	if spawn == true:
		fireProjectile()

func fireProjectile():
	if canShoot:
		canShoot = false
		
		var offsets = [
			Vector2(0, 0), 
			Vector2(11, 11), 
			Vector2(-11, -11), 
			Vector2(7, 7)
		]
		
		for offset in offsets:
			var projectile_instance = projectile.instantiate()
			projectile_instance.global_position = global_position + (offset * fixKnifeTrajectory(direction))
			projectile_instance.rotation += direction.angle()
			projectile_instance.direction = direction
			get_tree().root.add_child(projectile_instance)
			
			await get_tree().create_timer(0.05).timeout  # Delay between projectiles

		await get_tree().create_timer(cooldown).timeout  # Final cooldown
		canShoot = true


func fixKnifeTrajectory(givenDirection: Vector2) -> Vector2:
	#print(givenDirection)
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
	playerInfo = player
