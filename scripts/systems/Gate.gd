extends StaticBody2D
## Simple blocking gate for the Act I puzzle. Starts closed (solid, blocks
## the player); open() removes the physical block and dims the visual so
## it reads clearly as "opened" in greybox geometry.

var is_open: bool = false

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var visual: Polygon2D = $Visual


func open() -> void:
	if is_open:
		return
	is_open = true
	collision_shape.set_deferred("disabled", true)
	visual.color = Color(0.3, 0.3, 0.3, 0.35)
