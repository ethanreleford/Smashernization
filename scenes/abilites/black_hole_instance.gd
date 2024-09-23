extends Node2D

var blackHole : PackedScene = preload("res://scenes/abilites/black_hole_node.tscn")
var canSpawn = true
var playerInfo : CharacterBody2D
var spawn : bool = true


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn = false
	if spawn == true:
		spawnBlackHole()


func spawnBlackHole():
	if canSpawn:
		canSpawn = false
		var black_hole_instance = blackHole.instantiate()
		black_hole_instance.global_position = global_position
		get_tree().root.add_child(black_hole_instance)
		await get_tree().create_timer(5).timeout
		canSpawn = true


func _on_player_face(pos, player):
	playerInfo = player
