extends Attack

var display_name = "Basic Melee"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	var s = CircleShape2D.new()
	range = get_range_by_tile(1)
	s.radius = range
	collision_shape_2d.shape = s

func _on_body_entered(body: Node2D) -> void:
	if body is Dummy:
		print("can melee attack on ", body)
	SignalManager.enter_attack_range.emit("basic_melee", body)

func _on_body_exited(body: Node2D) -> void:
	if body is Dummy:
		print("left reach of melee attack on ", body)
	SignalManager.enter_attack_range.emit("basic_melee", body)
