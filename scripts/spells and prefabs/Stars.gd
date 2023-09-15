extends Node2D

var star
var queue = 2

onready var upgrade = preload("res://scripts/spells and prefabs/Upgrade.gd")
onready var tree = [
	upgrade.new("Stars", "Начало", "ХЗ", 0, 1, ["queue"], [3], 1, 0, [], false, false, true)
]

func _on_cd_timeout():
	for i in range(queue):
		star = preload("res://scenes/prefabs/Star.tscn").instance()
		star.position = Vector2(Gl.randrange(get_parent().position.x-OS.window_size.x/2+20, get_parent().position.x+OS.window_size.x/2-20), Gl.randrange(get_parent().position.y-OS.window_size.y/2+20, get_parent().position.y+OS.window_size.y/2-20))
		get_parent().get_parent().add_child(star)
