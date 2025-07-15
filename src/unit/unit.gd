extends Node2D
class_name Unit

@export var camera: Camera2D
@export var debug: bool = false
@export var move_speed: int = 150

@onready var sprites_container: Node2D = $SpritesContainer
@onready var remote_transform: RemoteTransform2D = $RemoteTransform2D
@onready var controller_container: Node = $ControllerContainer
@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var active_controller: ControllerUnit
var navigation_path: Array

signal update_debug_path(path)


func _ready() -> void:
	set_controller(ControllerHuman.new(self))
	remote_transform.remote_path = camera.get_path()


func set_controller(controller: ControllerUnit) -> void:
	for child in controller_container.get_children():
		child.queue_free()
	
	active_controller = controller
	controller_container.add_child(controller)


func move_to(new_navigation_path: Array) -> void:
	navigation_path = new_navigation_path
	if len(navigation_path) == 0:
		return
	update_facing_position(navigation_path[-1])
	state_machine.transition_to("Move")


func attack_at(new_position: Vector2) -> void:
	update_facing_position(new_position)
	state_machine.transition_to("Attack")


func play_animation(animation_name: String) -> void:
	animation_player.play(animation_name)


func update_facing_position(new_position):
	var facing_direction = sign((global_position - new_position).normalized().x) * -1
	if facing_direction != 0:
		sprites_container.scale.x = facing_direction


func send_state_update():
	if debug:
		update_debug_path.emit(navigation_path)
