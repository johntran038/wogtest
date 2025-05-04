extends AnimationComponent
class_name AnimatedBattleOptions

@export_group("Option Open Settings")
@export var open_time: float = 0.1
@export var open_transition: Tween.TransitionType
@export var open_easing: Tween.EaseType
@export var open_position: Vector2
@export var open_scale: Vector2 = Vector2(1, 1)
@export var open_rotation: float
@export var open_size: Vector2
@export var open_self_modulate: Color = Color.WHITE
@export var open_modulate: Color = Color.WHITE

signal open
signal close

var open_values: Dictionary
var moved_position

func _ready() -> void:
	super()
	call_deferred("setup")
	call_deferred("connect_signals")
	
func setup():
	super()
	
	open_values = {
		"scale": open_scale,
		"position": target.position + open_position,
		"rotation": target.rotation + deg_to_rad(open_rotation),
		"size": target.size + open_size,
		"self_modulate": open_self_modulate,
		"modulate": open_modulate,
	}
	

func connect_signals():
	open.connect(add_tween.bind(
			parallel_animations,
			open_values,
			open_time,
			open_transition,
			open_easing,
		)
	)
	close.connect(add_tween.bind(
			parallel_animations,
			default_values,
			open_time,
			open_transition,
			open_easing
		)
	)
