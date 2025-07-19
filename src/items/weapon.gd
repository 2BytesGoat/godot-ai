class_name Weapon
extends Node2D

@onready var collision: CollisionShape2D = $Hurtbox/CollisionShape2D
@onready var animation_payer: AnimationPlayer = $AnimationPlayer

var is_hovered: bool = false
var is_selected: bool = false

signal is_mouse_hovered(state: bool, object: Node2D)



func start_attack():
	animation_payer.play("Attack")


func stop_attack():
	animation_payer.play("RESET")


func pickup():
	collision.disabled = true
	position = Vector2.ZERO


func drop():
	collision.disabled = false


func _on_hurtbox_mouse_entered() -> void:
	if collision.disabled:
		return
	
	is_hovered = true
	is_mouse_hovered.emit(true, self)


func _on_hurtbox_mouse_exited() -> void:
	is_hovered = false
	is_mouse_hovered.emit(false, self)


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.owner is Unit:
		area.owner.hurt(1.0)
