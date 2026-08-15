extends StaticBody2D
## The family member waiting at home. Sends the player off, then reacts
## differently depending on how the plates were obtained (or not yet
## obtained). This is the "family reaction" system from the design doc,
## implemented as simple branching on VSGameState flags rather than a full
## relationship system.

@export var npc_name: String = "Mother"


func on_interact() -> void:
	if not VSGameState.plates_obtained:
		VSDialogueManager.start_dialogue(npc_name, _pre_plates_lines())
		return

	if VSGameManager.slice_complete:
		VSDialogueManager.start_dialogue(npc_name, [
			"We're safe for now, thanks to you.",
			"We'll need to move quickly when it's time to leave the city.",
		])
		return

	_apply_trust_change()
	# Wait for this reaction dialogue to close before ending the slice, so
	# the ending screen doesn't pop up over the family's reaction.
	VSDialogueManager.dialogue_ended.connect(_on_reaction_dialogue_closed, CONNECT_ONE_SHOT)
	VSDialogueManager.start_dialogue(npc_name, _reaction_lines())


func _pre_plates_lines() -> Array[String]:
	if VSGameState.knows("laban_location"):
		return [
			"Have you found Laban yet?",
			"Be careful. Whatever it takes, we need those plates.",
		]
	return [
		"We need the brass plates, and there isn't much time.",
		"Ask around the city. Someone will know where to start.",
	]


func _reaction_lines() -> Array[String]:
	if VSGameState.stole_plates:
		return [
			"You... took them? Without asking?",
			"I'm relieved we have the plates, but now I worry what follows you home.",
		]
	if VSGameState.obtained_method == "trade" and not VSGameState.has_family_heirloom:
		return [
			"That lamp was your grandmother's. I didn't think we'd ever part with it.",
			"But we have the plates, and that matters more. You did well.",
		]
	if VSGameState.obtained_method == "persuade":
		return [
			"You talked him into it? That's no small thing with a man like Laban.",
			"You have a gift for this. I'm proud of you.",
		]
	return [
		"You've brought them home. Thank goodness.",
		"Rest now -- you've done what we needed.",
	]


func _apply_trust_change() -> void:
	if VSGameState.stole_plates:
		VSGameState.add_family_trust(-15)
	elif VSGameState.obtained_method == "persuade":
		VSGameState.add_family_trust(15)
	else:
		VSGameState.add_family_trust(5)


func _on_reaction_dialogue_closed() -> void:
	VSGameManager.complete_slice()
