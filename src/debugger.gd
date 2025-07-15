extends Node2D

@onready var unit_path = $DebugUnitPath


func _on_player_update_debug_path(path: Variant) -> void:
	unit_path.points = path
