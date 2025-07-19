class_name CommandDrop
extends Command


class Params:
	func _init() -> void:
		pass

func execute(unit: Unit, _data: Object = null) -> void:
	unit.drop_carried_object()
