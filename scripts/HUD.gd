extends CanvasLayer

onready var upBut = preload("res://scenes/prefabs/UpgradeButton.tscn").instance()
onready var player = get_parent().get_node("Player")

var choicen_spell
var spells_for_up = []
var a
var b = []
var time = 0

var stopDrag = false

var limitleft = -9999
var limittop = -9999
var limitright = 9999
var limitbottom = 9999

onready var line = preload("res://scenes/prefabs/Line2D.tscn")

const spells = {"Fire":preload("res://scenes/spells/Fire.tscn"), "Pentagramm":preload("res://scenes/spells/Pentagramm.tscn"), 
"Cross":preload("res://scenes/spells/Cross.tscn"), "Heal":preload("res://scenes/spells/Heal.tscn"), 
"Regeneration":preload("res://scenes/spells/Regeneration.tscn"), "Armor":preload("res://scenes/spells/Armor.tscn"), "Starfall":preload("res://scenes/spells/Starfall.tscn")}

func _input(event):
	if event is InputEventScreenTouch:
		if !$Joystick.persistent:
			$Joystick.start_pos = event.position
			$Joystick.persistent = true
		else:
			$Joystick.persistent = false
	if event is InputEventScreenDrag:
		if stopDrag:
			for i in $Upgrading.get_children():
				if i.is_in_group("ub"):
					i.rect_position.x += event.relative.x
					i.rect_position.y += event.relative.y
				if i.is_in_group("line"):
					i.position += event.relative
		stopDrag = true

var motion = Vector2()

func _process(_delta):
	motion = $Joystick.get_value()
	$HP_Label.text = str(int(player.hp))
	$Time.text = str(int(time/60)) + ":" + str(time%60)
	$Joystick.visible = !$Upgrading.visible
	for i in $Upgrading.get_children():
		if i.is_in_group("ub"):
			i.visible = !((i.rect_position.y+i.rect_size.y/2) > ($Upgrading/Description.rect_position.y - $Upgrading/Description.rect_size.y/2))
			if $Upgrading/upgrade.pressed and (i.descr == $Upgrading/Description.text):
				$Upgrading.visible = false
				i.obj.comp = true
				get_tree().paused = false
				for k in i.param:
					if i.obj.parent != "Player":
						player.get_node(i.obj.parent).set(k, player.get_node(i.obj.parent).get(k)+i.upgrade[i.param.find(k)])
					else:
						player.set(k, player.get(k) + i.upgrade[i.param.find(k)])
				for k in i.obj.exc:
					for j in choicen_spell:
						if j.number == k:
							j.closed = true
				for k in $Upgrading.get_children():
					if k.is_in_group("ub") or k.is_in_group("delete"):
						k.queue_free()
				$Upgrading/Description.visible = false
				$Upgrading/upgrade.visible = false
				$Upgrading/Description.text = ""
			elif i.pressed:
				$Upgrading/Description.text = i.descr
		elif i.is_in_group("cb"):
			if i.pressed:
				if player.get_node_or_null(i.hint_tooltip) != null:
					choicen_spell = player.get_node(i.hint_tooltip).tree
					$Upgrading/Description.visible = true
					$Upgrading/upgrade.visible = true
					upgrade2()
				else:
					player.add_child(spells[i.hint_tooltip].instance())
					$Upgrading.visible = false
					$Upgrading/upgrade.visible = false
					get_tree().paused = false
				for k in $Upgrading.get_children():
					if k.is_in_group("cb"):
						k.queue_free()

func upgrading():
	get_tree().paused = true
	$Upgrading.visible = true
	for i in Gl.can_upgrade:
		if player.has_node(i):
			for k in player.get_node(i).tree:
				if k.end == true and k.comp == true:
					Gl.can_upgrade.remove(Gl.can_upgrade.find(i))
	if len(Gl.can_upgrade) > 3:
		spells_for_up.append(Gl.can_upgrade[Gl.randrange(0, len(Gl.can_upgrade)-1)])
		a = Gl.can_upgrade[Gl.randrange(0, len(Gl.can_upgrade)-1)]
		while a in spells_for_up:
			a = Gl.can_upgrade[Gl.randrange(0, len(Gl.can_upgrade)-1)]
		spells_for_up.append(a)
		while a in spells_for_up:
			a = Gl.can_upgrade[Gl.randrange(0, len(Gl.can_upgrade)-1)]
		spells_for_up.append(a)
	elif len(Gl.can_upgrade) == 0:
		get_tree().paused = false
		$Upgrading.visible = false
		for i in $Upgrading.get_children():
			i.queue_free()
	else:
		for i in Gl.can_upgrade:
			spells_for_up.append(i)
	if len(Gl.can_upgrade) != 0:
		for i in spells_for_up:
			var btn = preload("res://scenes/prefabs/Choice Button.tscn").instance()
			btn.hint_tooltip = i
			btn.text = Gl.names[i]
			btn.rect_position = Vector2(OS.get_window_size().x/2, OS.get_window_size().y/4+OS.get_window_size().y/4*(spells_for_up.find(i)))
			$Upgrading.add_child(btn)
			btn.rect_position.x -= btn.rect_size.x/2
	spells_for_up = []
func upgrade2():
	for i in choicen_spell:
		upBut = preload("res://scenes/prefabs/UpgradeButton.tscn").instance()
		upBut.text = i.SpName
		upBut.rect_position = Vector2(i.x*30 + OS.get_window_size().x/2 - upBut.rect_size.x/2, i.y*120 + 50)
		for k in choicen_spell:
			if (k.number == i.next) and i.comp:
				k.closed = false
		for k in choicen_spell:
			for j in k.exc:
				if (j == i.number) and k.comp:
					i.closed = true
		upBut.disabled = i.comp or i.closed
		upBut.param = i.param
		upBut.upgrade = i.upgrade
		upBut.obj = i
		upBut.descr = i.descr
		upBut.next = i.next
		upBut.cur = i.number
		$Upgrading.add_child(upBut)
	for i in get_tree().get_nodes_in_group("ub"):
		for k in get_tree().get_nodes_in_group("ub"):
			if k.cur == i.next:
				line = preload("res://scenes/prefabs/Line2D.tscn").instance()
				line.points = [i.rect_position+i.rect_size/2, k.rect_position+k.rect_size/2]
				line.add_to_group("delete")
				$Upgrading.add_child(line)


func _on_Timer_timeout():
	time += 1


func _on_upgrade_pressed():
	pass # Replace with function body.



