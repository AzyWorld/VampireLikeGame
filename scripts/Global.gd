extends Node

var r = RandomNumberGenerator.new()

var can_upgrade = ["Cross", "Pentagramm", "Fire", "Heal", "Regeneration", "Armor", "Starfall"]
var names = {"Cross":"Крестик", "Pentagramm":"Пентаграмма", "Fire":"Огонь", "Heal":"Лечение", "Regeneration":"Регенерация", "Armor":"Броня", "Starfall":"Звездопад"}

func getPlPos():
	return get_parent().get_node("Main/Player").position

func randrange(a, b):
	r.randomize()
	return r.randi_range(a, b)
	
func randfrange(a, b):
	r.randomize()
	return r.randf_range(a, b)

func genPosOutsideScreen(a, b):
	var x = randrange(-a,a)+0.0001
	var y = randrange(-b, b)+0.000001
	return Vector2(x+OS.window_size.x*(x/abs(x)), y+OS.window_size.y*(y/abs(y)))
