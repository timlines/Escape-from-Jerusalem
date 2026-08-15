extends Area2D
## Reusable "examine" interactable for environmental flavor (a warning
## painted on a wall, a market notice, etc). Same interactable convention
## as everything else in the slice: Area2D in the "interactable" group with
## an interact() method, wired to VSDialogueManager.

@export var display_name: String = ""
@export var message_lines: Array[String] = ["Just a mark on the wall."]


func _ready() -> void:
	add_to_group("interactable")


func interact() -> void:
	VSDialogueManager.start_dialogue(display_name, message_lines)
