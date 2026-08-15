extends Node
## VSGameState (autoload) -- single source of truth for the "Escaping
## Jerusalem" vertical slice: resources, relationship/suspicion flags,
## known facts, and quest stage. Deliberately plain int/bool fields and a
## fact set rather than a full inventory/reputation/save system, matching
## the MVP scope ("a small number of variables is sufficient").

signal resource_changed
signal flags_changed
signal fact_learned(fact_id: String)
signal quest_stage_changed(stage_text: String)

const QUEST_STAGES: Array[String] = [
	"Explore Jerusalem and learn what you can",
	"Find Laban, and learn how to deal with him",
	"Decide how to get the plates from Laban",
	"Return home with the plates",
]

# --- Resources ---
var gold: int = 15
var has_family_heirloom: bool = true
var food: int = 5

# --- Relationship / consequence flags ---
var suspicion: int = 0 # 0-100, higher = more attention drawn
var merchant_relationship: int = 0 # -100..100, Laban specifically
var family_trust: int = 50 # 0-100

# --- Quest flags ---
var plates_obtained: bool = false
var stole_plates: bool = false
var obtained_method: String = "" # "trade" | "persuade" | "theft"
var quest_stage_index: int = 0

var _known_facts: Dictionary = {}


func reset() -> void:
	gold = 15
	has_family_heirloom = true
	food = 5
	suspicion = 0
	merchant_relationship = 0
	family_trust = 50
	plates_obtained = false
	stole_plates = false
	obtained_method = ""
	quest_stage_index = 0
	_known_facts.clear()
	resource_changed.emit()
	flags_changed.emit()
	quest_stage_changed.emit(QUEST_STAGES[0])


func learn_fact(fact_id: String) -> void:
	if _known_facts.has(fact_id):
		return
	_known_facts[fact_id] = true
	fact_learned.emit(fact_id)
	# Learning where Laban is marks the point where the vague "explore and
	# learn" objective sharpens into "find and deal with this specific
	# person" -- centralized here so NPC scripts don't need to know about
	# quest stage numbers themselves.
	if fact_id == "laban_location":
		set_quest_stage(1)


func knows(fact_id: String) -> bool:
	return _known_facts.has(fact_id)


## Quest stage only ever moves forward -- multiple NPCs/events can point at
## the same stage index without accidentally rewinding progress.
func set_quest_stage(index: int) -> void:
	if index <= quest_stage_index or index >= QUEST_STAGES.size():
		return
	quest_stage_index = index
	quest_stage_changed.emit(QUEST_STAGES[quest_stage_index])


func get_quest_stage_text() -> String:
	return QUEST_STAGES[quest_stage_index]


func add_gold(amount: int) -> void:
	gold = max(0, gold + amount)
	resource_changed.emit()


func add_suspicion(amount: int) -> void:
	suspicion = clampi(suspicion + amount, 0, 100)
	flags_changed.emit()


func add_merchant_relationship(amount: int) -> void:
	merchant_relationship = clampi(merchant_relationship + amount, -100, 100)
	flags_changed.emit()


func add_family_trust(amount: int) -> void:
	family_trust = clampi(family_trust + amount, 0, 100)
	flags_changed.emit()


func give_away_heirloom() -> void:
	has_family_heirloom = false
	resource_changed.emit()


func mark_plates_obtained(method: String) -> void:
	if plates_obtained:
		return
	plates_obtained = true
	obtained_method = method
	if method == "theft":
		stole_plates = true
	flags_changed.emit()
	set_quest_stage(3)


func suspicion_label() -> String:
	if suspicion < 20:
		return "Low"
	if suspicion < 50:
		return "Moderate"
	return "High"
