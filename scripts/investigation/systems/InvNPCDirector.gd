extends Node
## InvNPCDirector (autoload)
##
## Decides where every NPC "is" right now. Reads schedules from
## InvNPCData (a weighted list of valid zones per time block -- duplicate
## entries in a list bias the pick, which is how "usually the Stable" is
## expressed without a fixed timetable) and re-rolls whenever
## InvGameState reports a time-block change. NPC scene nodes listen for
## npc_zone_changed and walk toward the new zone's registered spot.
##
## Zone positions themselves are registered by InvWorld at runtime, so
## this system never needs to know world geometry.

signal npc_zone_changed(npc_id: String, zone_id: String)

var current_zone: Dictionary = {} # npc_id -> zone_id
var _zone_positions: Dictionary = {} # zone_id -> Vector2


func reset() -> void:
	current_zone.clear()
	for npc_id in InvNPCData.all_npc_ids():
		current_zone[npc_id] = _pick_zone(npc_id, InvGameState.get_block_name())


## Called by each InvLocationZone in InvWorld._ready() so NPC movement has
## somewhere to walk toward.
func register_zone_position(zone_id: String, world_position: Vector2) -> void:
	_zone_positions[zone_id] = world_position


func get_zone_position(zone_id: String) -> Vector2:
	return _zone_positions.get(zone_id, Vector2.ZERO)


func get_npc_zone(npc_id: String) -> String:
	if not current_zone.has(npc_id):
		current_zone[npc_id] = _pick_zone(npc_id, InvGameState.get_block_name())
	return current_zone[npc_id]


## Re-rolls every NPC's target zone for the current time block. A short
## walk (handled by the NPC scripts themselves) follows naturally since
## the position doesn't change here -- only the target does.
func reroll_all() -> void:
	var block_name := InvGameState.get_block_name()
	for npc_id in InvNPCData.all_npc_ids():
		var new_zone := _pick_zone(npc_id, block_name)
		if new_zone != current_zone.get(npc_id, ""):
			current_zone[npc_id] = new_zone
			npc_zone_changed.emit(npc_id, new_zone)


func _pick_zone(npc_id: String, block_name: String) -> String:
	var options: Array = InvNPCData.get_schedule_for_block(npc_id, block_name)
	if options.is_empty():
		return InvNPCData.get_home_zone(npc_id)
	return String(options[randi() % options.size()])
