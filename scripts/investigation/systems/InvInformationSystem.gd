extends Node
## InvInformationSystem (autoload)
##
## Owns every InfoRecord the player has learned. One record per fact_id --
## re-learning the same fact from a second source upgrades/corroborates the
## existing record rather than duplicating it, which is what lets
## contradiction and corroboration actually mean something.

signal record_added(fact_id: String)
signal record_updated(fact_id: String)

## fact_id -> Array[String] of fact_ids that directly contradict it. Kept
## as flat data (not code) per the design brief's "information as data"
## principle. Only needs to be declared on one side of each pair.
const CONTRADICTIONS: Dictionary = {
	"f_laban_gate_recent": ["f_laban_gate_yesterday"],
}

## fact_id -> Array[String] of fact_ids that, once also known, corroborate
## it (upgrade its status toward Corroborated).
const CORROBORATIONS: Dictionary = {
	"f_laban_gate_recent": ["f_footprints_stable", "f_cloak_seen_north", "f_sandal_prints_gate"],
	"f_laban_stable_rumor": ["f_footprints_stable"],
	"f_laban_bought_cloak": ["f_cloak_seen_north"],
}

var _records: Dictionary = {} # fact_id -> InfoRecord


func reset() -> void:
	_records.clear()


func knows(fact_id: String) -> bool:
	return _records.has(fact_id)


func get_record(fact_id: String) -> InfoRecord:
	return _records.get(fact_id)


## Adds a new record, or -- if the same fact is reported again -- treats it
## as a fresh sighting (bumps the timestamp) without duplicating it.
func add_record(fact_id: String, subject: String, claim: String, source: String,
		status: String) -> void:
	if _records.has(fact_id):
		var existing: InfoRecord = _records[fact_id]
		existing.recorded_at_minute = InvGameState.total_minutes
		record_updated.emit(fact_id)
	else:
		var record := InfoRecord.new(fact_id, subject, claim, source, status,
			InvGameState.total_minutes)
		_records[fact_id] = record
		record_added.emit(fact_id)
	_apply_contradictions(fact_id)
	_apply_corroborations(fact_id)


func _apply_contradictions(fact_id: String) -> void:
	var partners: Array = CONTRADICTIONS.get(fact_id, [])
	# Also check the reverse direction, since CONTRADICTIONS only lists
	# each pair once.
	for other_id in CONTRADICTIONS.keys():
		if CONTRADICTIONS[other_id].has(fact_id) and not partners.has(other_id):
			partners.append(other_id)

	for other_id in partners:
		if not _records.has(other_id):
			continue
		var mine: InfoRecord = _records[fact_id]
		var theirs: InfoRecord = _records[other_id]
		mine.status = InfoRecord.STATUS_CONTRADICTED
		theirs.status = InfoRecord.STATUS_CONTRADICTED
		if not mine.contradicts.has(other_id):
			mine.contradicts.append(other_id)
		if not theirs.contradicts.has(fact_id):
			theirs.contradicts.append(fact_id)
		record_updated.emit(fact_id)
		record_updated.emit(other_id)


func _apply_corroborations(fact_id: String) -> void:
	# Case 1: the fact just learned is itself listed as a corroborator of
	# something already known.
	for target_id in CORROBORATIONS.keys():
		var supporters: Array = CORROBORATIONS[target_id]
		if supporters.has(fact_id) and _records.has(target_id):
			_upgrade_to_corroborated(target_id)

	# Case 2: the fact just learned already has corroborators on record.
	var supporters: Array = CORROBORATIONS.get(fact_id, [])
	for supporter_id in supporters:
		if _records.has(supporter_id):
			_upgrade_to_corroborated(fact_id)
			break


func _upgrade_to_corroborated(fact_id: String) -> void:
	var record: InfoRecord = _records[fact_id]
	if record.status == InfoRecord.STATUS_CONTRADICTED:
		return # A contradiction takes priority over a corroboration.
	if record.status != InfoRecord.STATUS_CORROBORATED:
		record.status = InfoRecord.STATUS_CORROBORATED
		record_updated.emit(fact_id)


## Subjects in the order the player first learned something about them --
## keeps the Journal grouping stable rather than re-sorting every frame.
func get_subjects_in_order() -> Array[String]:
	var seen: Array[String] = []
	for fact_id in _records.keys():
		var subject: String = _records[fact_id].subject
		if not seen.has(subject):
			seen.append(subject)
	return seen


func get_records_for_subject(subject: String) -> Array[InfoRecord]:
	var result: Array[InfoRecord] = []
	for record in _records.values():
		if record.subject == subject:
			result.append(record)
	result.sort_custom(func(a, b): return a.recorded_at_minute < b.recorded_at_minute)
	return result


func record_count() -> int:
	return _records.size()
