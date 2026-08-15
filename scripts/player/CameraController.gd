extends Camera2D
## Top-down follow camera.
##
## `zoom_level` is the single place to tune how zoomed-in the Zelda-style
## view is -- change it here and every scene that uses Player.tscn picks it
## up automatically. Camera limits (keeping the camera inside the map) are
## set at runtime by Main.gd from the active world's WorldBounds node.

@export var zoom_level: Vector2 = Vector2(2.0, 2.0)
@export var smoothing_speed: float = 8.0


func _ready() -> void:
	zoom = zoom_level
	position_smoothing_enabled = true
	position_smoothing_speed = smoothing_speed
	make_current()
