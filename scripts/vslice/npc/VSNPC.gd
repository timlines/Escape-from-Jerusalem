extends CharacterBody2D
## Generic wandering NPC. Patrols between a few waypoints, pauses, and
## offers dialogue when interacted with. Dialogue content is exported data
## rather than code, so most NPCs in the slice (rumor-givers, vendors,
## family gossips) can all reuse this single script -- only Laban, the shady
## contact, and the family member need bespoke behavior and get their own
## scripts.

const SPEED: float = 55.0
const PAUSE_TIME_MIN: float = 1.5
const PAUSE_TIME_MAX: float = 3.5

@export var npc_name: String = "Villager"

## Shown by default, every time, unless a gated line set below applies.
@export var default_lines: Array[String] = ["..."]

## If the player already knows `requires_fact`, show `gated_lines` instead
## -- lets an NPC's dialogue change once the player has learned something
## (e.g. the beggar only explains Laban's debt once you already suspect
## something is going on).
@export var requires_fact: String = ""
@export var gated_lines: Array[String] = []

## Learned automatically the first time the player talks to this NPC.
## Empty string means this NPC doesn't teach anything.
@export var teaches_fact: String = ""

## Path to a node whose Node2D children are patrol waypoints, visited in
## order and looped. Leave empty for a stationary NPC.
@export var waypoints_path: NodePath

var _waypoints: Array[Node2D] = []
var _current_waypoint_index: int = 0
var _pause_timer: float = 0.0
var _is_paused: bool = true


func _ready() -> void:
	if waypoints_path != NodePath():
		var container := get_node_or_null(waypoints_path)
		if container != null:
			for child in container.get_children():
				if child is Node2D:
					_waypoints.append(child)
	_pause_timer = randf_range(PAUSE_TIME_MIN, PAUSE_TIME_MAX)


func _physics_process(delta: float) -> void:
	velocity = _compute_patrol_velocity(delta)
	move_and_slide()


func _compute_patrol_velocity(delta: float) -> Vector2:
	if _waypoints.is_empty():
		return Vector2.ZERO

	if _is_paused:
		_pause_timer -= delta
		if _pause_timer <= 0.0:
			_is_paused = false
		return Vector2.ZERO

	var target: Vector2 = _waypoints[_current_waypoint_index].global_position
	var to_target := target - global_position
	if to_target.length() < 4.0:
		_is_paused = true
		_pause_timer = randf_range(PAUSE_TIME_MIN, PAUSE_TIME_MAX)
		_current_waypoint_index = (_current_waypoint_index + 1) % _waypoints.size()
		return Vector2.ZERO

	return to_target.normalized() * SPEED


## Called by VSInteractionForwarder when the player interacts with this NPC.
func on_interact() -> void:
	var lines := default_lines
	if requires_fact != "" and VSGameState.knows(requires_fact) and not gated_lines.is_empty():
		lines = gated_lines
	VSDialogueManager.start_dialogue(npc_name, lines)
	if teaches_fact != "":
		VSGameState.learn_fact(teaches_fact)
