extends Node
## TouchInput (autoload)
##
## Bridge between the on-screen touch controls (VirtualJoystick,
## interact button) and the player controller. Keyboard input is read
## directly from the Input singleton by Player.gd; this bridge lets touch
## input feed into the exact same movement/interact code path instead of
## having a separate touch-only implementation.

var movement: Vector2 = Vector2.ZERO

var _interact_pressed: bool = false


func set_movement(vector: Vector2) -> void:
	movement = vector


func press_interact() -> void:
	_interact_pressed = true


## Returns true once, then clears the flag -- mirrors
## Input.is_action_just_pressed() semantics for a single-frame press.
func consume_interact_press() -> bool:
	var was_pressed := _interact_pressed
	_interact_pressed = false
	return was_pressed
