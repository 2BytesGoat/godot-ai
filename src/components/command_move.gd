class_name CommandMove
extends Command


class Params:
	var target_position: Vector2
	
	func _init(target_position: Vector2) -> void:
		self.target_position = target_position


func execute(unit: Unit, data: Object = null) -> void:
	if data is Params:
		unit.move_to(data.target_position)
