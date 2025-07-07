class_name StateAttack
extends State


func enter(_msg := {}) -> void:
	owner.play_animation(self.name)


func on_attack_ended() -> void:
	state_machine.transition_to("Idle")
