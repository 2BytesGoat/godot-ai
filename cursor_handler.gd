extends Node

@onready var default = preload("res://assets/ui/cursor/hand_small_point.png")
@onready var ally_cursor = preload("res://assets/ui/cursor/green_hand_small_point.png")



func _on_player_is_mouse_hovered(state: Variant) -> void:
	if state:
		Input.set_custom_mouse_cursor(ally_cursor)
	else:
		Input.set_custom_mouse_cursor(default)
