extends Node
## DialogueManager (autoload)
##
## Central hub for showing dialogue. NPCs and interactables call
## `start_dialogue()` without knowing anything about the UI; the DialogueBox
## registers itself here on _ready. Lines are plain strings for now -- a
## branching dialogue resource can replace `dialogue_lines` later without
## touching this API.

signal dialogue_started(speaker_name: String, lines: Array)
signal dialogue_ended

var is_active: bool = false

# The active DialogueBox UI instance. Set via register().
var _dialogue_box: Node = null


func register(dialogue_box: Node) -> void:
	_dialogue_box = dialogue_box


func start_dialogue(speaker_name: String, lines: Array) -> void:
	if is_active or lines.is_empty():
		return
	is_active = true
	dialogue_started.emit(speaker_name, lines)
	if _dialogue_box != null:
		_dialogue_box.show_dialogue(speaker_name, lines)


## Called by the DialogueBox when the player closes/finishes the dialogue.
func end_dialogue() -> void:
	if not is_active:
		return
	is_active = false
	dialogue_ended.emit()


## Called by GameManager when a new run starts, in case a scene change
## happened while dialogue was open -- avoids leaving is_active stuck true
## with a stale DialogueBox reference from the previous scene.
func force_reset() -> void:
	is_active = false
	_dialogue_box = null
