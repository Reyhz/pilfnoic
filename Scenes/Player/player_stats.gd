extends Node


var player = preload("res://Scenes/Player/player.tscn")
var coins = 0: get = get_coins, set = set_coins

# Only used as statistics for now
var coinflips = 0
var heads = 0
var tails = 0

func get_player():
	return player.instantiate()


func get_coins():
	return coins


func set_coins(amount):
	coins = amount

# Return a boolean, Heads = true / Tails = false
func coinflip():
	coinflips += 1
	var face = false
	
	if randi_range(0,1) == 1:
		face = true
		heads += 1
	else: 
		tails += 1
	
	return face
