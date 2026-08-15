extends StaticBody2D
## Laban holds the brass plates. This is the one NPC with real branching
## consequences: trade, persuade, or steal. None of the three is flagged as
## "correct" -- each has a different cost, and persuasion only succeeds if
## the player has actually pieced together why Laban wants what he wants.

const TRADE_RELATIONSHIP_GAIN := 15
const PERSUADE_RELATIONSHIP_GAIN := 5
const PERSUADE_FAIL_SUSPICION := 5
const PERSUADE_FAIL_RELATIONSHIP := -5
const THEFT_SUSPICION_KNEW_WINDOW := 15
const THEFT_SUSPICION_BLIND := 40
const THEFT_RELATIONSHIP_LOSS := -60


func on_interact() -> void:
	VSGameState.set_quest_stage(2)

	if VSGameState.plates_obtained:
		VSDialogueManager.start_dialogue("Laban", [
			"We have no further business, unless you've reconsidered your terms.",
		])
		return

	VSDialogueManager.start_choice_dialogue("Laban", _intro_lines(), _build_choices())


func _intro_lines() -> Array[String]:
	if VSGameState.knows("laban_distrustful"):
		return [
			"Back again? I don't do business with strangers, but you already knew that.",
			"So. What is it you want from me?",
		]
	return [
		"I don't know you. State your business, and be quick about it.",
	]


func _build_choices() -> Array:
	var choices: Array = []

	if VSGameState.has_family_heirloom:
		choices.append({
			"text": "Offer the family heirloom in trade",
			"action": Callable(self, "_do_trade_heirloom"),
		})

	choices.append({
		"text": "Offer gold instead",
		"action": Callable(self, "_do_trade_gold"),
	})
	choices.append({
		"text": "Try to persuade him",
		"action": Callable(self, "_do_persuade"),
	})
	choices.append({
		"text": "Take the plates without asking",
		"action": Callable(self, "_do_theft"),
	})
	choices.append({
		"text": "Not yet -- leave",
		"action": Callable(self, "_do_leave"),
	})
	return choices


func _do_trade_heirloom() -> void:
	VSGameState.give_away_heirloom()
	VSGameState.add_merchant_relationship(TRADE_RELATIONSHIP_GAIN)
	VSGameState.mark_plates_obtained("trade")
	VSDialogueManager.start_dialogue("Laban", [
		"This... this belonged to your family. I remember it well.",
		"Very well. The plates are yours. Take them and go swiftly.",
	])


func _do_trade_gold() -> void:
	VSGameState.add_suspicion(5)
	VSDialogueManager.start_dialogue("Laban", [
		"Silver? I have silver enough. It isn't silver I need.",
		"Come back when you have something that matters.",
	])


func _do_persuade() -> void:
	var knows_motive := VSGameState.knows("laban_wants_heirloom")
	var knows_reason := VSGameState.knows("laban_debt_reason")
	var understands_him := knows_motive and knows_reason
	if understands_him:
		VSGameState.add_merchant_relationship(PERSUADE_RELATIONSHIP_GAIN)
		VSGameState.mark_plates_obtained("persuade")
		VSDialogueManager.start_dialogue("Laban", [
			"...How do you know about the debt?",
			"Fine. Fine! Keep it quiet, and the plates are yours. No trade needed.",
		])
	else:
		VSGameState.add_suspicion(PERSUADE_FAIL_SUSPICION)
		VSGameState.add_merchant_relationship(PERSUADE_FAIL_RELATIONSHIP)
		VSDialogueManager.start_dialogue("Laban", [
			"Fine words, but words don't pay debts.",
			"You don't understand what's really at stake here. Come back when you do.",
		])


func _do_theft() -> void:
	var knew_window := VSGameState.knows("laban_back_window")
	VSGameState.add_merchant_relationship(THEFT_RELATIONSHIP_LOSS)
	VSGameState.mark_plates_obtained("theft")
	if knew_window:
		VSGameState.add_suspicion(THEFT_SUSPICION_KNEW_WINDOW)
		VSDialogueManager.start_dialogue("", [
			"You slip through the loose storeroom window, just as you were told.",
			"The plates are in your hands before anyone notices you were ever there.",
		])
	else:
		VSGameState.add_suspicion(THEFT_SUSPICION_BLIND)
		VSDialogueManager.start_dialogue("", [
			"You fumble at the storeroom door. Something clatters to the floor.",
			"You grab the plates and run -- but people saw. People always see.",
		])


func _do_leave() -> void:
	VSDialogueManager.start_dialogue("Laban", ["Then don't waste my time."])
