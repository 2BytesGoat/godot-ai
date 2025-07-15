extends Line2D


func _draw() -> void:
	for point in points:
		draw_circle(point, width+1, default_color)
