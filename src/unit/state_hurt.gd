class_name StateHurt
extends State


func enter(_msg := {}) -> void:
	owner.play_animation(self.name)
	owner.send_state_update()


func on_hurt_animation_ended() -> void:
	state_machine.transition_to("Idle")
