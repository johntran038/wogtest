extends Control

@onready var animated_battle_notif: AnimatedBattleNotif = $Button/AnimatedBattleNotif
@onready var animated_battle_options: AnimatedBattleOptions = $BattleOptions/AnimatedBattleOptions
@onready var animated_background: AnimatedBattleOptions = $Background/AnimatedBackground
@onready var slide_battle_notif: SlideBattleNotif = $SlideBattleNotif

@onready var battle_options: VBoxContainer = $BattleOptions
@onready var button: Button = $Button
@onready var background: ColorRect = $Background

@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var opened := false
var still_animating = false

func _ready() -> void:
	setup()
	#for option in battle_options.get_children():
		#option.pressed.connect(SignalManager.option_chosen.emit.bind())
	
func setup():
	battle_options.position = Vector2(-battle_options.size.x + button.size.x, -battle_options.size.y/2)
	
	background.size = battle_options.size
	background.position = battle_options.position
	background.scale = battle_options.scale
	background.pivot_offset = battle_options.size
	background.hide()

func _on_button_pressed() -> void:
	if opened == true:
		return
	background.show()
	
	animated_battle_notif.pressed.emit()
	animated_background.open.emit()
	animated_battle_options.open.emit()
	slide_battle_notif.slide.emit()
	opened = true
	
	var collision_size = battle_options.size+Vector2(button.size.x,0)
	collision_shape_2d.shape.set_deferred("size", collision_size)
	area_2d.position = Vector2((-battle_options.size.x+button.size.x)/2,0)

func _on_animated_battle_notif_tween_completed(node, tween) -> void:
	if not opened:
		return
	var collision_size = battle_options.size+Vector2(button.size.x,0)
	collision_shape_2d.shape.set_deferred("size", collision_size)
	area_2d.position = button.position + collision_size/2
	still_animating = true

func _on_area_2d_mouse_exited() -> void:
	if not still_animating:
		return
	if not opened:
		return
	
	opened = false
	still_animating = false
	animated_battle_notif.reset_pressed.emit()
	animated_battle_options.close.emit()
	animated_background.close.emit()
	slide_battle_notif.reset_slide.emit()

	collision_shape_2d.shape.set_deferred("size", Vector2(0,0))
