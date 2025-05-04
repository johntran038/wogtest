extends State
class_name EntityState

var entity_parent: Entity

func enter():
	pass
	
func exit():
	pass

func update(_delta: float):
	pass
	
func physics_update(_delta: float):
	if not entity_parent:
		entity_parent = parent as Entity
	pass
