extends Area2D


func _ready():
	$AnimationPlayer.play("fall")

func _on_AnimationPlayer_animation_finished(anim_name):
	for i in get_overlapping_bodies():
		if i.is_in_group("enemy"):
			i.hp -= 1
	queue_free()
