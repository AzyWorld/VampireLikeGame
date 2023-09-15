extends Node2D

var bullet
var target

var speed = 10
var damage = 0.5
var size_x = 1
var size_y = 1
var penetration = 0
var cooldown = 1.5

var SpellName = "Крестик"

onready var upgrade = preload("res://scripts/spells and prefabs/Upgrade.gd")
onready var tree = [
upgrade.new("Cross", "Снаряд", "Урон: х2" , 0, 0, ["damage"], [0.5], 1, 2, [], false, false), 
upgrade.new("Cross", "Перезарядка", "Перезарядка: -33%" , -4, 1, ["cooldown"], [-0.5], 2, 4, [2]),
upgrade.new("Cross", "Пробив", "Пробивная способность: +1" , 4, 1, ["penetration"], [1], 2, 5, [2]),
upgrade.new("Cross", "Пулемет", "Перезарядка: -75%" , -4, 2, ["cooldown"], [-0.75], 4, 6),
upgrade.new("Cross", "Размер", "Пробивная способность: +1\nРазмер: х3" , 4, 2, ["size_y", "size_x", "penetration"], [3, 3, 2], 5, 6),
upgrade.new("Cross", "Урон", "Урон: +0.3" , 0, 3, ["damage"], [0.3], 6, 7, []),
upgrade.new("Cross", "Урон", "Урон: +0.3" , 0, 3.9, ["damage"], [0.3], 7, 8, []),
upgrade.new("Cross", "Урон", "Урон: +0.3" , 0, 4.8, ["damage"], [0.3], 8, 9, []),
upgrade.new("Cross", "Урон", "Урон: +0.3" , 0, 5.7, ["damage"], [0.3], 9, 0, [], false, true, true)]

func _on_Cooldown_timeout():
	$Cooldown.wait_time = cooldown
	for i in $AimZone.get_overlapping_bodies():
		if i.is_in_group("enemy"):
			if (target != null) and (sqrt((i.position.x-get_parent().position.x)*(i.position.x-get_parent().position.x) + (i.position.y-get_parent().position.y)*(i.position.y-get_parent().position.y)) < sqrt((target.position.x-get_parent().position.x)*(target.position.x-get_parent().position.x) + (target.position.y-get_parent().position.y)*(target.position.y-get_parent().position.y))):
				target = i
			elif target == null:
				target = i
	if target != null:
		bullet = preload("res://scenes/prefabs/Bullet.tscn").instance()
		look_at(target.position)
		bullet.direction = rotation_degrees
		bullet.speed = speed
		bullet.damage = damage
		bullet.size_x = size_x
		bullet.lifetime = 1
		bullet.penetration = penetration
		bullet.position += get_parent().position
		get_parent().get_parent().add_child(bullet)
	target = null
