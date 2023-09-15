extends Node


func _ready():
	get_parent().hp += 33
	queue_free()
