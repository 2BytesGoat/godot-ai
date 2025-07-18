extends Node

@onready var default = preload("res://assets/ui/cursor/hand_small_point.png")
@onready var ally_cursor = preload("res://assets/ui/cursor/green_hand_small_point.png")
@onready var pickup_cursor = preload("res://assets/ui/cursor/hand_small_open.png")

var is_unit_selected = false


func _on_object_is_mouse_hovered(state: bool, object: Node2D) -> void:
	if state:
		if is_unit_selected and object is Weapon:
			Input.set_custom_mouse_cursor(pickup_cursor)
		elif object is Unit:
			Input.set_custom_mouse_cursor(ally_cursor)
		
	else:
		Input.set_custom_mouse_cursor(default)


func _on_player_is_mouse_selected(state: bool) -> void:
	is_unit_selected = state
