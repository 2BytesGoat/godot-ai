class_name ControllerUnit
extends Node2D

var unit: Unit

var command_move := CommandMove.new()
var command_attack := CommandAttack.new()
var command_pickup := CommandPickup.new()
var command_drop := CommandDrop.new()


func _init(new_unit: Unit) -> void:
	self.unit = new_unit
