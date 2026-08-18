extends Node
## InvGameState (autoload)
##
## Single source of truth for world time, the player's current location,
## and small one-off story flags. Time is the engine behind WAIT: whoever
## reads total_minutes (InformationSystem for aging, NPCDirector for
## routines, HUD for the clock) all derive from this one counter.

signal time_advanced(total_minutes: int)
signal time_block_changed(block_name: String)
signal location_changed(zone_id: String)
signal flag_changed(flag_name: String, value: bool)
signal reputation_changed(value: int)

const MORNING_START := 360    # 6:00 AM
const AFTERNOON_START := 720  # 12:00 PM
const EVENING_START := 1020   # 5:00 PM
const NIGHT_START := 1260     # 9:00 PM
const BLOCK_NAMES: Array[String] = ["Morning", "Afternoon", "Evening", "Night"]
const DAY_START_MINUTE := 480 # 8:00 AM on Day 1

var total_minutes: int = DAY_START_MINUTE
var current_location: String = "family_house"
var reputation: int = 0 # 0-100, rises when the player lies/threatens and is noticed

var _flags: Dictionary = {} # String -> bool


func reset() -> void:
	total_minutes = DAY_START_MINUTE
	current_location = "family_house"
	reputation = 0
	_flags.clear()
	InvInformationSystem.reset()
	InvRelationshipSystem.reset()
	InvNPCDirector.reset()
	InvDialogueManager.reset()


func has_flag(flag_name: String) -> bool:
	return _flags.get(flag_name, false)


func set_flag(flag_name: String, value: bool = true) -> void:
	if _flags.get(flag_name, false) == value:
		return
	_flags[flag_name] = value
	flag_changed.emit(flag_name, value)


func add_reputation(amount: int) -> void:
	reputation = clampi(reputation + amount, 0, 100)
	reputation_changed.emit(reputation)


func set_location(zone_id: String) -> void:
	if current_location == zone_id:
		return
	current_location = zone_id
	location_changed.emit(zone_id)


## The heart of WAIT. Advancing time ages every InfoRecord (computed
## lazily from total_minutes, so nothing needs to be touched here) and,
## when a time-block boundary is crossed, re-rolls every NPC's routine
## location.
func advance_time(minutes: int) -> void:
	var old_block := get_block_index()
	total_minutes += minutes
	time_advanced.emit(total_minutes)
	var new_block := get_block_index()
	if new_block != old_block:
		time_block_changed.emit(BLOCK_NAMES[new_block])
		InvNPCDirector.reroll_all()


func get_block_index() -> int:
	var minute_of_day := total_minutes % 1440

	if minute_of_day >= MORNING_START and minute_of_day < AFTERNOON_START:
		return 0 # Morning

	if minute_of_day >= AFTERNOON_START and minute_of_day < EVENING_START:
		return 1 # Afternoon

	if minute_of_day >= EVENING_START and minute_of_day < NIGHT_START:
		return 2 # Evening

	return 3 # Night


func get_block_name() -> String:
	return BLOCK_NAMES[get_block_index()]


func get_day() -> int:
	return int(total_minutes / 1440) + 1


func get_clock_string() -> String:
	var minute_of_day := total_minutes % 1440
	var hour24 := int(minute_of_day / 60)
	var minute := minute_of_day % 60
	var suffix := "AM" if hour24 < 12 else "PM"
	var hour12 := hour24 % 12
	if hour12 == 0:
		hour12 = 12
	return "Day %d · %d:%02d %s" % [get_day(), hour12, minute, suffix]
