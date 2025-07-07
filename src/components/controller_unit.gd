class_name ControllerUnit
extends Node2D

var unit: Unit

var command_move := CommandMove.new()
var command_attack := CommandAttack.new()


func _init(unit: Unit) -> void:
	self.unit = unit
