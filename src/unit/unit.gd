class_name Unit
extends Node2D

@export var camera: Camera2D
@export var debug: bool = false
@export var move_speed: int = 150

@onready var sprites_container: Node2D = $SpritesContainer
@onready var weapon_point: Marker2D = $SpritesContainer/Marker2D
@onready var remote_transform: RemoteTransform2D = $RemoteTransform2D
@onready var controller_container: Node = $ControllerContainer
@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var select_highlight: Line2D = $SelectHighlight

var is_hovered: bool = false
var is_selected: bool = false

var active_controller: ControllerUnit
var navigation_path: Array
var carried_item: Node2D = null

signal action_done
signal update_debug_path(path)
signal is_mouse_hovered(state: bool, object: Node2D)
signal is_mouse_selected(state: bool)


func _ready() -> void:
	remote_transform.remote_path = camera.get_path()


func _input(event: InputEvent) -> void:
	if event.is_action("mouse_left"):
		_set_selected(is_hovered)


func set_controller(controller: ControllerUnit) -> void:
	clear_controllers()
	active_controller = controller
	controller_container.add_child(controller)


func clear_controllers() -> void:
	for child in controller_container.get_children():
		child.queue_free()


func move_to(new_navigation_path: Array) -> void:
	navigation_path = new_navigation_path
	if len(navigation_path) == 0:
		return
	update_facing_position(navigation_path[-1])
	state_machine.transition_to("Move")


func attack_at(new_position: Vector2) -> void:
	update_facing_position(new_position)
	state_machine.transition_to("Attack")


func pickup_object(object: Node2D) -> void:
	carried_item = object
	object.pickup()
	object.get_parent().remove_child(object)
	weapon_point.add_child(object)
	action_done.emit()


func drop_carried_object() -> void:
	weapon_point.remove_child(carried_item)
	carried_item.drop()
	get_parent().add_child(carried_item)
	carried_item.global_position = global_position
	carried_item = null
	action_done.emit()


func play_animation(animation_name: String) -> void:
	animation_player.play(animation_name)


func update_facing_position(new_position):
	var facing_direction = sign((global_position - new_position).normalized().x) * -1
	if facing_direction != 0:
		sprites_container.scale.x = facing_direction


func send_state_update():
	if debug:
		update_debug_path.emit(navigation_path)


func is_doing_action():
	return state_machine.state.name != "Idle"


func reset():
	navigation_path = []
	state_machine.transition_to("Idle")


func _set_selected(value: bool) -> void:
	is_selected = value
	if is_selected:
		set_controller(ControllerHuman.new(self))
		select_highlight.visible = true
	else:
		clear_controllers()
		select_highlight.visible = false
	is_mouse_selected.emit(value)


func _on_hurtbox_mouse_entered() -> void:
	is_hovered = true
	is_mouse_hovered.emit(true, self)


func _on_hurtbox_mouse_exited() -> void:
	is_hovered = false
	is_mouse_hovered.emit(false, self)
