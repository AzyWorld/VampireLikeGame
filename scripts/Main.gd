extends Node2D

var enemy
var difficult = 1

var en_hp_mod = 1

var enemies_count

func _process(delta):
	difficult += delta/60

func _on_Spawner_timeout():
	enemies_count = len(get_tree().get_nodes_in_group("enemy"))
	if enemies_count < 100:
		for i in range(Gl.randrange(1, 1+int(difficult*2))):
			enemy = preload("res://scenes/Enemy.tscn").instance()
			enemy.position = Gl.genPosOutsideScreen(2, 2) + Gl.getPlPos()
			enemy.hp = (0.48 + (difficult/4 - 1) + Gl.randfrange(-0.5-difficult/4, 1+difficult/2))*en_hp_mod
			if enemy.hp < 0:
				enemy.hp = 0.1 * en_hp_mod
			enemy.speed = 60 + Gl.randrange(0, 40)
			enemy.scale = Vector2(1.5*en_hp_mod, 1.5*en_hp_mod)
			add_child(enemy)
		if Gl.randrange(0, 100) < 50:
			$Spawner.wait_time -= 0.01 * int($Spawner.wait_time > 0.02)
	else:
		en_hp_mod += 0.02
