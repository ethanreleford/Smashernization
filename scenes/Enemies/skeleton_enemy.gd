extends CharacterBody2D

var coin: PackedScene = preload("res://scenes/items/xp.tscn")

var speed : int = 50
var health : int = 150
var is_dead: bool = false
@onready var model = $Model

@onready var player = get_parent().get_parent().get_node("Player")


func _ready():
	
	model.play("run")

func _physics_process(delta):
	if is_dead == false:
		follow_Player(delta)


func follow_Player(delta):
	var playerPosition = (player.global_position - global_position).normalized()
	position +=  playerPosition * delta * speed
	move_and_collide(Vector2.ZERO + (velocity*speed))
	if playerPosition.x < 0 :
		model.flip_h = true
	else:
		model.flip_h = false
