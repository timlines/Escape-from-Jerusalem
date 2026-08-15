extends Area2D
## Invisible one-shot zone: advances the objective tracker when the player
## walks into it (e.g. entering the residential area advances "Find your
## family"). Fires once, then disables itself.

@export var objective_index: int = 0

var _fired: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if _fired or not body.is_in_group("player"):
		return
	_fired = true
	ObjectiveManager.advance_to(objective_index)
	set_deferred("monitoring", false)
