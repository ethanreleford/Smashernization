extends Node2D

var tornado : PackedScene = preload("res://scenes/abilites/tornado_node.tscn")
var canSpawn = true
var direction: Vector2 = Vector2(-1,-1)
var playerInfo : CharacterBody2D
var rng = RandomNumberGenerator.new()

var angle : float = 0.0
var radius : float = 50.0  
var speed : float = 200.0
var spawn : bool = true
var itemLevel : int = 1

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn = false
	if spawn == true:
		spawnTornado(delta, 2)


func spawnTornado(delta, num_instances: int):
	if canSpawn:
		canSpawn = false
		
		for i in range(num_instances):
			calculatePosition(delta)  # Update position before each spawn
			
			var tornado_instance = tornado.instantiate()
			tornado_instance.global_position = global_position
			tornado_instance.angle = angle
			tornado_instance.radius = radius
			
			get_tree().root.add_child(tornado_instance)
			
		await get_tree().create_timer(2.5).timeout
		canSpawn = true



func calculatePosition(delta):
	angle = rng.randf_range(0, 360.0)
	radius = rng.randf_range(0, 100.0)
	angle += delta * speed
	position = Vector2(
	cos(angle) * radius,
	sin(angle) * radius
	) + Vector2.ZERO  # Center of the circular path, adjust if needed

func _on_player_face(pos, player):
	direction = pos
	playerInfo = player
