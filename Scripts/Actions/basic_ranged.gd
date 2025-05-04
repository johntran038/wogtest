extends Attack

var display_name = "Basic Ranged"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	var s = CircleShape2D.new()
	range = get_range_by_tile(4)
	s.radius = range
	collision_shape_2d.shape = s

func _on_body_entered(body: Node2D) -> void:
	if body is Dummy:
		print("can range attack on ", body)
	SignalManager.enter_attack_range.emit("basic_ranged", body)

func _on_body_exited(body: Node2D) -> void:
	if body is Dummy:
		print("left reach of ranged attack on ", body)
	SignalManager.enter_attack_range.emit("basic_ranged", body)
