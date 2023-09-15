extends Node

var x
var y
var SpName
var param
var upgrade
var comp
var closed
var parent
var number
var exc
var next 
var end
var descr

func _init(_parent, _name, _descr, _x, _y, _param, _upgrade, _number, _next, _exc=[], _comp=false, _closed=true, _end=false):
	parent = _parent
	SpName = _name
	descr = _descr
	x = _x
	y = _y
	param = _param
	upgrade = _upgrade
	comp = _comp
	number = _number
	closed = _closed
	exc = _exc
	next = _next
	end = _end
