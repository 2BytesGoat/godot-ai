class_name CommandMove
extends Command


class Params:
	var navigation_path: Array
	
	func _init(new_navigation_path: Array) -> void:
		self.navigation_path = new_navigation_path


func execute(unit: Unit, data: Object = null) -> void:
	if data is Params:
		unit.move_to(data.navigation_path)
