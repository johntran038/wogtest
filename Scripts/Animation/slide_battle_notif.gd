extends AnimationComponent
class_name SlideBattleNotif

@export_group("Option Slide Settings")
@export var slide_time: float = 0.1
@export var slide_transition: Tween.TransitionType
@export var slide_easing: Tween.EaseType
@export var slide_position: Vector2
@export var slide_scale: Vector2 = Vector2(1, 1)
@export var slide_rotation: float
@export var slide_size: Vector2
@export var slide_self_modulate: Color = Color.WHITE
@export var slide_modulate: Color = Color.WHITE

@onready var battle_options: VBoxContainer = $"../BattleOptions"


signal slide
signal reset_slide

var slide_values: Dictionary
var moved_position

func _ready() -> void:
	super()
	call_deferred("setup")
	call_deferred("connect_signals")
	
func setup():
	super()
	slide_scale = target.scale
	var moved_position = target.position + Vector2(battle_options.size.x/2*slide_scale.x, 0)
	slide_values = {
		"scale": slide_scale,
		"position": moved_position,
		"rotation": target.rotation + deg_to_rad(slide_rotation),
		"size": target.size + slide_size,
		"self_modulate": slide_self_modulate,
		"modulate": slide_modulate,
	}
	

func connect_signals():
	slide.connect(add_tween.bind(
			parallel_animations,
			slide_values,
			slide_time,
			slide_transition,
			slide_easing,
		)
	)
	
	reset_slide.connect(add_tween.bind(
			parallel_animations,
			default_values,
			slide_time,
			slide_transition,
			slide_easing,
		)
	)
