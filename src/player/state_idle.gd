class_name StateIdle
extends State


func enter(_msg := {}) -> void:
	owner.play_animation(self.name)
