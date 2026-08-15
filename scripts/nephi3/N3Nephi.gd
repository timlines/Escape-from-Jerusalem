extends Area2D
## Nephi (1 Nephi 3:9-11). Triggers the "casting lots" beat once. The
## outcome is fixed -- the lot falls to Laman -- this is not a player
## choice, just a faithful retelling.

signal lots_cast

@export var already_cast_lines: Array[String] = [
	"The lot has already fallen to you, Laman. The house of Laban lies ahead.",
]

var _has_happened: bool = false


func _ready() -> void:
	add_to_group("interactable")


func interact() -> void:
	if _has_happened:
		DialogueManager.start_dialogue("Nephi", already_cast_lines)
		return
	_has_happened = true
	DialogueManager.start_dialogue("Nephi", [
		"We have journeyed up to Jerusalem, as our father commanded.",
		"Laban keeps the records of our fathers, engraven on plates of brass.",
		"Let us cast lots, to see who among us will go in to him.",
	])
	DialogueManager.dialogue_ended.connect(_on_first_dialogue_closed, CONNECT_ONE_SHOT)


func _on_first_dialogue_closed() -> void:
	DialogueManager.start_dialogue("", ["The lot falls to you, Laman."])
	DialogueManager.dialogue_ended.connect(_on_lot_dialogue_closed, CONNECT_ONE_SHOT)


func _on_lot_dialogue_closed() -> void:
	lots_cast.emit()
