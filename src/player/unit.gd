extends Node2D
class_name Unit

@export var remote_path: NodePath

@onready var remote_transform: RemoteTransform2D = $RemoteTransform2D
@onready var controller_container: Node = $ControllerContainer
@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var active_controller: ControllerUnit


func _ready() -> void:
	set_controller(ControllerHuman.new(self))
	
	if remote_path:
		remote_transform.remote_path = remote_path
		

func set_controller(controller: ControllerUnit) -> void:
	for child in controller_container.get_children():
		child.queue_free()
	
	active_controller = controller
	controller_container.add_child(controller)


func move_to(new_position: Vector2) -> void:
	state_machine.transition_to("Move", {"target_position": new_position})


func attack_at(_target_position: Vector2) -> void:
	state_machine.transition_to("Attack")


func play_animation(animation_name: String) -> void:
	animation_player.play(animation_name)
