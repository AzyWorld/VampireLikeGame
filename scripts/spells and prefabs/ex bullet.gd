extends Node2D

var speed = 0.005
var damage = 1
var lifetime

var end = false

func _process(_delta):
	$Damage_area.scale.x += speed
	$Damage_area.scale.y += speed
	if end:
		$Damage_area/Zone.modulate.a8 -= 6
		if $Damage_area/Zone.modulate.a8 < 0:
			queue_free()
func _ready():
	$lifetime.wait_time = lifetime
	$lifetime.start()

func _on_Damage_area_body_entered(body):
	if body.is_in_group("enemy"):
		body.hp -= damage


func _on_lifetime_timeout():
	end = true
