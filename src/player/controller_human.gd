class_name ControllerHuman
extends ControllerUnit

var commands_buffer = []

class CommandWrapper:
	var command
	var params

	func _init(_command, _params):
		command = _command
		params = _params

	func execute(unit):
		command.execute(unit, params)


func _ready() -> void:
	unit.action_done.connect(_on_action_done)


func _input(event: InputEvent) -> void:
	if event.is_action_released("mouse_right"):
		commands_buffer = []
		if unit.is_doing_action():
			unit.reset()
		
		var mouse_position = get_global_mouse_position()
		var navigation_path = TilemapService.get_path_to_global_position(unit.global_position, mouse_position)
		command_move.execute(unit, CommandMove.Params.new(navigation_path))
		
		var object = _get_object_under_mouse(mouse_position)
		if object != null:
			commands_buffer.append(CommandWrapper.new(command_pickup, CommandPickup.Params.new(object)))

	if event.is_action_pressed("ui_accept"):
		if unit.carried_item == null:
			return
		
		commands_buffer = []
		if unit.is_doing_action():
			unit.reset()
		
		var mouse_position = get_global_mouse_position()
		var target_position = TilemapService.get_closest_tile_global_position(mouse_position)
		command_attack.execute(unit, CommandAttack.Params.new(target_position))


func _get_object_under_mouse(mouse_position: Vector2):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mouse_position
	query.collide_with_areas = true
	query.collide_with_bodies = true
	query.collision_mask = 8 # This means pickable object
	
	var results = space_state.intersect_point(query, 1)
	if len(results) > 0:
		return results[0].collider.owner
	return null


func _on_action_done():
	if len(commands_buffer) > 0:
		commands_buffer.pop_front().execute(unit)
