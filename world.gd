extends Node2D


func _ready() -> void:
	TilemapService.set_tilemap($TileMapLayer)
