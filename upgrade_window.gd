extends Node

@onready var dictionary = get_node("/root/AbilityDictionary")
@onready var display = get_node("UpgradeWindow/GridContainer")
@onready var upgrade_vars = get_node("/root/UpgradeAbilites")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func toggleWindow():
	self.visible = not self.visible
	Engine.time_scale = not Engine.time_scale
	setUpgradeWindow()


func grabRandomAbility():
	var rng = randi_range(0, dictionary.abilities.size() - 1)
	dictionary.resetLevels()
	
	var currentAbility = dictionary.abilities[rng]
	print(currentAbility)
	var currentLevel = dictionary.ability[rng]
	var title = currentAbility[currentLevel].title
	var description = currentAbility[currentLevel].description
	return [title, description]


func setUpgradeWindow():
	var content = grabRandomAbility()
	display.get_node("option1/title").text = content[0]
	display.get_node("option1/description").text = content[1]
	
	content = grabRandomAbility()
	display.get_node("option2/title").text = content[0]
	display.get_node("option2/description").text = content[1]
	
	content = grabRandomAbility()
	display.get_node("option3/title").text = content[0]
	display.get_node("option3/description").text = content[1]
	
	content = grabRandomAbility()
	display.get_node("option4/title").text = content[0]
	display.get_node("option4/description").text = content[1]


func _on_option_1_pressed():
	await upgrade_vars.increaseProjectileCount(upgrade_vars.blackHoleInstance)
	toggleWindow()


func _on_option_2_pressed():
	await upgrade_vars.increaseProjectileCount(upgrade_vars.tornadoInstance)
	toggleWindow()


func _on_option_3_pressed():
	await upgrade_vars.increaseProjectileCount(upgrade_vars.fireAuraInstance)
	upgrade_vars.fireAuraInstance.reset()
	toggleWindow()


func _on_option_4_pressed():
	#await upgrade_vars.increaseProjectileCount(upgrade_vars.blueShot)
	toggleWindow()
