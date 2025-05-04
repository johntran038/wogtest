extends Node
class_name State

var parent: Node

func enter():
	pass
	
func exit():
	pass

func update(_delta: float) -> State:
	return null
	
func physics_update(_delta: float) -> State:
	return null

func input(_event: InputEvent) -> State:
	return null
