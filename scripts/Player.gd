extends KinematicBody2D

export var speed = 150
var dir = Vector2()

var mana = 0.0
var max_mana = 5.0
var lvl = 0

var hp = 100.0
var max_hp = 100.0

var protecting = 0
var damage_return = 0

var speed_mod = 1

onready var HUD = get_parent().get_node("HUD")

var vel = Vector2()

func _process(_delta):
	speed = 150*speed_mod
	if Input.is_action_pressed("f4"):
		mana += max_mana/60
	if Input.is_action_pressed("f5"):
		hp += max_hp / 60
	if hp > max_hp:
		hp = max_hp
	elif hp <= 0:
		get_tree().change_scene("res://scenes/MainMenu.tscn")
	if mana >= max_mana:
		max_mana *= 1.05
		max_mana += 7.0
		max_mana = int(max_mana) + 1.0
		mana = 0.0
		lvl += 1
		HUD.upgrading()
	HUD.get_node("Mana bar").value = mana
	HUD.get_node("Mana bar").max_value = max_mana
	HUD.get_node("Hp bar").value = hp
	HUD.get_node("Hp bar").max_value = max_hp
	
	vel = Vector2(HUD.motion.x*speed, -HUD.motion.y*speed)
	
	if Input.is_action_pressed("a"):
		vel.x = -speed
	if Input.is_action_pressed("s"):
		vel.y = speed
	if Input.is_action_pressed("w"):
		vel.y = -speed
	if Input.is_action_pressed("d"):
		vel.x = speed
		
	$AnimatedSprite.flip_h = vel.x < 0
	vel = move_and_slide(vel)
