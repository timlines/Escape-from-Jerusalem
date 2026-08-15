extends Area2D
## Laban's refusal (1 Nephi 3:11-14). Plays out exactly as scripture
## describes and is not a player choice -- the outcome never changes.
## The scripture doesn't explain why Laban reacts this way, so no
## explanation is invented here; his line is quoted directly from verse 13.

signal rejected

@export var already_happened_lines: Array[String] = [
	"Laban will not receive you again.",
]

var _has_happened: bool = false


func _ready() -> void:
	add_to_group("interactable")


func interact() -> void:
	if _has_happened:
		DialogueManager.start_dialogue("", already_happened_lines)
		return
	_has_happened = true
	DialogueManager.start_dialogue("Laman", [
		"My father sent me. We have need of the records in your keeping -- the plates of brass.",
		"They hold the genealogy of our fathers. I ask that you give them to us.",
	])
	DialogueManager.dialogue_ended.connect(_on_request_closed, CONNECT_ONE_SHOT)


func _on_request_closed() -> void:
	DialogueManager.start_dialogue("", ["Laban's expression darkens."])
	DialogueManager.dialogue_ended.connect(_on_darken_closed, CONNECT_ONE_SHOT)


func _on_darken_closed() -> void:
	DialogueManager.start_dialogue("Laban", ["Behold, thou art a robber, and I will slay thee!"])
	DialogueManager.dialogue_ended.connect(_on_threat_closed, CONNECT_ONE_SHOT)


func _on_threat_closed() -> void:
	DialogueManager.start_dialogue("", ["He thrusts you out from his house."])
	DialogueManager.dialogue_ended.connect(_on_final_closed, CONNECT_ONE_SHOT)


func _on_final_closed() -> void:
	rejected.emit()
