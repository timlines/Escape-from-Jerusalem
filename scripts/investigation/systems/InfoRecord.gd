class_name InfoRecord
extends RefCounted
## A single piece of investigative information, per the design spec:
## subject/claim/source/timestamp/confidence/status as data, not hard-coded
## dialogue. InvInformationSystem owns and mutates these; everything else
## (Journal UI, NPC gating) only reads them.

## Status progression a record can carry. Plain strings rather than an enum
## so Journal UI and save-adjacent debugging can print them directly.
const STATUS_RUMOR := "Rumor"
const STATUS_REPORTED := "Reported"
const STATUS_OBSERVED := "Observed"
const STATUS_CONFIRMED := "Confirmed"
const STATUS_CORROBORATED := "Corroborated"
const STATUS_CONTRADICTED := "Contradicted"

var fact_id: String
var subject: String
var claim: String
var source: String
var status: String
var recorded_at_minute: int

## Populated by InvInformationSystem when a contradiction is detected.
var contradicts: Array[String] = []


func _init(p_fact_id: String, p_subject: String, p_claim: String, p_source: String,
		p_status: String, p_recorded_at_minute: int) -> void:
	fact_id = p_fact_id
	subject = p_subject
	claim = p_claim
	source = p_source
	status = p_status
	recorded_at_minute = p_recorded_at_minute


func age_minutes(now_minute: int) -> int:
	return max(0, now_minute - recorded_at_minute)


## Short, human-readable age string for Journal display.
func age_label(now_minute: int) -> String:
	var age := age_minutes(now_minute)
	if age < 2:
		return "just now"
	if age < 60:
		return "%d minutes ago" % age
	if age < 1440:
		var hours := age / 60
		return "%d hour%s ago" % [hours, "" if hours == 1 else "s"]
	var days := age / 1440
	return "%d day%s ago" % [days, "" if days == 1 else "s"]


## Confidence is derived from status + age rather than stored separately --
## the same claim genuinely becomes less trustworthy just by sitting
## unconfirmed, without anyone having to remember to downgrade it.
func confidence_label(now_minute: int) -> String:
	if status == STATUS_CONTRADICTED:
		return "Disputed"
	if status == STATUS_CONFIRMED or status == STATUS_CORROBORATED or status == STATUS_OBSERVED:
		var age := age_minutes(now_minute)
		return "High" if age < 720 else "Medium"
	# Rumor / Reported: confidence erodes with time.
	var age := age_minutes(now_minute)
	if age < 60:
		return "Medium" if status == STATUS_RUMOR else "High"
	if age < 240:
		return "Medium"
	return "Low"


## Small glyph used by the Journal to mirror the design brief's "✓ / ?"
## presentation without needing icon assets.
func status_glyph() -> String:
	match status:
		STATUS_CONTRADICTED:
			return "?"
		STATUS_RUMOR:
			return "~"
		_:
			return "✓" # checkmark
