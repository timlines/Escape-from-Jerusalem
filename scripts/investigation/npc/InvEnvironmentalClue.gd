extends Area2D
## Information found by exploring, not by talking -- footprints, a dropped
## seal, tracks in the dust. Same interactable convention as everywhere
## else (Area2D in "interactable" group with interact()), but writes
## straight to InvInformationSystem as an Observed record instead of
## opening an NPC's conversation menu.

@export var display_name: String = "A trace"
@export var fact_id: String = ""
@export var subject: String = "Laban"
@export var claim: String = ""
@export var source: String = "Environmental observation"
@export var examine_lines: Array[String] = ["..."]
@export var repeat_lines: Array[String] = ["You've already looked this over."]


func _ready() -> void:
	add_to_group("interactable")


func interact() -> void:
	if InvDialogueManager.is_active:
		return
	if fact_id != "" and not InvInformationSystem.knows(fact_id):
		InvInformationSystem.add_record(fact_id, subject, claim, source, InfoRecord.STATUS_OBSERVED)
		InvDialogueManager.show_note(display_name, examine_lines)
	else:
		InvDialogueManager.show_note(display_name, repeat_lines)
