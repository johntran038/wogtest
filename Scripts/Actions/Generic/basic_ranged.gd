extends Attack

var display_name = "Basic Ranged"
var id_name = "basic_ranged"
var battle_type = "basic"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	range = get_range_by_tile(4)
	area_of_attack.radius = range
	collision_shape_2d.shape = area_of_attack

#Remember to change Dummy to Enemy
func _on_body_entered(body: Node2D) -> void:
	if body is Dummy:
		print("can range attack on ", body)
	SignalManager.enter_attack_range.emit(
		{
			"id_name": id_name,
			"display_name": display_name,
			"battle_type": battle_type,
			"action_type": action_type,
			"action": "attack",
			"target": body,
			"dmg": dmg,
		}
	)

func _on_body_exited(body: Node2D) -> void:
	if body is Enemy:
		print("left reach of ranged attack on ", body)
	SignalManager.exit_attack_range.emit(
		{
			"id_name": id_name,
			"battle_type": battle_type,
			"target": body
		}
	)

func _on_new_turn(old_turn_leader):
	if TurnOrderManager.turn_leader != parent:
		return
	var bodies = super(old_turn_leader)
	for body in bodies:
		if body is Enemy:
			_on_body_entered(body)
