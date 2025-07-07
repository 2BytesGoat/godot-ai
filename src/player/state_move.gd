class_name StateMove
extends State

var target_position := Vector2.INF


func enter(msg := {}) -> void:
	target_position = msg["target_position"]
	owner.play_animation(self.name)


func physics_update(delta: float) -> void:
	owner.global_position = owner.global_position.move_toward(target_position, 150 * delta)
	if owner.global_position == target_position:
		state_machine.transition_to("Idle")


func exit():
	target_position = Vector2.INF
