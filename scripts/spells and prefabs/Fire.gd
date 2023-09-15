extends Node2D

var queue = 0
var queue_speed = 0.2
var damage = 0.3
var size_x = 3.5
var size_y = 1
var speed = 6
var lifetime = 0.6
var penetration = 0
var queue_max = 6

var SpellName = "Огонь"

var bullet
onready var upgrade = preload("res://scripts/spells and prefabs/Upgrade.gd")
onready var tree = [
	upgrade.new("Fire", "Горение", "Скорость появления: х2\nКоличество огня: х1.5" , 0, 0, ["queue_speed", "queue_max"], [-0.1, 3], 1, 2, [], false, false),
	upgrade.new("Fire", "Испепеление", "Ширина атаки увеличена" , 0, 0.8, ["size_x", "size_y"], [2.5, -0.3], 2, 3),
	upgrade.new("Fire", "Плавление", "Пробивная способность: +2" , 0, 1.6, ["penetration"], [2], 3, 4),
	upgrade.new("Fire", "Нагрев", "Время существования огня: х2" , 0, 2.4, ["lifetime"], [0.6], 4, 5),
	upgrade.new("Fire", "Температура", "Количество огня: +66%" , 0, 3.2, ["queue_max"], [6], 5, 6),
	upgrade.new("Fire", "Урон", "Урон: +0.2" , 0, 4, ["damage"], [0.2], 6, 7),
	upgrade.new("Fire", "Горение 2", "Кол-во огня: +1.5" , 0, 4.8, ["queue_max"], [1.5], 7, 8),
	upgrade.new("Fire", "Горение 3", "Кол-во огня: +1.5" , 0, 5.6, ["queue_max"], [1.5], 8, 9),
	upgrade.new("Fire", "Горение 4", "Кол-во огня: +1" , 0, 6.4, ["queue_max"], [1], 9, 0, [], false, true, true),
]

func _on_cooldown_timeout():
	$queue_cd.wait_time = queue_speed
	queue = queue_max


func _on_queue_cd_timeout():
	if queue > 0:
		queue -= 1
		bullet = preload("res://scenes/prefabs/Bullet.tscn").instance()
		look_at(Vector2(get_parent().HUD.motion.x+get_parent().position.x, -get_parent().HUD.motion.y+get_parent().position.y))
		bullet.type1 = "fire"
		bullet.direction = rotation_degrees
		bullet.speed = speed
		bullet.damage = damage
		bullet.size_x = size_x
		bullet.size_y = size_y
		bullet.lifetime = lifetime
		bullet.penetration = penetration
		bullet.position += get_parent().position
		rotation_degrees += 90
		bullet.position += Vector2(0, -speed*7).rotated(rotation)
		get_parent().get_parent().add_child(bullet)
