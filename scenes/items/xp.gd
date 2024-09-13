extends RigidBody2D

var flag: bool = false
var player: CharacterBody2D
var speed: float = 100  # Speed at which XP moves towards the player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if flag:
		goTowardPlayer(delta)
		if position.distance_to(player.position) < 10:  # Adjust distance tolerance as needed
			queue_free()  # Remove XP when it's close enough to the player

func setPlayer(newPlayer: CharacterBody2D):
	player = newPlayer

func goTowardPlayer(delta: float) -> void:
	# Calculate the direction to the player
	var direction: Vector2 = (player.position - position).normalized()
	# Move the XP in the direction of the player
	speed *= 1.01
	position += direction * speed * delta

	