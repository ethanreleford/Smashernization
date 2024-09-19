extends Node2D

var aura :  PackedScene = preload("res://scenes/abilites/fire_aura_node.tscn")
var playerInfo : CharacterBody2D
var canSpawn : bool = true
var spawn : bool = true
var itemLevel : int = 2
var projectileCount = 1

@onready var upgrade_vars = get_node("/root/UpgradeAbilites")

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#spawn = false
	if spawn == true:
		spawnAura(projectileCount)

#playerInfo.global_position
func spawnAura(num_instances: int):
	if canSpawn:
		print("spawned")
		canSpawn = false
		await upgrade_vars.increaseProjectileCount(self)
		#await upgrade_vars.increaseRange(self, 1)
		for i in range(num_instances):
			var aura_instance = aura.instantiate()
			aura_instance.global_position = global_position
			var angle = (i * 360.0) / num_instances  # Evenly spaced angles
			aura_instance.angle = deg_to_rad(angle)  # Convert degrees to radians
			add_child(aura_instance)
			aura_instance.despawn()

		await get_tree().create_timer(10).timeout
		canSpawn = true



func _on_player_face(pos: Vector2, player: CharacterBody2D) -> void:
	#print(player.global_position)
	playerInfo = player
