extends Control

@onready var basic_1: Button = $HFlowContainer/Basic1
@onready var basic_2: Button = $HFlowContainer/Basic2
@onready var special_1: Button = $HFlowContainer/Special1
@onready var special_2: Button = $HFlowContainer/Special2


var parent
var battle_options = {}

func _ready() -> void:
	parent = get_parent() as Entity
	SignalManager.enter_attack_range.connect(show_battle_option)
	SignalManager.exit_attack_range.connect(hide_battle_option)
	TurnOrderManager.connect("new_turn", _on_new_turn)
	
func allocate_battle_type(id_name, battle_type):
	pass
	if battle_type.begins_with("basic"):
		if !basic_1.id:
			battle_options[id_name] = basic_1
			return basic_1
		else:
			battle_options[id_name] = basic_2
			return basic_2
	if battle_type.begins_with("special"):
		if !special_1.id:
			battle_options[id_name] = special_1
			return special_1
		else:
			battle_options[id_name] = special_2
			return special_2
	
func show_battle_option(battle_info):
	if battle_info.target != parent:
		return
	var button = allocate_battle_type(battle_info.id_name, battle_info.battle_type)
	button.id = battle_info.id_name
	button.text = battle_info.display_name
	if battle_info.action_type == "attack":
		button.dmg = battle_info.dmg
	button.show()
	
func hide_battle_option(battle_info):
	if battle_info.target != parent:
		return
	if !battle_options.has(battle_info.id_name):
		return
	var button = battle_options[battle_info.id_name]
	hide_button(button)
	battle_options[battle_info.id_name] = ""
	
func hide_button(button):
	button.hide()
	button.id = ""
	
func apply_dmg(amount):
	var prev_hp = parent.hp
	parent.adjust_health(-amount)
	print(prev_hp, " - ", amount, " = ", parent.hp, "hp")

func _on_new_turn(old_turn_taker):
	print("NEW TURN")
	hide_button(basic_1)
	hide_button(basic_2)
	hide_button(special_1)
	hide_button(special_2)
	battle_options.clear()
	

#for now this assumes the action is an attack
func _on_basic_1_pressed() -> void:
	pass # Replace with function body.
	#apply_dmg()
	apply_dmg(basic_1.dmg)

func _on_basic_2_pressed() -> void:
	pass # Replace with function body.
	apply_dmg(basic_2.dmg)

func _on_special_1_pressed() -> void:
	pass # Replace with function body.
	apply_dmg(special_1.dmg)

func _on_special_2_pressed() -> void:
	pass # Replace with function body.
	apply_dmg(special_2.dmg)
