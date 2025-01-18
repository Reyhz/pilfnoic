extends Area2D

var heads = 0:
	get:
		return heads
var tails = 0:
	get:
		return tails
var type = null:
	get:
		return type

# Called when the node enters the scene tree for the first time.
func _ready():
	heads = randi_range(-2,4)
	tails = randi_range(1,2)
	type = get_child(0).get_name()
