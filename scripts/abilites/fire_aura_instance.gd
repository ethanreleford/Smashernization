extends Node2D

var aura: PackedScene = preload("res://scenes/abilites/fire_aura_node.tscn")
var playerInfo: CharacterBody2D
var canSpawn: bool = true
var spawn: bool = true
var itemLevel: int = 2
var projectileCount: int = 1
var timer: Timer

func _ready():
	timer = Timer.new()
	timer.wait_time = 10.0  # Set the wait time to 10 seconds
	timer.one_shot = true    # Make it a one-shot timer
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)         # Add the timer as a child

func _process(delta: float) -> void:
	if spawn == true:
		spawnAura(projectileCount)

func spawnAura(num_instances: int):
	if canSpawn:
		#print("spawned")
		canSpawn = false
		for i in range(num_instances):
			var aura_instance = aura.instantiate()
			aura_instance.global_position = global_position
			var angle = (i * 360.0) / num_instances  # Evenly spaced angles
			aura_instance.angle = deg_to_rad(angle)  # Convert degrees to radians
			add_child(aura_instance)
			aura_instance.despawn() # aura despaw function await 10 seconds before free
		timer.start()  # Start the timer

func _on_timer_timeout() -> void:
	canSpawn = true

func reset():
	for _i in self.get_children():
		if _i.is_in_group("fireaura"):
			_i.queue_free()
	canSpawn = true
	timer.start()

func _on_player_face(pos: Vector2, player: CharacterBody2D) -> void:
	playerInfo = player
