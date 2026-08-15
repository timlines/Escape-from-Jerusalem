extends Control
## Conversation UI for the Investigation MVP. A pure view: InvDialogueManager
## decides speaker/lines/buttons and reads back whichever button id the
## player pressed. Buttons double as both the intent menu (Ask/Tell/Offer/
## Persuade/Lie/Threaten/Observe/Leave) and topic lists -- same widget,
## different data, which is what keeps this a "structured conversation
## system" rather than a hand-authored dialogue tree per NPC.

var _lines: Array = []
var _line_index: int = 0
var _buttons: Array = []

@onready var speaker_label: Label = $Background/Margin/Content/SpeakerLabel
@onready var text_label: Label = $Background/Margin/Content/TextLabel
@onready var continue_button: Button = $Background/Margin/Content/ContinueButton
@onready var buttons_container: VBoxContainer = $Background/Margin/Content/ButtonsContainer


func _ready() -> void:
	visible = false
	InvDialogueManager.register(self)
	continue_button.pressed.connect(advance)


func show_screen(speaker: String, lines: Array, buttons: Array) -> void:
	_lines = lines.duplicate()
	_line_index = 0
	_buttons = buttons
	speaker_label.visible = speaker != ""
	speaker_label.text = speaker
	continue_button.visible = true
	buttons_container.visible = false
	_clear_buttons()
	visible = true
	_display_current_line()


func hide_box() -> void:
	visible = false
	_clear_buttons()


func advance() -> void:
	if not visible or not continue_button.visible:
		return
	_line_index += 1
	if _line_index >= _lines.size():
		_show_buttons()
	else:
		_display_current_line()


func _display_current_line() -> void:
	text_label.text = _lines[_line_index]


func _show_buttons() -> void:
	continue_button.visible = false
	_clear_buttons()
	for button_data in _buttons:
		var button := Button.new()
		button.text = String(button_data.get("label", "..."))
		button.custom_minimum_size = Vector2(0, 52)
		button.pressed.connect(_on_button_pressed.bind(String(button_data.get("id", ""))))
		buttons_container.add_child(button)
	buttons_container.visible = true


func _clear_buttons() -> void:
	for child in buttons_container.get_children():
		child.queue_free()


func _on_button_pressed(button_id: String) -> void:
	InvDialogueManager.on_button(button_id)


func _unhandled_input(event: InputEvent) -> void:
	if not visible or not continue_button.visible:
		return
	if event.is_action_pressed("interact") or event.is_action_pressed("dialogue_advance"):
		advance()
		get_viewport().set_input_as_handled()
