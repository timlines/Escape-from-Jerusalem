extends Area2D
## Reusable NPC interaction point.
##
## Attach to the "InteractionArea" child of an NPC scene (the NPC's
## StaticBody2D root handles physical collision separately, so the player
## can't walk through NPCs). This implements the project's interactable
## convention: any Area2D in the "interactable" group with an interact()
## method can be approached and triggered by the player.
##
## The player's own identity is never referenced here -- NPCs only know
## their own name and lines.

@export var npc_name: String = "Villager"
@export var dialogue_lines: Array[String] = ["..."]

## Optional: advance the objective tracker when this NPC is spoken to.
## -1 means "do not change the objective". Kept as simple exported data
## rather than a quest editor, per the greybox scope.
@export var objective_index_on_interact: int = -1


func _ready() -> void:
	add_to_group("interactable")


func interact() -> void:
	DialogueManager.start_dialogue(npc_name, dialogue_lines)
	if objective_index_on_interact >= 0:
		ObjectiveManager.advance_to(objective_index_on_interact)
