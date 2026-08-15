extends Area2D
## Reusable "examine object" interactable -- signs, notices, environmental
## props that just show a line or two of text. Same interactable
## convention as NPC.gd: Area2D in the "interactable" group with interact().

@export var display_name: String = ""
@export var message_lines: Array[String] = ["It's just a sign."]


func _ready() -> void:
	add_to_group("interactable")


func interact() -> void:
	DialogueManager.start_dialogue(display_name, message_lines)
