extends Node

var heroes = [
	#preload("res://Scripts/test_hero_1.gd"),
	{"name":"hero1", "type":"manual", "path": "Hero1"},
	#{"name":"bob", "battle_position": "frontline", "speed":5},
	{"name":"jane", "type":"generic", "path": "Hero", "battle_position": "frontline", "speed":20},
	{"name":"doe", "type":"generic", "path": "Hero", "battle_position": "frontline", "speed":30},
	{"name":"joe", "type":"generic", "path": "Hero", "battle_position": "frontline", "speed":25},
]

var enemies = [
	{"name":"enemy1", "type":"generic", "battle_position": "frontline", "speed":10},
	{"name":"enemy2", "type":"generic", "battle_position": "frontline", "speed":70},
	{"name":"enemy3", "type":"generic", "battle_position": "frontline", "speed":80},
	{"name":"enemy4", "type":"generic", "battle_position": "frontline", "speed":19},
]
