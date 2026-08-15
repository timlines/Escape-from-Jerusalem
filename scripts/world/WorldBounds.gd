extends Node2D
## Marks the playable extent of a world scene. Main.gd reads this to clamp
## the camera so it never shows outside the greybox map.

@export var bounds_size: Vector2 = Vector2(3200, 900)


func get_rect() -> Rect2:
	return Rect2(global_position, bounds_size)
