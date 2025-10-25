extends EntityState

func enter():
	pass
	
func exit():
	pass

func update(_delta: float):
	pass
	
func physics_update(_delta: float):
	super(_delta)
	if TurnOrderManager.battle_has_started():
		battle_walk()
		
func battle_walk():
	if not TurnOrderManager.is_turn_leader(entity_parent):
		return
	walk()
	#var save_pos = TurnOrderManager.turn_leader_saved_position
	#print(save_pos.distance_to(TurnOrderManager.turn_leader.position)))
	
	var start_position = TurnOrderManager.turn_leader_saved_position
	var offset = entity_parent.position - start_position
	var max_distance = (entity_parent.speed/10)*16
	if offset.length() > max_distance:
		entity_parent.position = start_position + offset.limit_length(max_distance)
		
func walk():
		pass


		entity_parent.move_and_slide()
