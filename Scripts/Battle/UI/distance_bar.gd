extends ProgressBar

var parent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	#print(parent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if TurnOrderManager.battle_has_started():
		var max_distance = Global.get_tile_width(TurnOrderManager.turn_leader.speed/10)
		var save_pos = TurnOrderManager.turn_leader_saved_position
		var current_distance = save_pos.distance_to(TurnOrderManager.turn_leader.position)
		value = 100 - ((current_distance / max_distance) * 100)
