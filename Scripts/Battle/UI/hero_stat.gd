extends Control

@onready var profile_picture: TextureRect = $"Main UI Frame/HBoxContainer/ProfilePicture"
@onready var energy_bar: ProgressBar = $"Main UI Frame/HBoxContainer/VBoxContainer/MarginContainer3/EnergyBar"
@onready var hp_bar: ProgressBar = $"Main UI Frame/HBoxContainer/VBoxContainer/MarginContainer2/HPBar"

@export var pfp: Texture2D
@export var max_hp: int = 100

@export var _hp: int = 25
@export var _energy: int

const energy_point_width = 9
const gap_between_energy_points = 5

var gap

func _ready() -> void:
	if pfp != null:
		profile_picture.texture = pfp
	hp_bar.max_value = max_hp
	hp_bar.value = _hp
	
#	sets the energy max to the length of the bar in the control node
	energy_bar.max_value = energy_bar.custom_minimum_size.x
	set_energy(0)
	
func get_hp():
	return _hp

func get_energy():
	return _energy

func set_hp(amount):
#	sets hp based on the bar
	hp_bar.value = amount
	@warning_ignore("narrowing_conversion")
	_hp = hp_bar.value

func set_energy(points):
	var offset = 1 if points > 0 else 0
	gap = (points-offset) * gap_between_energy_points
	energy_bar.value = points * energy_point_width + gap
	_energy = points
