extends Node
## InvDialogueManager (autoload)
##
## The conversation "gameplay" layer. Owns a small state machine per NPC
## (greeting -> intent menu -> topic/leaf -> back to intent menu) built
## entirely from InvNPCData. The registered InvConversationBox is a dumb
## view: it only ever receives (speaker, lines, buttons) and reports back
## which button id was pressed.
##
## Structured intents, not free text -- Ask / Tell / Offer / Persuade /
## Lie / Threaten / Observe / Leave -- per the design brief's instruction
## not to over-engineer unrestricted dialogue for this MVP.

signal dialogue_started
signal dialogue_ended

var is_active: bool = false

var _box: Node = null
var _current_npc_id: String = ""
var _button_actions: Dictionary = {} # id -> Callable
var _asked_topics: Dictionary = {} # "npc_id:topic_id" -> true


func _ready() -> void:
	InvRelationshipSystem.trust_changed.connect(_on_trust_changed)


func reset() -> void:
	_asked_topics.clear()
	is_active = false
	_current_npc_id = ""


func register(box: Node) -> void:
	_box = box


func force_reset() -> void:
	is_active = false
	_box = null


## Entry point for every generic NPC (everyone except Laban).
func open_npc(npc_id: String) -> void:
	if is_active:
		return
	is_active = true
	_current_npc_id = npc_id
	dialogue_started.emit()
	_show_greeting(npc_id)


## Entry point for environmental clues -- a single note with no intent
## menu, just a way to close it.
func show_note(speaker: String, lines: Array) -> void:
	if is_active:
		return
	is_active = true
	dialogue_started.emit()
	_show(speaker, lines, [{"id": "leave", "label": "Close", "action": Callable(self, "end_dialogue")}])


## Entry point for Laban -- a bespoke two-phase encounter rather than the
## generic ask/tell/offer engine, since it is the critical story beat.
func open_laban() -> void:
	if is_active:
		return
	is_active = true
	_current_npc_id = "laban"
	dialogue_started.emit()
	_show_laban_greeting()


func end_dialogue() -> void:
	if not is_active:
		return
	is_active = false
	_current_npc_id = ""
	if _box != null:
		_box.hide_box()
	dialogue_ended.emit()


## Called by InvConversationBox when the player presses a button.
func on_button(button_id: String) -> void:
	var action = _button_actions.get(button_id)
	if action is Callable and action.is_valid():
		action.call()


func _show(speaker: String, lines: Array, buttons: Array) -> void:
	_button_actions.clear()
	var display_buttons: Array = []
	for button in buttons:
		_button_actions[button["id"]] = button["action"]
		display_buttons.append({"id": button["id"], "label": button["label"]})
	if _box != null:
		_box.show_screen(speaker, lines, display_buttons)


# ---------------------------------------------------------------------
# Generic NPC flow
# ---------------------------------------------------------------------

func _show_greeting(npc_id: String) -> void:
	var entry := InvNPCData.get_entry(npc_id)
	var met_flag := "met_%s" % npc_id
	var lines: Array = entry.get("greeting_return", ["..."])
	if not InvGameState.has_flag(met_flag):
		InvGameState.set_flag(met_flag, true)
		lines = entry.get("greeting_first", ["..."])
	_show(InvNPCData.get_display_name(npc_id), lines, _build_intent_buttons(npc_id))


func _build_intent_buttons(npc_id: String) -> Array:
	var entry := InvNPCData.get_entry(npc_id)
	var buttons: Array = []

	if not (entry.get("ask_topics", []) as Array).is_empty():
		buttons.append({"id": "intent_ask", "label": "Ask",
			"action": Callable(self, "_open_ask_topics").bind(npc_id)})

	if not (entry.get("tell_reactions", {}) as Dictionary).is_empty():
		buttons.append({"id": "intent_tell", "label": "Tell",
			"action": Callable(self, "_open_tell_topics").bind(npc_id)})

	if entry.get("favor") != null and not InvRelationshipSystem.has_done_favor(npc_id, entry["favor"]["id"]):
		buttons.append({"id": "intent_offer", "label": "Offer to help",
			"action": Callable(self, "_do_offer").bind(npc_id)})

	if entry.get("persuade") != null:
		buttons.append({"id": "intent_persuade", "label": "Persuade",
			"action": Callable(self, "_do_persuade").bind(npc_id)})

	if entry.has("lie") and not InvGameState.has_flag("lied_%s" % npc_id):
		buttons.append({"id": "intent_lie", "label": "Bend the truth",
			"action": Callable(self, "_do_lie").bind(npc_id)})

	buttons.append({"id": "intent_observe", "label": "Observe",
		"action": Callable(self, "_do_observe").bind(npc_id)})
	buttons.append({"id": "intent_leave", "label": "Leave", "action": Callable(self, "end_dialogue")})
	return buttons


func _open_ask_topics(npc_id: String) -> void:
	var entry := InvNPCData.get_entry(npc_id)
	var topics: Array = entry.get("ask_topics", [])
	var visible: Array = []
	for topic in topics:
		if _topic_is_visible(npc_id, topic):
			visible.append(topic)

	if visible.is_empty():
		_show(InvNPCData.get_display_name(npc_id), ["There's nothing more to ask about, for now."],
			[{"id": "back", "label": "Back", "action": Callable(self, "_show_intent_menu").bind(npc_id)}])
		return

	var buttons: Array = []
	for topic in visible:
		buttons.append({"id": "topic_%s" % topic["id"], "label": topic["label"],
			"action": Callable(self, "_do_ask_topic").bind(npc_id, topic)})
	buttons.append({"id": "back", "label": "Back", "action": Callable(self, "_show_intent_menu").bind(npc_id)})
	_show(InvNPCData.get_display_name(npc_id), ["What would you like to ask about?"], buttons)


func _topic_is_visible(npc_id: String, topic: Dictionary) -> bool:
	var requires_fact: String = topic.get("requires_fact", "")
	if requires_fact != "" and not InvInformationSystem.knows(requires_fact):
		return false
	var requires_favor: String = topic.get("requires_favor", "")
	if requires_favor != "" and not InvRelationshipSystem.has_done_favor(npc_id, requires_favor):
		return false
	var min_trust: int = topic.get("min_trust", 0)
	if InvRelationshipSystem.get_trust(npc_id) < min_trust:
		return false
	return true


func _do_ask_topic(npc_id: String, topic: Dictionary) -> void:
	var key := "%s:%s" % [npc_id, topic["id"]]
	var already_asked: bool = _asked_topics.get(key, false)
	var lines: Array = topic.get("lines", ["..."])
	if already_asked and not (topic.get("repeat_lines", []) as Array).is_empty():
		lines = topic["repeat_lines"]

	if not already_asked:
		_asked_topics[key] = true
		var reveals_fact: String = topic.get("reveals_fact", "")
		if reveals_fact != "":
			InvInformationSystem.add_record(reveals_fact, topic.get("reveal_subject", ""),
				topic.get("reveal_claim", ""), InvNPCData.get_display_name(npc_id),
				topic.get("reveal_status", InfoRecord.STATUS_REPORTED))
		var trust_delta: int = topic.get("trust_delta", 0)
		if trust_delta != 0:
			InvRelationshipSystem.add_trust(npc_id, trust_delta)

	_show(InvNPCData.get_display_name(npc_id), lines, _build_intent_buttons(npc_id))


func _open_tell_topics(npc_id: String) -> void:
	var entry := InvNPCData.get_entry(npc_id)
	var reactions: Dictionary = entry.get("tell_reactions", {})
	var buttons: Array = []
	for fact_id in reactions.keys():
		if InvInformationSystem.knows(fact_id) and not InvRelationshipSystem.has_told(npc_id, fact_id):
			var reaction: Dictionary = reactions[fact_id]
			buttons.append({"id": "tell_%s" % fact_id, "label": reaction.get("label", "Tell them"),
				"action": Callable(self, "_do_tell").bind(npc_id, fact_id)})

	if buttons.is_empty():
		_show(InvNPCData.get_display_name(npc_id), ["Nothing you know seems worth telling them yet."],
			[{"id": "back", "label": "Back", "action": Callable(self, "_show_intent_menu").bind(npc_id)}])
		return

	buttons.append({"id": "back", "label": "Back", "action": Callable(self, "_show_intent_menu").bind(npc_id)})
	_show(InvNPCData.get_display_name(npc_id), ["What do you want to tell them?"], buttons)


func _do_tell(npc_id: String, fact_id: String) -> void:
	var entry := InvNPCData.get_entry(npc_id)
	var reaction: Dictionary = entry.get("tell_reactions", {}).get(fact_id, {})
	InvRelationshipSystem.mark_told(npc_id, fact_id)
	var trust_delta: int = reaction.get("trust_delta", 0)
	if trust_delta != 0:
		InvRelationshipSystem.add_trust(npc_id, trust_delta)
	_show(InvNPCData.get_display_name(npc_id), reaction.get("lines", ["..."]), _build_intent_buttons(npc_id))


func _do_offer(npc_id: String) -> void:
	var entry := InvNPCData.get_entry(npc_id)
	var favor: Dictionary = entry.get("favor", {})
	var requires_fact: String = favor.get("requires_fact", "")
	if requires_fact != "" and not InvInformationSystem.knows(requires_fact):
		var not_ready: Array = favor.get("not_ready_lines", ["Not yet."])
		_show(InvNPCData.get_display_name(npc_id), not_ready, _build_intent_buttons(npc_id))
		return

	InvRelationshipSystem.mark_favor_done(npc_id, favor["id"])
	InvRelationshipSystem.add_trust(npc_id, favor.get("trust_delta", 0))
	_show(InvNPCData.get_display_name(npc_id), favor.get("resolve_lines", ["My thanks."]),
		_build_intent_buttons(npc_id))


func _do_persuade(npc_id: String) -> void:
	var entry := InvNPCData.get_entry(npc_id)
	var persuade: Dictionary = entry.get("persuade", {})
	var cap_trust: int = persuade.get("cap_trust", 5)
	var lines: Array
	if InvRelationshipSystem.get_trust(npc_id) < cap_trust:
		InvRelationshipSystem.add_trust(npc_id, persuade.get("success_trust_delta", 1))
		lines = persuade.get("success_lines", ["..."])
	else:
		var fail_delta: int = persuade.get("fail_trust_delta", 0)
		if fail_delta != 0:
			InvRelationshipSystem.add_trust(npc_id, fail_delta)
		lines = persuade.get("fail_lines", ["..."])
	_show(InvNPCData.get_display_name(npc_id), lines, _build_intent_buttons(npc_id))


func _do_lie(npc_id: String) -> void:
	var entry := InvNPCData.get_entry(npc_id)
	var lie: Dictionary = entry.get("lie", {})
	InvGameState.set_flag("lied_%s" % npc_id, true)
	var reveals_fact: String = lie.get("reveals_fact", "")
	if reveals_fact != "":
		InvInformationSystem.add_record(reveals_fact, lie.get("reveal_subject", ""),
			lie.get("reveal_claim", ""), "%s (uncertain)" % InvNPCData.get_display_name(npc_id),
			lie.get("reveal_status", InfoRecord.STATUS_RUMOR))
	var reputation_delta: int = lie.get("reputation_delta", 0)
	if reputation_delta != 0:
		InvGameState.add_reputation(reputation_delta)
	var trust_delta: int = lie.get("trust_delta", 0)
	if trust_delta != 0:
		InvRelationshipSystem.add_trust(npc_id, trust_delta)
	_show(InvNPCData.get_display_name(npc_id), lie.get("lines", ["..."]), _build_intent_buttons(npc_id))


func _do_observe(npc_id: String) -> void:
	var entry := InvNPCData.get_entry(npc_id)
	_show(InvNPCData.get_display_name(npc_id), [entry.get("observe_line", "Nothing worth noting.")],
		_build_intent_buttons(npc_id))


func _show_intent_menu(npc_id: String) -> void:
	_show(InvNPCData.get_display_name(npc_id), ["..."], _build_intent_buttons(npc_id))


# ---------------------------------------------------------------------
# Laban -- bespoke two-phase flow
# ---------------------------------------------------------------------

func _show_laban_greeting() -> void:
	var entry := InvNPCData.get_entry("laban")
	if InvGameState.has_flag("plates_obtained"):
		_show("Laban", ["We have no further business, unless you've reconsidered your terms."],
			[{"id": "leave", "label": "Leave", "action": Callable(self, "end_dialogue")}])
		return

	if not InvGameState.has_flag("laban_met"):
		_show("Laban", entry.get("greeting_first_meeting", ["..."]), _laban_pre_refusal_buttons())
		return

	var greeting: Array = entry.get("greeting_after_refusal", ["..."])
	if InvRelationshipSystem.get_trust("laban") >= 2:
		greeting = entry.get("greeting_trusted", greeting)
	_show("Laban", greeting, _laban_post_refusal_buttons())


func _laban_pre_refusal_buttons() -> Array:
	return [
		{"id": "laban_ask", "label": "Ask for the plates", "action": Callable(self, "_laban_do_first_ask")},
		{"id": "laban_observe", "label": "Observe", "action": Callable(self, "_laban_do_observe")},
		{"id": "leave", "label": "Leave", "action": Callable(self, "end_dialogue")},
	]


func _laban_do_first_ask() -> void:
	var entry := InvNPCData.get_entry("laban")
	InvGameState.set_flag("laban_met", true)
	InvInformationSystem.add_record("f_laban_distrust", "Laban",
		"Refuses to give anything valuable to a stranger -- trust has to be earned first.",
		"Laban (in person)", InfoRecord.STATUS_CONFIRMED)
	_show("Laban", entry.get("refusal_lines", ["No."]), _laban_post_refusal_buttons())


func _laban_post_refusal_buttons() -> Array:
	var entry := InvNPCData.get_entry("laban")
	var buttons: Array = [
		{"id": "laban_ask", "label": "Ask for the plates", "action": Callable(self, "_laban_do_ask")},
		{"id": "laban_persuade", "label": "Persuade", "action": Callable(self, "_laban_do_persuade")},
	]
	if InvInformationSystem.knows("f_laban_secret_motive") and not InvGameState.has_flag("laban_used_leverage"):
		buttons.append({"id": "laban_tell", "label": "Tell him what you know",
			"action": Callable(self, "_laban_do_tell_leverage")})
	buttons.append({"id": "laban_threaten", "label": "Threaten him", "action": Callable(self, "_laban_do_threaten")})
	buttons.append({"id": "laban_observe", "label": "Observe", "action": Callable(self, "_laban_do_observe")})
	buttons.append({"id": "leave", "label": "Leave", "action": Callable(self, "end_dialogue")})
	return buttons


func _laban_do_ask() -> void:
	var entry := InvNPCData.get_entry("laban")
	var threshold: int = entry.get("trust_threshold_for_plates", 3)
	if InvRelationshipSystem.get_trust("laban") >= threshold:
		_laban_give_plates()
	else:
		_show("Laban", entry.get("not_yet_lines", ["Not yet."]), _laban_post_refusal_buttons())


func _laban_give_plates() -> void:
	var entry := InvNPCData.get_entry("laban")
	InvGameState.set_flag("plates_obtained", true)
	InvInformationSystem.add_record("f_plates_obtained", "Laban", "Gave you the brass plates.",
		"Laban (in person)", InfoRecord.STATUS_CONFIRMED)
	_show("Laban", entry.get("success_lines", ["Take them."]),
		[{"id": "leave", "label": "Continue", "action": Callable(self, "_on_plates_dialogue_closed")}])


func _on_plates_dialogue_closed() -> void:
	end_dialogue()
	InvGameManager.complete_investigation()


func _laban_do_persuade() -> void:
	var entry := InvNPCData.get_entry("laban")
	var lines: Array
	if not InvRelationshipSystem.has_done_favor("laban", "persuade_cap"):
		InvRelationshipSystem.add_trust("laban", 1)
		if not InvRelationshipSystem.has_done_favor("laban", "persuade_used_1"):
			InvRelationshipSystem.mark_favor_done("laban", "persuade_used_1")
		else:
			InvRelationshipSystem.mark_favor_done("laban", "persuade_cap")
		lines = entry.get("persuade_success_lines", ["..."])
	else:
		lines = entry.get("persuade_fail_lines", ["..."])
	_show("Laban", lines, _laban_post_refusal_buttons())


func _laban_do_tell_leverage() -> void:
	var entry := InvNPCData.get_entry("laban")
	InvGameState.set_flag("laban_used_leverage", true)
	InvRelationshipSystem.add_trust("laban", 2)
	_show("Laban", entry.get("leverage_lines", ["..."]), _laban_post_refusal_buttons())


func _laban_do_threaten() -> void:
	var entry := InvNPCData.get_entry("laban")
	InvRelationshipSystem.add_trust("laban", -3)
	InvGameState.add_reputation(20)
	_show("Laban", entry.get("threaten_lines", ["..."]), _laban_post_refusal_buttons())


func _laban_do_observe() -> void:
	var entry := InvNPCData.get_entry("laban")
	var buttons := _laban_post_refusal_buttons() if InvGameState.has_flag("laban_met") else _laban_pre_refusal_buttons()
	_show("Laban", [entry.get("observe_line", "...")], buttons)


# ---------------------------------------------------------------------
# Companion vouching -- fires the moment trust crosses the threshold,
# independent of whichever dialogue (if any) is currently open.
# ---------------------------------------------------------------------

func _on_trust_changed(npc_id: String, new_trust: int) -> void:
	if npc_id != "laban_companion":
		return
	if new_trust < 4 or InvGameState.has_flag("companion_vouched"):
		return
	InvGameState.set_flag("companion_vouched", true)
	InvRelationshipSystem.add_trust("laban", 2)
	InvInformationSystem.add_record("f_companion_vouched", "Laban",
		"His companion has quietly vouched for you.", "Laban's Companion", InfoRecord.STATUS_CONFIRMED)
