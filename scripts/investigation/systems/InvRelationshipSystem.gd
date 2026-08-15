extends Node
## InvRelationshipSystem (autoload)
##
## Lightweight social network: trust (0-5), attitude derived from trust,
## and favors done, per NPC. Deliberately plain Dictionaries rather than a
## Resource-per-NPC graph -- matches the MVP's "playable > elegant"
## priority while still giving every NPC real, persistent state.

signal trust_changed(npc_id: String, new_trust: int)

const MIN_TRUST := 0
const MAX_TRUST := 5

var _trust: Dictionary = {} # npc_id -> int
var _favors_done: Dictionary = {} # npc_id -> Dictionary[String, bool] favor_id -> true
var _told_facts: Dictionary = {} # npc_id -> Dictionary[String, bool] fact_id -> true (one-shot "Tell")


func reset() -> void:
	_trust.clear()
	_favors_done.clear()
	_told_facts.clear()


func get_trust(npc_id: String) -> int:
	if _trust.has(npc_id):
		return _trust[npc_id]
	return InvNPCData.get_starting_trust(npc_id)


func add_trust(npc_id: String, amount: int) -> void:
	var current := get_trust(npc_id)
	var updated: int = clampi(current + amount, MIN_TRUST, MAX_TRUST)
	_trust[npc_id] = updated
	trust_changed.emit(npc_id, updated)


func get_attitude(npc_id: String) -> String:
	var trust := get_trust(npc_id)
	if trust <= 0:
		return "Distrustful"
	if trust == 1:
		return "Wary"
	if trust == 2:
		return "Cautious"
	if trust == 3:
		return "Neutral"
	if trust == 4:
		return "Friendly"
	return "Trusting"


func has_done_favor(npc_id: String, favor_id: String) -> bool:
	return _favors_done.get(npc_id, {}).has(favor_id)


func mark_favor_done(npc_id: String, favor_id: String) -> void:
	if not _favors_done.has(npc_id):
		_favors_done[npc_id] = {}
	_favors_done[npc_id][favor_id] = true


func has_told(npc_id: String, fact_id: String) -> bool:
	return _told_facts.get(npc_id, {}).has(fact_id)


func mark_told(npc_id: String, fact_id: String) -> void:
	if not _told_facts.has(npc_id):
		_told_facts[npc_id] = {}
	_told_facts[npc_id][fact_id] = true
