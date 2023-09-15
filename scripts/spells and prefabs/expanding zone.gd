extends Node2D


var damage = 0.1
var speed = 0.12
var lifetime = 1
var cooldown = 2.2

var SpellName = "Пентаграмма"

var bullet
onready var upgrade = preload("res://scripts/spells and prefabs/Upgrade.gd")
onready var tree = [
	upgrade.new("Pentagramm", "Время действия", "Время существования: +2 секунды\nСкорость расширения: -50%", -7, 0, ["lifetime", "speed"], [2, -0.06], 1, 2, [1], false, false),
	upgrade.new("Pentagramm", "Скорость", "Скорость: +83%" , 4, 0, ["speed"], [0.1], 1, 3, [1], false, false),
	upgrade.new("Pentagramm", "Время действия", "Время существования: +2 секунды" , -7, 1, ["lifetime"], [2], 2, 4),
	upgrade.new("Pentagramm", "Перезарядка", "Перезарядка: -55%" , 4, 1, ["cooldown"], [-1.2], 3, 5),
	upgrade.new("Pentagramm", "Скорость", "Скорость: +33%" , -4, 2, ["speed"], [0.02], 4, 6),
	upgrade.new("Pentagramm", "Урон I", "Урон: +0.1" , 4, 2, ["damage"], [0.1], 5, 6),
	upgrade.new("Pentagramm", "Урон II", "Урон: +0.1" , 0, 3, ["damage"], [0.1], 6, 7),
	upgrade.new("Pentagramm", "Урон III", "Урон: +0.1" , 0, 4, ["damage"], [0.1], 7, 0, [], false, true, true)
]

func _on_Cooldown_timeout():
	$Cooldown.wait_time = cooldown
	bullet = preload("res://scenes/prefabs/ex bullet.tscn").instance()
	bullet.speed = speed
	bullet.damage = damage
	bullet.lifetime = lifetime
	get_parent().add_child(bullet)
