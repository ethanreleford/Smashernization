extends Node2D

var bullet : PackedScene = preload("res://scenes/abilites/auto_gun_node.tscn")
var canSpawn : bool = true
var playerInfo : CharacterBody2D
var spawn : bool = true


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#spawn = false
	if spawn == true:
		spawnBullet()


func spawnBullet():
	if canSpawn:
		canSpawn = false
		var bullet_instance = bullet.instantiate()
		bullet_instance.global_position = global_position
		get_tree().root.add_child(bullet_instance)
		await get_tree().create_timer(0.25).timeout
		canSpawn = true


func _on_player_face(pos, player):
	playerInfo = player
