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
	else:
		walk()
		
func battle_walk():
	if entity_parent.game_mode == "battle":
		if not TurnOrderManager.is_turn_leader(entity_parent):
			return
		walk()
		var save_pos = TurnOrderManager.turn_leader_saved_position
		#print(save_pos.distance_to(TurnOrderManager.turn_leader.position)))
		
		var start_position = TurnOrderManager.turn_leader_saved_position
		var offset = entity_parent.position - start_position
		var max_distance = (entity_parent.speed/10)*16
		if offset.length() > max_distance:
			entity_parent.position = start_position + offset.limit_length(max_distance)
		
func walk():
		var input_vector := Vector2(
			Input.get_axis("left", "right"),
			Input.get_axis("up", "down")
		)
		# Normalize to prevent faster diagonal movement
		if input_vector != Vector2.ZERO:
			input_vector = input_vector.normalized()
			entity_parent.velocity = input_vector * entity_parent.MOVEMENT_SPEED
		else:
			entity_parent.velocity.x = move_toward(entity_parent.velocity.x, 0, entity_parent.MOVEMENT_SPEED)
			entity_parent.velocity.y = move_toward(entity_parent.velocity.y, 0, entity_parent.MOVEMENT_SPEED)


		entity_parent.move_and_slide()
