extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var hero_spawners: Node = $HeroSpawners

@onready var occupied_space: Node = $OccupiedSpace

var battle_positions_occupied = {}

var heroes = []

func _ready() -> void:
	camera_2d.make_current()
	set_up_heros()
	set_up_enemies()
	TurnOrderManager.connect("new_turn", _on_new_turn)
	TurnOrderManager.start_battle()
	
################# battle set up #################
func set_up_heros():
	for character in GlobalTemp.heroes:
		var hero
		if character.type == "generic":
			hero = load("res://Scenes/Entities/Generic/Hero.tscn").instantiate()
			# set properties
			hero.name = character.name
			hero.speed = character.speed
			hero.battle_position = character.battle_position
			hero.position = assign_battle_position(character.battle_position, hero_spawners)
		else:
			hero = load("res://Scenes/Entities/"+character.path+".tscn").instantiate()
			hero.position = assign_battle_position(hero.battle_position, hero_spawners)
		hero.game_mode = "battle"
		print(hero)
		# add to heroes array
		heroes.append(hero)
		occupied_space.add_child(hero)
		
	# add to turn order
	TurnOrderManager.set_turn_order(heroes)
	set_distance_bar_to_leader()
	
func assign_battle_position(battle_position, spawners):
	for spawner in spawners.get_children():
		if spawner.name.to_lower().begins_with(battle_position):
			if not battle_positions_occupied.has(spawner.name):
				battle_positions_occupied[spawner.name] = spawner.position
				return spawner.position

################# add notif ui #################

func set_distance_bar_to_leader(old_leader = null):
	if old_leader:
		for node in old_leader.get_children():
			if node.name == "DistanceBar":
				old_leader.remove_child(node)
	
	var bar = preload("res://Scenes/UI/DistanceBar.tscn").instantiate()
	var leader = TurnOrderManager.turn_leader
	bar.position = bar.position - Vector2(0, 14)
	bar.set_script(load("res://Scripts/Battle/UI/distance_bar.gd"))
	bar.name = "DistanceBar"
	leader.add_child(bar)

func set_up_enemies():
	pass
	

################# Signals #################
 
func _on_new_turn(old_leader) -> void:
	set_distance_bar_to_leader(old_leader)
	pass

func _on_button_pressed() -> void:
	TurnOrderManager.next_turn()
