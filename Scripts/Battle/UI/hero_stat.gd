extends Control


@onready var energy_bar: ProgressBar = $"Main UI Frame/HBoxContainer/VBoxContainer/MarginContainer3/EnergyBar"
const energy_point_width = 9
const gap_between_energy_points = 5
const total_points_on_sprite = 9
var gap

func _ready() -> void:
	pass
	energy_bar.max_value = energy_bar.custom_minimum_size.x
	set_energy(0)
	
	
	
func set_energy(points):
	
	var offset = 1 if points > 0 else 0
	gap = (points-offset) * gap_between_energy_points
	energy_bar.value = points * energy_point_width + gap

func get_points():
	return (energy_bar.value - gap) / energy_point_width

func _on_button_pressed() -> void:
	set_energy(get_points()+1)
