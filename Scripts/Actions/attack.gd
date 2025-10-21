extends Actions
class_name Attack

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var parent: CharacterBody2D
var range = get_range_by_tile(1)
var dmg = 10
var area_of_attack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	make all attacks in an "Abilities" Node2D
#   parent = this attack < abilities < parent
	parent = get_parent().get_parent()
	action_type = "attack"
	collision_shape_2d.shape.radius = range
	area_of_attack = CircleShape2D.new()

func get_range_by_tile(tiles):
	return Global.get_tile_width(tiles+1)-8
