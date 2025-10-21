extends CharacterBody2D
class_name Entity

var temp_var = {}

var hp = 100

func adjust_health(amount):
	hp = hp + amount
	
func set_health(amount):
	hp = amount
