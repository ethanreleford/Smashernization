extends CharacterBody2D


var speed : int = 50


@onready var  player = get_parent().get_node("Player")


func _physics_process(delta):
	follow_Player(delta)
	


func follow_Player(delta):
	var playerPosition = (player.global_position - global_position).normalized()
	position +=  playerPosition * delta * speed
	move_and_collide(Vector2.ZERO + (velocity*speed))
	$AnimatedSprite2D.play("run")
	if playerPosition.x < 0 :
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
