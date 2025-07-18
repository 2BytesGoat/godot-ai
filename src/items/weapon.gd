class_name Weapon
extends Node2D

@onready var animation_payer: AnimationPlayer = $AnimationPlayer

var is_hovered: bool = false
var is_selected: bool = false

signal is_mouse_hovered(state: bool, object: Node2D)



func start_attack():
	animation_payer.play("Attack")


func stop_attack():
	animation_payer.play("RESET")


func _on_hurtbox_mouse_entered() -> void:
	is_hovered = true
	is_mouse_hovered.emit(true, self)


func _on_hurtbox_mouse_exited() -> void:
	is_hovered = false
	is_mouse_hovered.emit(false, self)
