extends Unit

@onready var remote_transform: RemoteTransform2D = $RemoteTransform2D


func _ready() -> void:
	remote_transform.remote_path = camera.get_path()
