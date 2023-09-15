extends Node


var regen = 0.0075
onready var upgrade = preload("res://scripts/spells and prefabs/Upgrade.gd")
onready var tree = [
	upgrade.new("Regeneration", "Реген", "Регенерация: +1/сек" , -5, 0, ["regen"], [0.015], 1, 4, [2,3], false, false), 
	upgrade.new("Regeneration", "Баланс", "Регенерация: +0.6/сек" , 0, 0, ["regen"], [0.01], 2, 5, [1,3], false, false),
	upgrade.new(".", "Жизни", "Жизни: +50" , 5, 0, ["max_hp"], [50], 3, 6, [1,2], false, false),
	upgrade.new("Regeneration", "Реген 2", "Регенерация: +1/сек " , -5, 1, ["regen"], [0.015], 4, 7), 
	upgrade.new(".", "Баланс", "Жизни: +50 " , 0, 1, ["max_hp"], [50], 5, 7),
	upgrade.new(".", "Жизни", "Жизни: +50" , 5, 1, ["max_hp"], [50], 6, 7),
	upgrade.new("Regeneration", "Реген 3", "Регенерация: +0.6" , 0, 2, ["regen"], [0.01], 7, 0, [], false, true, true)
]
func _process(_delta):
	get_parent().hp += regen
