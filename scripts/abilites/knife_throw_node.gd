extends Node2D

var projectile: PackedScene = preload("res://scenes/abilites/knife_throw_node.tscn")
var canShoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fireProjectile()


func fireProjectile():
	if canShoot:
		var projectile_instance = projectile.instantiate()
		projectile_instance.global_position = global_position
		get_tree().root.add_child(projectile_instance)
		canShoot = false
		await get_tree().create_timer(0.2).timeout
		canShoot = true
