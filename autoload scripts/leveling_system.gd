extends Node

var level: int = 1
var xpStart : float = 0.0
var xpThreshold : float = 10.0
var xpCurrent : float = 0.0

@onready var window = get_node("/root/World/UpgradeWindow")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(window)
	isNextLevel()

func addXP(xpValue : float):
	xpCurrent += xpValue

func isNextLevel():
	if xpCurrent >= xpThreshold:
		xpThreshold = xpThreshold * (level * 1.05)
		xpCurrent = xpStart
		level += 1
		#print(level)
		window.toggleWindow()
