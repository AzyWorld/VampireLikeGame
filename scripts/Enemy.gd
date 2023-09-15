extends KinematicBody2D

var vel = Vector2()
var speed = 50

var hp = 1
onready var max_hp = hp

var on_scr
var timer = 5

func _process(delta):
	if $Chort1.animation != "death":
		vel = (Gl.getPlPos() - position).normalized()*speed
		vel = move_and_slide(vel)
		$Chort1.flip_h = vel.x <= 0
		if hp <= 0:
			$Timer.start()
			$Chort1.animation = "death"
			get_parent().get_node("Player").mana += 1
		elif hp < max_hp*0.7:
			$Chort1.animation = "ran"
			
		if !$VisibilityNotifier2D.is_on_screen():
			timer -= delta
		elif timer <= 0:
			timer = 5
			position = Gl.genPosOutsideScreen(2, 2) + Gl.getPlPos()

func _on_damage_timer_timeout():
	for i in $DamageArea.get_overlapping_bodies():
		if i.is_in_group("player"):
			i.hp -= 1*(1-i.protecting/100)
			hp -= max_hp * i.damage_return/100
			break

func _on_Timer_timeout():
	queue_free()
