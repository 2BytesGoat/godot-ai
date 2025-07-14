extends Node

var tilemap_container: TilemapContainer


func set_tilemap(new_tilemap_container):
	tilemap_container = new_tilemap_container


func get_closest_tile_global_position(global_point: Vector2) -> Vector2:
	var cell = tilemap_container.global_to_map(global_point)
	return tilemap_container.map_to_global(cell)


func get_path_to_global_position(start_global_point: Vector2, end_global_point: Vector2) -> Array:
	var from_cell = tilemap_container.global_to_map(start_global_point)
	var to_cell = tilemap_container.global_to_map(end_global_point)
	var path = tilemap_container.get_path_to_cell(from_cell, to_cell)
	var global_path = []
	for cell in path:
		global_path.append(tilemap_container.map_to_global(cell))
	return global_path
