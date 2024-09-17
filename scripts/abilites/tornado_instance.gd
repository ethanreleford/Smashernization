extends Node2D

var tornado : PackedScene = preload("res://scenes/abilites/tornado_node.tscn")
var canSpawn = true
var direction: Vector2 = Vector2(-1,-1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawnTornado()


func spawnTornado():
	if canSpawn:
		canSpawn = false
		var tornado_instance = tornado.instantiate()
		tornado_instance.global_position = global_position
		get_tree().root.add_child(tornado_instance)
		await get_tree().create_timer(0.25).timeout
		canSpawn = true
