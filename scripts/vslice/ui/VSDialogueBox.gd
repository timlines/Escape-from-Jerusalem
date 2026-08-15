extends Control
## Dialogue UI for the vertical slice. Adds branching choices on top of the
## Act I dialogue box pattern: after the last line, if choices were
## provided, buttons are generated for them instead of just closing.

var _lines: Array = []
var _line_index: int = 0
var _choices: Array = []

@onready var speaker_label: Label = $Background/Margin/Content/SpeakerLabel
@onready var text_label: Label = $Background/Margin/Content/TextLabel
@onready var continue_button: Button = $Background/Margin/Content/ContinueButton
@onready var choices_container: VBoxContainer = $Background/Margin/Content/ChoicesContainer


func _ready() -> void:
	visible = false
	VSDialogueManager.register(self)
	continue_button.pressed.connect(advance)


func show_dialogue(speaker_name: String, lines: Array, choices: Array = []) -> void:
	_lines = lines.duplicate()
	_line_index = 0
	_choices = choices
	speaker_label.visible = speaker_name != ""
	speaker_label.text = speaker_name
	continue_button.visible = true
	choices_container.visible = false
	_clear_choice_buttons()
	visible = true
	_display_current_line()


## Advances to the next line. After the last line: shows choice buttons if
## any were given, otherwise closes the box.
func advance() -> void:
	if not visible or not continue_button.visible:
		return
	_line_index += 1
	if _line_index >= _lines.size():
		if _choices.is_empty():
			_close()
		else:
			_show_choices()
	else:
		_display_current_line()


func _display_current_line() -> void:
	text_label.text = _lines[_line_index]


func _show_choices() -> void:
	continue_button.visible = false
	_clear_choice_buttons()
	for choice in _choices:
		var button := Button.new()
		button.text = String(choice.get("text", "..."))
		button.custom_minimum_size = Vector2(0, 56)
		button.pressed.connect(_on_choice_selected.bind(choice))
		choices_container.add_child(button)
	choices_container.visible = true


func _clear_choice_buttons() -> void:
	for child in choices_container.get_children():
		child.queue_free()


func _on_choice_selected(choice: Dictionary) -> void:
	var action = choice.get("action")
	_close()
	if action is Callable and action.is_valid():
		action.call()


func _close() -> void:
	visible = false
	choices_container.visible = false
	_choices = []
	VSDialogueManager.end_dialogue()


func _unhandled_input(event: InputEvent) -> void:
	if not visible or not continue_button.visible:
		return
	if event.is_action_pressed("interact") or event.is_action_pressed("dialogue_advance"):
		advance()
		get_viewport().set_input_as_handled()
