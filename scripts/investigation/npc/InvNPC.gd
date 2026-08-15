extends CharacterBody2D
## Generic routine-driven NPC. Covers eight of the ten cast members
## (everyone except Laban, who needs bespoke two-phase dialogue logic).
## Appearance and all dialogue content come from InvNPCData, keyed by
## npc_id -- this script only knows how to walk toward wherever
## InvNPCDirector currently says this NPC belongs, and how to open a
## conversation when interacted with.

const SPEED: float = 60.0
const ARRIVAL_DISTANCE: float = 6.0

@export var npc_id: String = ""

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	add_to_group("inv_npc")
	_apply_appearance()
	call_deferred("_snap_to_start")


func _apply_appearance() -> void:
	var entry := InvNPCData.get_entry(npc_id)
	var sprite_path: String = entry.get("sprite", "")
	if sprite_path != "":
		sprite.texture = load(sprite_path)
	sprite.modulate = entry.get("modulate", Color(1, 1, 1, 1))


func _snap_to_start() -> void:
	global_position = _target_position()


func _physics_process(_delta: float) -> void:
	var target := _target_position()
	var to_target := target - global_position
	if to_target.length() > ARRIVAL_DISTANCE:
		velocity = to_target.normalized() * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()


func _target_position() -> Vector2:
	var zone_id := InvNPCDirector.get_npc_zone(npc_id)
	return InvNPCDirector.get_zone_position(zone_id) + _spread_offset()


## Small deterministic per-NPC offset so two NPCs sharing a zone (e.g. both
## gate guards) don't stand exactly on top of each other.
func _spread_offset() -> Vector2:
	var h := hash(npc_id)
	return Vector2((h % 41) - 20, ((h / 41) % 41) - 20)


## Called by InvInteractionForwarder when the player interacts with this NPC.
func on_interact() -> void:
	InvDialogueManager.open_npc(npc_id)
