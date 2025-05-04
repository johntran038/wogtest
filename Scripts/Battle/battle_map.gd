extends TileMapLayer
class_name BattleMap

# convert tile vector to global vector
#converts tile coordinates to global mouse position
func get_global_vector(vector):
	return to_global(map_to_local(vector))

#converts global mouse position to tile coordinates
func get_tile_vector(vector):
	return local_to_map(to_local(vector))
