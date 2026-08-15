extends Control
## On-screen analog joystick. Feeds TouchInput.movement, which Player.gd
## reads through the same code path as keyboard input. Uses global _input()
## (not _gui_input) so the drag is still tracked even if the finger moves
## outside the joystick's base graphic, which is how mobile joysticks are
## expected to behave. Also responds to the mouse so it can be tested with
## a desktop editor run.

@export var max_distance: float = 60.0

var _touch_index: int = -1
var _dragging: bool = false
var _base_center: Vector2

@onready var base: Control = $Base
@onready var knob: Control = $Base/Knob


func _ready() -> void:
	_base_center = base.size / 2.0
	_reset_knob()


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		_handle_touch(event)
	elif event is InputEventScreenDrag:
		_handle_drag(event)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_handle_mouse_button(event)
	elif event is InputEventMouseMotion and _dragging:
		_update_knob(event.global_position)


func _handle_touch(event: InputEventScreenTouch) -> void:
	if event.pressed and _touch_index == -1:
		if base.get_global_rect().grow(max_distance).has_point(event.position):
			_touch_index = event.index
			_dragging = true
			_update_knob(event.position)
	elif not event.pressed and event.index == _touch_index:
		_touch_index = -1
		_dragging = false
		_reset_knob()


func _handle_drag(event: InputEventScreenDrag) -> void:
	if _dragging and event.index == _touch_index:
		_update_knob(event.position)


func _handle_mouse_button(event: InputEventMouseButton) -> void:
	if event.pressed and base.get_global_rect().grow(max_distance).has_point(event.global_position):
		_dragging = true
		_update_knob(event.global_position)
	elif not event.pressed and _dragging:
		_dragging = false
		_reset_knob()


func _update_knob(global_point: Vector2) -> void:
	var offset := global_point - base.get_global_rect().get_center()
	if offset.length() > max_distance:
		offset = offset.normalized() * max_distance
	knob.position = _base_center + offset - knob.size / 2.0
	TouchInput.set_movement(offset / max_distance)


func _reset_knob() -> void:
	knob.position = _base_center - knob.size / 2.0
	TouchInput.set_movement(Vector2.ZERO)
