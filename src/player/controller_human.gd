class_name ControllerHuman
extends ControllerUnit


func _input(event: InputEvent) -> void:
	if event.is_action_released("mouse_right"):
		var mouse_position = get_global_mouse_position()
		var target_position = TilemapService.get_closest_tile_global_position(mouse_position)
		#var navigation_path = TilemapService.get_path_to_global_position(unit.global_position, mouse_position)
		#print(navigation_path)
		command_move.execute(unit, CommandMove.Params.new(target_position))
	if event.is_action_pressed("ui_accept"):
		var mouse_position = get_global_mouse_position()
		var target_position = TilemapService.get_closest_tile_global_position(mouse_position)
		command_attack.execute(unit, CommandAttack.Params.new(target_position))
