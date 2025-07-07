extends Node2D

@onready var animation_payer: AnimationPlayer = $AnimationPlayer


func start_attack():
	animation_payer.play("Attack")

func stop_attack():
	animation_payer.play("RESET")
