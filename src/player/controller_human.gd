class_name ControllerHuman
extends ControllerUnit


func _input(event: InputEvent) -> void:
	if event.is_action_released("mouse_right"):
		var target_position = get_global_mouse_position()
		command_move.execute(unit, CommandMove.Params.new(target_position))
	if event.is_action_pressed("ui_accept"):
		var target_position = get_global_mouse_position()
		command_attack.execute(unit, CommandAttack.Params.new(target_position))
