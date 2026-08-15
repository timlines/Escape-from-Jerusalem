extends Node
## VSDialogueManager (autoload) -- dialogue hub for the vertical slice.
##
## Supports plain multi-line conversations and, at decision points (e.g.
## approaching Laban), a small set of choices with callbacks. This is
## intentionally not a branching dialogue-tree resource -- NPC scripts pick
## which lines/choices to offer based on VSGameState flags/facts before
## calling into this manager, which only knows how to display whatever it's
## given and report the result back.

signal dialogue_started
signal dialogue_ended

var is_active: bool = false

var _dialogue_box: Node = null


func register(dialogue_box: Node) -> void:
	_dialogue_box = dialogue_box


func start_dialogue(speaker_name: String, lines: Array) -> void:
	start_choice_dialogue(speaker_name, lines, [])


## `choices` is an Array of Dictionaries shaped like
## {"text": String, "action": Callable}. The chosen action is invoked once
## the box closes. An empty array behaves like a normal conversation with
## just a Continue button.
func start_choice_dialogue(speaker_name: String, lines: Array, choices: Array) -> void:
	if is_active or lines.is_empty():
		return
	is_active = true
	dialogue_started.emit()
	if _dialogue_box != null:
		_dialogue_box.show_dialogue(speaker_name, lines, choices)


## Called by the DialogueBox once the conversation is fully closed
## (after the last line, or after a choice has been made).
func end_dialogue() -> void:
	if not is_active:
		return
	is_active = false
	dialogue_ended.emit()


## Safety net for GameManager.start_slice() in case a scene change happens
## while a dialogue box from a previous run is still registered.
func force_reset() -> void:
	is_active = false
	_dialogue_box = null
