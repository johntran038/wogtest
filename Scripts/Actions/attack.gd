extends Node
class_name Attack

signal entered_range
signal exited_range

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var parent: CharacterBody2D
var range = get_range_by_tile(1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent().get_parent()
	collision_shape_2d.shape.radius = range

func get_range_by_tile(tiles):
	return Global.get_tile_width(tiles+1)-8
