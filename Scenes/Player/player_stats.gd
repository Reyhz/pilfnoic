extends Node


var player = preload("res://Scenes/Player/player.tscn")
var coins = 0: get = get_coins, set = set_coins


func get_player():
	return player.instantiate()


func get_coins():
	return coins


func set_coins(amount):
	coins = amount
