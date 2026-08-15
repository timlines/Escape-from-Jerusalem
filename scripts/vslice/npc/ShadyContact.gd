extends StaticBody2D
## Found in the dangerous back alley. Unlike the free rumor-givers
## elsewhere, this contact wants something for his information: a small
## amount of gold in exchange for a tip that makes the theft approach at
## Laban's noticeably safer. A concrete example of "who wants something in
## return."

const FACT_ID := "laban_back_window"
const COST := 5
const CONTACT_NAME := "Marcus"


func on_interact() -> void:
	if VSGameState.knows(FACT_ID):
		VSDialogueManager.start_dialogue(CONTACT_NAME, [
			"I already told you what I know. Use it wisely.",
		])
		return

	VSDialogueManager.start_choice_dialogue(CONTACT_NAME, [
		"You looking for a way around a locked door? That kind of thing costs.",
		"%d gold, and I'll tell you what I know." % COST,
	], [
		{"text": "Pay %d gold for the tip" % COST, "action": Callable(self, "_sell_tip")},
		{"text": "Not interested", "action": Callable(self, "_decline")},
	])


func _sell_tip() -> void:
	if VSGameState.gold < COST:
		VSDialogueManager.start_dialogue(CONTACT_NAME, ["Come back when you've got the coin."])
		return
	VSGameState.add_gold(-COST)
	VSGameState.learn_fact(FACT_ID)
	VSDialogueManager.start_dialogue(CONTACT_NAME, [
		"Smart. The storeroom's side window doesn't latch right.",
		"Don't say where you heard it.",
	])


func _decline() -> void:
	VSDialogueManager.start_dialogue(CONTACT_NAME, ["Suit yourself."])
