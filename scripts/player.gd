extends CharacterBody2D

var speed : int = 100
var health : int = 1000
var level: int = 1
var xpStart : float = 0.0
var xpThreshold : float = 10.0
var xpCurrent : float = 0.0

var character = CharacterBody2D
var pos: Vector2 = Vector2.RIGHT

signal face(pos: Vector2, player: CharacterBody2D)

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
	isNextLevel()

func movement(delta):
	var movement_vector = Vector2.ZERO
	# Check for movement input
	if Input.is_action_pressed("Move Right"):
		movement_vector.x += 1
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk")
	elif Input.is_action_pressed("Move Left"):
		movement_vector.x -= 1
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk")
	if Input.is_action_pressed("Move Up"):
		movement_vector.y -= 1
		$AnimatedSprite2D.play("walk")
	elif Input.is_action_pressed("Move Down"):
		movement_vector.y += 1
		$AnimatedSprite2D.play("walk")

	# Normalize the movement vector to prevent speed boost on diagonals
	if movement_vector != Vector2.ZERO:
		$AnimatedSprite2D.offset.y = -16
		movement_vector = movement_vector.normalized() * speed * delta
		position += movement_vector
		emit_signal("face", movement_vector.normalized(), self)
		pos = movement_vector.normalized()
	else:
		emit_signal("face", pos, self)
		$AnimatedSprite2D.offset.y = 0
		$AnimatedSprite2D.play("idle")

func addXP(xpValue : float):
	xpCurrent += xpValue

func isNextLevel():
	if xpCurrent >= xpThreshold:
		xpThreshold = xpThreshold * (level * 1.05)
		xpCurrent = xpStart
		level += 1
