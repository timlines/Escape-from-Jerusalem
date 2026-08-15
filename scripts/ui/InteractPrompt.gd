extends Control
## Small "INTERACT" prompt shown when the player is near something
## interactable. Main.gd wires this to Player.interactable_in_range_changed
## -- this script itself has no idea what a Player is.

@onready var label: Label = $Background/Label


func _ready() -> void:
	visible = false


func set_prompt_visible(has_target: bool) -> void:
	visible = has_target
