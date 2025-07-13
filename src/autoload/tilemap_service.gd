extends Node

var tilemap: TileMapLayer


func set_tilemap(new_tilemap):
	tilemap = new_tilemap


func get_closest_tile_global_position(global_point: Vector2) -> Vector2:
	var local = tilemap.to_local(global_point)
	var tile  = tilemap.local_to_map(local)
	var tile_local = tilemap.map_to_local(tile)
	return tilemap.to_global(tile_local)
