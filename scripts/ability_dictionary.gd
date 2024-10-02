extends Node


@onready var tornadoInstance = get_node("/root/World/Player/TornadoInstance")
@onready var blackHoleInstance = get_node("/root/World/Player/BlackHoleInstance")
@onready var blueShotInstance = get_node("/root/World/Player/KnifeThrowInstance")
@onready var fireAuraInstance = get_node("/root/World/Player/FireAuraInstance")

var ability = []



var abilities1 = [
	{
		"title": "Black Hole",
		"description": "A force not to be reckon with, this ability will suck enemies
		to the center and eliminate them with it gravitational force"
	},
	{
		"title": "Black Hole",
		"description": "A force not to be reckon with, this ability will suck enemies
		to the center and eliminate them with it gravitational force"
	},
	{
		"title": "Black Hole",
		"description": "A force not to be reckon with, this ability will suck enemies
		to the center and eliminate them with it gravitational force"
	},
	{
		"title": "Black Hole",
		"description": "A force not to be reckon with, this ability will suck enemies
		to the center and eliminate them with it gravitational force"
	},
]
var abilities2 = [
	{
		"title": "Tornado",
		"description": "A destructive force that will target enemies near it and
		eliminate them"
	},
	{
		"title": "Tornado",
		"description": "A destructive force that will target enemies near it and
		eliminate them"
	},
	{
		"title": "Tornado",
		"description": "A destructive force that will target enemies near it and
		eliminate them"
	},
	{
		"title": "Tornado",
		"description": "A destructive force that will target enemies near it and
		eliminate them"
	},
]
var abilities3 = [
	{
		"title": "Projectile",
		"description": "A reliable ability that will shoot projectiles in the direction
		you are facing"
	},
	{
		"title": "Projectile",
		"description": "A reliable ability that will shoot projectiles in the direction
		you are facing"
	},
	{
		"title": "Projectile",
		"description": "A reliable ability that will shoot projectiles in the direction
		you are facing"
	},
	{
		"title": "Projectile",
		"description": "A reliable ability that will shoot projectiles in the direction
		you are facing"
	},
]
var abilities4 = [
	{
		"title": "Fire Aura",
		"description": "A ball of protection that will hover around you and 
		eliminate any enemies it comes to contact with"

	},
	{
		"title": "Fire Aura",
		"description": "A ball of protection that will hover around you and 
		eliminate any enemies it comes to contact with"

	},
	{
		"title": "Fire Aura",
		"description": "A ball of protection that will hover around you and 
		eliminate any enemies it comes to contact with"
	},
	{
		"title": "Fire Aura",
		"description": "A ball of protection that will hover around you and 
		eliminate any enemies it comes to contact with"
	},
]
var abilities = [abilities1, abilities2, abilities3, abilities4]

func resetLevels():
	ability = [blackHoleInstance.level, tornadoInstance.level, blueShotInstance.level, fireAuraInstance.level]
