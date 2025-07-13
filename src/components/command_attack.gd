class_name CommandAttack
extends Command


class Params:
	var target_position: Vector2
	
	func _init(new_position: Vector2) -> void:
		self.target_position = new_position


func execute(unit: Unit, data: Object = null) -> void:
	if data is Params:
		unit.attack_at(data.target_position)
