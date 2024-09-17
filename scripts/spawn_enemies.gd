extends Node2D

var enemy = preload("res://scenes/Enemies/skeleton_enemy.tscn")
var count  = 0

func _ready():
	randomize()  # Randomizes RNG globally
	$Timer.start()  # Start a timer to spawn enemies periodically

func _on_timer_timeout():
	count +=1
	#print(count)
	spawnEnemies()

func spawnEnemies():
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	# Get the PathFollow2D node
	var path_follow = get_parent().get_node("Player/Path2D/PathFollow2D")

	# Set a random progress along the path (between 0 and 1)
	path_follow.progress = rng.randf_range(0.0, 3664)

	# Instance the enemy and set its position to the PathFollow2D position
	var instance = enemy.instantiate()
	instance.global_position = path_follow.global_position
	add_child(instance)
