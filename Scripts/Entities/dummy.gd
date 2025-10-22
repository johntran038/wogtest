extends Enemy
class_name Dummy

@onready var basic_1: Button = $BattleTarget/HFlowContainer/Basic1
@onready var basic_2: Button = $BattleTarget/HFlowContainer/Basic2
@onready var special_1: Button = $BattleTarget/HFlowContainer/Special1
@onready var special_2: Button = $BattleTarget/HFlowContainer/Special2


func adjust_health(amount):
	hp = hp + amount
	
func set_health(amount):
	hp = amount
