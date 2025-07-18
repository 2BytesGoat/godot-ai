class_name TilemapContainer
extends Node2D

@onready var ground_layer = $GroundLayer
@onready var terrain_layer = $TerrainLayer

var astar = AStar2D.new()


func _ready() -> void:
	_init_pathfinding_terrain()
	_update_pathfinding_obstacles()


func get_path_to_cell(from_cell: Vector2i, to_cell: Vector2i) -> Array:
	var from_id = cell_to_id(from_cell)
	var to_id = cell_to_id(to_cell)
	var path = []
	if not astar.has_point(to_id):
		return path
	for cell_id in astar.get_id_path(from_id, to_id):
		path.append(id_to_cell(cell_id))
	return path 


func get_neighbour_cells(cell: Vector2i) -> Array:
	var directions = [
		Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT,
		Vector2i.UP + Vector2i.RIGHT, Vector2i.DOWN + Vector2i.RIGHT,
		Vector2i.UP + Vector2i.LEFT, Vector2i.DOWN + Vector2i.LEFT
	]
	var neighbours = []
	for direction in directions:
		var neighbour_cell = cell + direction
		var success = _add_cell_to_astar(neighbour_cell)
		if success:
			neighbours.append(neighbour_cell)
	return neighbours


func cell_to_id(cell: Vector2i) -> int:
	var ground_rect = ground_layer.get_used_rect().size
	return cell.y * ground_rect.x + cell.x


func id_to_cell(id: int) -> Vector2i:
	return astar.get_point_position(id)


func global_to_map(global_point: Vector2) -> Vector2:
	var local = ground_layer.to_local(global_point)
	return ground_layer.local_to_map(local)


func map_to_global(cell: Vector2) -> Vector2:
	var local = ground_layer.map_to_local(cell)
	return ground_layer.to_global(local)


func _init_pathfinding_terrain():
	var ground_rect = ground_layer.get_used_rect().size
	for y in range(ground_rect.y):
		for x in range(ground_rect.x):
			var cell = Vector2i(x, y)
			var cell_id = cell_to_id(cell)
			_add_cell_to_astar(cell)
			for to_cell in get_neighbour_cells(cell):
				var to_cell_id = cell_to_id(to_cell)
				astar.connect_points(cell_id, to_cell_id, false)


func _update_pathfinding_obstacles():
	for cell in terrain_layer.get_used_cells():
		var cell_id = cell_to_id(cell)
		astar.remove_point(cell_id)


func _add_cell_to_astar(cell: Vector2i) -> bool:
	var data = ground_layer.get_cell_tile_data(cell)
	if data == null:
		return false
	
	var cell_id = cell_to_id(cell)
	if astar.has_point(cell_id):
		return true
	
	astar.add_point(cell_id, cell, 1.0)
	return true
