extends Node2D

var aura :  PackedScene = preload("res://fire_aura_node.tscn")
var playerInfo : CharacterBody2D
var canSpawn : bool = true

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawnAura()

func spawnAura():
	if canSpawn:
		print("spawned")
		canSpawn = false
		var aura_instance = aura.instantiate()
		aura_instance.global_position = playerInfo.global_position
		add_child(aura_instance)
		aura_instance.despawn()
		await get_tree().create_timer(0.5).timeout
		var aura_instance1 = aura.instantiate()
		aura_instance1.global_position = playerInfo.global_position
		add_child(aura_instance1)
		aura_instance1.despawn()
		await get_tree().create_timer(0.5).timeout
		var aura_instance2 = aura.instantiate()
		aura_instance2.global_position = playerInfo.global_position
		add_child(aura_instance2)
		aura_instance2.despawn()
		await get_tree().create_timer(10).timeout
		canSpawn = true
		#aura_instance.despawn()

func _on_player_face(pos: Vector2, player: CharacterBody2D) -> void:
	print(player.global_position)
	playerInfo = player
