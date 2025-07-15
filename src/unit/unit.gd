extends Node2D
class_name Unit

@export var camera: Camera2D
@export var move_speed: int = 150

@onready var sprites_container: Node2D = $SpritesContainer
@onready var remote_transform: RemoteTransform2D = $RemoteTransform2D
@onready var controller_container: Node = $ControllerContainer
@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var active_controller: ControllerUnit


func _ready() -> void:
	set_controller(ControllerHuman.new(self))
	remote_transform.remote_path = camera.get_path()


func set_controller(controller: ControllerUnit) -> void:
	for child in controller_container.get_children():
		child.queue_free()
	
	active_controller = controller
	controller_container.add_child(controller)


func move_to(navigation_path: Array) -> void:
	state_machine.transition_to("Move", {"navigation_path": navigation_path})


func attack_at(new_position: Vector2) -> void:
	update_facing_position(new_position)
	state_machine.transition_to("Attack")


func play_animation(animation_name: String) -> void:
	animation_player.play(animation_name)


func update_facing_position(new_position):
	var facing_direction = sign((global_position - new_position).normalized().x) * -1
	if facing_direction != 0:
		sprites_container.scale.x = facing_direction
