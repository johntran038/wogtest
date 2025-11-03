extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var hero_spawners: Node = $HeroSpawners
@onready var enemy_spawners: Node = $EnemySpawners

@onready var occupied_space: Node = $OccupiedSpace

var distance_bar_scene = preload("res://Scenes/UI/DistanceBar.tscn")

var hero_battle_positions_occupied = {}
var enemy_battle_positions_occupied = {}

var heroes = []
var enemies = []

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
			hero.position = assign_battle_position(character.battle_position, hero_spawners, hero_battle_positions_occupied)
		else:
			hero = load("res://Scenes/Entities/"+character.path+".tscn").instantiate()
			hero.position = assign_battle_position(hero.battle_position, hero_spawners, hero_battle_positions_occupied)
		hero.game_mode = "battle"
		print(hero)
		# add to heroes array
		heroes.append(hero)
		occupied_space.add_child(hero)
		
	# add to turn order
	TurnOrderManager.set_turn_order(heroes)
	set_distance_bar_to_leader()

func set_up_enemies():
	for character in GlobalTemp.enemies:
		var enemy
		if character.type == "generic":
			enemy = load("res://Scenes/Entities/Generic/Enemy.tscn").instantiate()
			# set properties
			enemy.name = character.name
			enemy.speed = character.speed
			enemy.battle_position = character.battle_position
			#enemy.position
			enemy.position = assign_battle_position(character.battle_position, enemy_spawners, enemy_battle_positions_occupied)
			print(enemy.position, character.battle_position, enemy_spawners)
		else:
			enemy = load("res://Scenes/Entities/"+character.path+".tscn").instantiate()
			enemy.position = assign_battle_position(enemy.battle_position, enemy_spawners, enemy_battle_positions_occupied)
		enemy.game_mode = "battle"
		print(enemy)
		# add to enemy array
		enemies.append(enemy)
		occupied_space.add_child(enemy)
	
func assign_battle_position(battle_position, spawners, occupied_spot):
	for spawner in spawners.get_children():
		if spawner.name.to_lower().begins_with(battle_position):
			print(occupied_spot.has(spawner.name))
			if not occupied_spot.has(spawner.name):
				occupied_spot[spawner.name] = spawner.position
				return spawner.position

################# add notif ui #################

func set_distance_bar_to_leader(old_leader = null):
	if old_leader:
		for node in old_leader.get_children():
			if node.name == "DistanceBar":
				old_leader.remove_child(node)
	
	var distance_bar = distance_bar_scene.instantiate()
	var leader = TurnOrderManager.turn_leader
	distance_bar.position = distance_bar.position - Vector2(0, 14)
	distance_bar.set_script(load("res://Scripts/Battle/UI/distance_bar.gd"))
	distance_bar.name = "DistanceBar"
	leader.add_child(distance_bar)

################# Signals #################
 
func _on_new_turn(old_leader) -> void:
	set_distance_bar_to_leader(old_leader)
	pass

func _on_button_pressed() -> void:
	TurnOrderManager.next_turn()
