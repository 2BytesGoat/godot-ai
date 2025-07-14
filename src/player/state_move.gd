class_name StateMove
extends State

var navigation_path := []
var next_position := Vector2.INF


func enter(msg := {}) -> void:
	navigation_path = msg["navigation_path"]
	owner.play_animation(self.name)

func physics_update(delta: float) -> void:
	if next_position == Vector2.INF or owner.global_position == next_position:
		if len(navigation_path) == 0:
			state_machine.transition_to("Idle")
			return
		next_position = navigation_path.pop_front()
		owner.update_facing_position(next_position)
	# TODO: add smoothing the closer you are to the target
	owner.global_position = owner.global_position.move_toward(next_position, 150 * delta)


func exit():
	navigation_path = []
