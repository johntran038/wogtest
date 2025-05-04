extends Node
class_name TurnOrder

signal new_turn

var turn_order
var turn_taken

var turn_leader
var turn_leader_saved_position
var turn

func _ready() -> void:
	init()
	
func init():
	turn_order = []
	turn_taken = []
	turn_leader = null
	turn_leader_saved_position = null
	turn = 0
	

func testprint(msg=''):
	if turn_order.size() < 1:
		return
	if msg != '':
		print(msg)
	var string: String
	for order in turn_order:
		string = string + (str(order.name) + ", speed: " + str(order.speed)+"\n")
	print(string)
	print("turn leader: ", turn_leader.name)
	print()
	
func set_turn_order(characters: Array):
	turn_order.clear()
	turn_order = characters
	turn_order.sort_custom(_sort_by_speed)
	
	turn_leader = turn_order[0]
	turn_leader_saved_position = turn_leader.position
	
func append_turn_order(characters: Array):
	for character in characters:
		turn_order.append(character)
	turn_order.sort_custom(_sort_by_speed)
	
	turn_leader = turn_order[0]
	turn_leader_saved_position = turn_leader.position
	
func _sort_by_speed(a, b):
	if a.speed > b.speed:
		return true
	return false

func next_turn():
	if turn_order.size() > 0:
		var current_turn_taker = turn_order.pop_front()
		turn_order.append(current_turn_taker)
		
		turn_taken.append(current_turn_taker)
		
		turn_leader = turn_order[0]
		turn_leader_saved_position = turn_leader.position
		turn = turn + 1
		new_turn.emit(current_turn_taker)
	else:
		print("turn order empty")
	
func get_turn_order():
	return turn_order
	
func get_turn_position_of(character):
	return turn_order.find(character)

func is_turn_leader(character):
	return turn_leader == character

func start_battle():
	if turn_leader:
		turn_leader_saved_position = turn_leader.position
		turn = 1

func end_battle():
	init()

func battle_has_started():
	return turn > 0
