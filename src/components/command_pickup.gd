class_name CommandPickup
extends Command


class Params:
	var object: Node2D
	
	func _init(new_object: Node2D) -> void:
		self.object = new_object


func execute(unit: Unit, data: Object = null) -> void:
	if data is Params:
		unit.pickup_object(data.object)
