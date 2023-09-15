extends Area2D

var direction = 0
var speed
var size_x = 1
var size_y = 1
var penetration = 0
var damage
var type1 = "Bullet"

var lifetime

var pr

func _ready():
	$Delete.wait_time = lifetime
	$Delete.start()
	$Sprite.texture = load("res://sprites/spells/" + type1 + ".png")

func _process(_delta):
	scale.x = size_x
	scale.y = size_y
	$Sprite.scale.y = scale.y
	rotation_degrees = direction + 90
	position += Vector2(0, -speed).rotated(rotation)
	for i in get_overlapping_bodies():
		if i.is_in_group("enemy") and pr != i:
			i.hp -= damage
			pr = i
			if penetration <= 0:
				queue_free()
			else:
				penetration -= 1


func _on_Delete_timeout():
	queue_free()
