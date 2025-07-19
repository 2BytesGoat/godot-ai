extends Node2D

@onready var tilemap_container = $TerrainContainer


func _ready() -> void:
	TilemapService.set_tilemap(tilemap_container)
