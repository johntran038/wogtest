extends AnimationComponent
class_name AnimatedBattleNotif

@export_group("Mouse Pressed Settings")
@export var pressed_time: float = 0.1
@export var pressed_transition: Tween.TransitionType
@export var pressed_easing: Tween.EaseType
@export var pressed_position: Vector2
@export var pressed_scale: Vector2 = Vector2(1, 1)
@export var pressed_rotation: float
@export var pressed_size: Vector2
@export var pressed_self_modulate: Color = Color.WHITE
@export var pressed_modulate: Color = Color.WHITE

@onready var battle_options: VBoxContainer = $"../../BattleOptions"

var pressed_values: Dictionary

signal pressed
signal reset_pressed

func _ready() -> void:
	super()
	call_deferred("setup")
	call_deferred("connect_signals")
	
func setup():
	super()
	var resized = Vector2(target.size.x/2, battle_options.size.y)
	var moved_position = Vector2(target.size.x/2, 0) +target.position + -battle_options.size + Vector2(0, target.size.y)
	pressed_values = {
		"scale": pressed_scale,
		"position": moved_position,
		"rotation": target.rotation + deg_to_rad(pressed_rotation),
		"size": resized,
		"self_modulate": pressed_self_modulate,
		"modulate": pressed_modulate,
	}
	

func connect_signals():
	pressed.connect(add_tween.bind(
			parallel_animations,
			pressed_values,
			pressed_time,
			pressed_transition,
			pressed_easing,
		)
	)
	
	reset_pressed.connect(add_tween.bind(
			parallel_animations,
			default_values,
			pressed_time,
			pressed_transition,
			pressed_easing,
		)
	)
