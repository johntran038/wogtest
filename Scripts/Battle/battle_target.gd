extends Control

@onready var basic_1: Button = $ButtonDisplay/Basic1
@onready var basic_2: Button = $ButtonDisplay/Basic2
@onready var special_1: Button = $ButtonDisplay/Special1
@onready var special_2: Button = $ButtonDisplay/Special2
@onready var exclamation_circle: Sprite2D = $ExclamationCircle
@onready var button_display: HFlowContainer = $ButtonDisplay
@onready var button_ui_collision: CollisionShape2D = $ButtonDisplay/ButtonUIBounds/ButtonUICollision
@onready var exclamation_bounds: Area2D = $ExclamationCircle/ExclamationBounds

var parent
var battle_options = {}
var expand_ui = false

func _ready() -> void:
	parent = get_parent() as Entity
	SignalManager.enter_attack_range.connect(show_battle_option)
	SignalManager.exit_attack_range.connect(hide_battle_option)
	TurnOrderManager.connect("new_turn", _on_new_turn)
	
func _process(_delta: float) -> void:
	pass
	#button_ui_collision.shape.extents = button_display.size
	#print(button_display.size, button_ui_collision.shape.extents)

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
	exclamation_circle.show()
	
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

@warning_ignore("unused_parameter")
func _on_new_turn(old_turn_taker):
	print("NEW TURN")
	hide_button(basic_1)
	hide_button(basic_2)
	hide_button(special_1)
	hide_button(special_2)
	button_display.hide()
	expand_ui = false
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


func _on_exclamation_bounds_mouse_entered() -> void:
	pass # Replace with function body.
	print("oopsie")
	button_display.show()
	exclamation_circle.hide()
	expand_ui = true

func _on_button_ui_bounds_mouse_exited() -> void:
	pass # Replace with function body.
	if !expand_ui:
		return
	print("testtt")
	#if !basic_1.visible && !basic_2.visible && !special_1.visible && !special_2.visible:
		#return
	expand_ui = false
	button_display.hide()
	exclamation_circle.show()


func _on_exclamation_circle_pressed() -> void:
	button_display.show()
	exclamation_circle.hide()
	expand_ui = true
