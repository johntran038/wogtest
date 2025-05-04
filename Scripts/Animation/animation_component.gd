extends Node
class_name AnimationComponent

@export_group("Options")
@export var from_center: bool = true
@export var parallel_animations: bool = true
@export var properties: Array = [
	"scale",
	"position",
	"rotation",
	"size",
	"self_modulate",
	"modulate",
]

@export_group("Hover Settings")
@export var hover_time: float = 0.1
@export var hover_transition: Tween.TransitionType
@export var hover_easing: Tween.EaseType
@export var hover_position: Vector2
@export var hover_scale: Vector2 = Vector2(1, 1)
@export var hover_rotation: float
@export var hover_size: Vector2
@export var hover_self_modulate: Color = Color.WHITE
@export var hover_modulate: Color = Color.WHITE

var target: Control
var ignore: Dictionary
var default_scale: Vector2
var hover_values: Dictionary
var default_values: Dictionary

signal tween_completed

func _ready() -> void:
	target = get_parent()

func setup():
	if from_center:
		target.pivot_offset = target.size / 2
	default_scale = target.scale
	default_values = {
		"scale": target.scale,
		"position": target.position,
		"rotation": target.rotation,
		"size": target.size,
		"self_modulate" : target.self_modulate,
		"modulate": target.modulate,
	}
	hover_values = {
		"scale": hover_scale,
		"position": target.position + hover_position,
		"rotation": target.rotation + deg_to_rad(hover_rotation),
		"size": target.size + hover_size,
		"self_modulate": hover_self_modulate,
		"modulate": hover_modulate,
	}

func connect_signals():
	target.mouse_entered.connect(add_tween.bind(
			parallel_animations,
			hover_values,
			hover_time,
			hover_transition,
			hover_easing,
		)
	)
	target.mouse_exited.connect(add_tween.bind(
			parallel_animations,
			default_values,
			hover_time,
			hover_transition,
			hover_easing
		)
	)
	
func add_tween(parallel: bool, values: Dictionary, seconds: float, transition: Tween.TransitionType, easing: Tween.EaseType) -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(parallel)
	for property in properties:
		tween.tween_property(
			target,
			str(property),
			values[property],
			seconds
		).set_trans(transition).set_ease(easing)
	tween.finished.connect(_on_tween_completed.bind(tween))

func _on_tween_completed(tween):
	tween_completed.emit(self, tween)
