extends Area2D
## One of the three brothers waiting with Laman (Nephi, Lemuel, or Sam).
## Shows simple flavor dialogue on interact -- the same shape as the
## reused NPC.gd (a name plus some lines) -- but also reports that the
## player has spoken with this brother, so the scene can require a
## conversation with all three before the lot may be cast. This is its
## own small script (rather than reusing scripts/npc/NPC.gd directly) so
## that requirement can be added without touching that shared, unrelated
## file.

signal talked_to

@export var npc_name: String = "Brother"
## Deliberately untyped (Array, not Array[String]): this value is set via
## a property override on an instanced scene's child node in N3World.tscn.
## Godot's exported-typed-array validation can reject that kind of
## override once the project is exported/packed (it isn't present when
## running from the editor), silently leaving this at its default and
## showing "..." in the dialogue box. An untyped Array has no such
## validation and accepts the override in both the editor and an
## exported build.
@export var dialogue_lines: Array = ["..."]


func _ready() -> void:
	add_to_group("interactable")


func interact() -> void:
	DialogueManager.start_dialogue(npc_name, dialogue_lines)
	talked_to.emit()
