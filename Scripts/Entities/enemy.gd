extends Entity
class_name Enemy

@export_enum("default", "battle") var game_mode = "default"
@onready var state_machine: StateMachine = $StateMachine

const MOVEMENT_SPEED = 120.0
var battle_position = "frontline"


var strength = 10
var speed = 1


func _ready() -> void:
	pass
	if !state_machine:
		return
	state_machine.init(self)
