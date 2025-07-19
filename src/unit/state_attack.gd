class_name StateAttack
extends State


func enter(_msg := {}) -> void:
	owner.carried_item.start_attack()
	owner.play_animation(self.name)
	owner.send_state_update()


func on_attack_ended() -> void:
	state_machine.transition_to("Idle")


func exit() -> void:
	owner.carried_item.stop_attack()
