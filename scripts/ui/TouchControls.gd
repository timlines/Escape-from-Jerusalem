extends CanvasLayer
## Mobile control layer: virtual joystick (movement) + a large interact
## button. Both write into the TouchInput bridge; Player.gd doesn't know or
## care whether input came from touch or keyboard. Kept as its own scene so
## the control scheme can be redesigned later without touching gameplay.

@onready var interact_button: Button = $InteractButton


func _ready() -> void:
	interact_button.button_down.connect(_on_interact_button_down)


func _on_interact_button_down() -> void:
	TouchInput.press_interact()


## Called by Main.gd when the player's nearby-interactable state changes,
## so the button visibly indicates when it will do something.
func set_interact_highlighted(is_highlighted: bool) -> void:
	interact_button.modulate = Color(1.0, 0.95, 0.4, 1.0) if is_highlighted else Color(1, 1, 1, 1)
