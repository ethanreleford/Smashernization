extends Node2D

var projectile: PackedScene = preload("res://scenes/abilites/knife_throw_node.tscn")
var canShoot = true
var direction: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fireProjectile()


func fireProjectile():
	if canShoot:
		print(direction)
		var projectile_instance = projectile.instantiate()
		projectile_instance.global_position = global_position
		get_tree().root.add_child(projectile_instance)
		projectile_instance.rotation += direction.angle() 
		print(projectile_instance.rotation)
		projectile_instance.direction = direction
		canShoot = false
		await get_tree().create_timer(1).timeout
		canShoot = true


func _on_player_face(pos, player):
	direction = pos
