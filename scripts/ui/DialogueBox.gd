extends Control
## Minimal dialogue UI: speaker name, one line of text at a time, and a
## continue action that works from keyboard (E / Space) or the on-screen
## button. Lines are a flat Array[String] for now; swapping in a branching
## dialogue resource later only means changing what feeds show_dialogue().

var _lines: Array = []
var _line_index: int = 0

@onready var speaker_label: Label = $Background/Margin/Content/SpeakerLabel
@onready var text_label: Label = $Background/Margin/Content/TextLabel
@onready var continue_button: Button = $Background/Margin/Content/ContinueButton


func _ready() -> void:
	visible = false
	DialogueManager.register(self)
	continue_button.pressed.connect(advance)


func show_dialogue(speaker_name: String, lines: Array) -> void:
	_lines = lines.duplicate()
	_line_index = 0
	speaker_label.visible = speaker_name != ""
	speaker_label.text = speaker_name
	visible = true
	_display_current_line()


## Advances to the next line, or closes the box after the last one.
## Called by the Continue button and by keyboard/touch "advance" input.
func advance() -> void:
	if not visible:
		return
	_line_index += 1
	if _line_index >= _lines.size():
		_close()
	else:
		_display_current_line()


func _display_current_line() -> void:
	text_label.text = _lines[_line_index]


func _close() -> void:
	visible = false
	DialogueManager.end_dialogue()


func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("interact") or event.is_action_pressed("dialogue_advance"):
		advance()
		get_viewport().set_input_as_handled()
