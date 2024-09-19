extends RigidBody2D

var size: float = 1.0
var damage: int = 50
var affected_enemies = []  # To track enemies inside the black hole's range
var pull_strength: float = 50.0  # Adjust this for a stronger or weaker pull
var pull_decay: float = 1.0 # The closer the enemy, the slower they move
@onready var global_vars = get_node("/root/Global")
var canDealDamage : bool = true

func _ready():
	$AnimatedSprite2D.play("default")


func _process(delta):
	despawn()
	rotation+= 0.01
	for enemy in affected_enemies:
		pullEnemy(enemy, delta)
	blackHoleDamage()

func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		#print("added enemy")
		affected_enemies.append(area.get_parent())  # Add the enemy to the list of affected enemies

func _on_area_2d_area_exited(area):
	# Remove enemy from affected list when it leaves the area
	if area.is_in_group("Enemy"):
		affected_enemies.erase(area.get_parent())
		#print("enemy left")

func blackHoleDamage():
	if canDealDamage == true:
		canDealDamage = false

		for enemy in affected_enemies:
			if enemy == null:
				affected_enemies.erase(enemy)
				#print("enemy died")
			else:
				#print("health:")
				#print(enemy.health)
				await global_vars.takeDamage(enemy, damage)
				#print(enemy.health)
		await get_tree().create_timer(1).timeout
		canDealDamage = true

func pullEnemy(enemy: CharacterBody2D, delta: float):
	# Direction towards the black hole's center (this node's position)
	var direction: Vector2 = ((Vector2(0,-25)+position) - enemy.position).normalized()
	#print(direction)
	# Apply gradual pull force toward the center
	var pull_force: Vector2 = direction * pull_strength * delta
	#print(pull_force)
	# Reduce enemy's speed as they get closer to the center (optional)
	enemy.velocity = enemy.velocity.lerp(Vector2.ZERO, pull_decay)

	# Apply the pull force to the enemy
	enemy.position += pull_force
	
func despawn():
	await get_tree().create_timer(6).timeout
	queue_free()
