extends Node

onready var upgrade = preload("res://scripts/spells and prefabs/Upgrade.gd")
onready var tree = [
	upgrade.new(".", "Защита", "Получаемый урон: -10%", 0, 0, ["protecting"], [10], 1, 2, [], false, false),
	upgrade.new(".", "Тяжелые Доспехи", "Получаемый урон: -10%\nСкорость: -25%", -6, 1, ["protecting", "speed_mod"], [10, -0.25], 2, 3, [2]),
	upgrade.new(".", "Колючая Броня", "Получаемый урон: -5%\nВозвращение урона: +10%", 0, 1, ["protecting", "damage_return"], [5, 10], 2, 4, [2]),
	upgrade.new(".", "Святая Защита", "Получаемый урон: -5%\nСкорость: +10%", 6, 1, ["protecting", "speed_mod"], [5, 0.1], 2, 5, [2]),
	upgrade.new(".", "Шлем", "Получаемый урон: -10%", -6, 2, ["protecting"], [10], 3, 6),
	upgrade.new(".", "Колючки 1", "Получаемый урон: -5%\nВозвращение урона: +20%", 0, 2, ["protecting", "damage_return"], [5, 20], 4, 7),
	upgrade.new(".", "Ускорение", "Скорость: +20%", 6, 2, ["speed_mod"], [0.2], 5, 8),
	upgrade.new(".", "Нагрудник", "Получаемый урон: -20%", -6, 3, ["protecting"], [20], 6, 0, [], false, true, true),
	upgrade.new(".", "Колючки 2", "Получаемый урон: -5%\nВозвращение урона: +20% ", 0, 3, ["protecting", "damage_return"], [5, 20], 7, 0, [], false, true, true),
	upgrade.new(".", "Щит", "Получаемый урон: -20% ", 6, 3, ["protecting"], [20], 8, 0, [], false, true, true)
]
