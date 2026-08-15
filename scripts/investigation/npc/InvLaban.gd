extends CharacterBody2D
## Laban -- holds the brass plates. Same routine-driven movement as
## InvNPC, but interaction opens the bespoke two-phase encounter in
## InvDialogueManager (open_laban()) instead of the generic ask/tell/offer
## engine, since his first refusal and the trust-earning arc that follows
## are the critical path of the whole MVP.

const NPC_ID := "laban"
const SPEED: float = 55.0
const ARRIVAL_DISTANCE: float = 6.0

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	add_to_group("inv_npc")
	var entry := InvNPCData.get_entry(NPC_ID)
	var sprite_path: String = entry.get("sprite", "")
	if sprite_path != "":
		sprite.texture = load(sprite_path)
	call_deferred("_snap_to_start")


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
	var zone_id := InvNPCDirector.get_npc_zone(NPC_ID)
	var h := hash(NPC_ID)
	var offset := Vector2((h % 41) - 20, ((h / 41) % 41) - 20)
	return InvNPCDirector.get_zone_position(zone_id) + offset


func on_interact() -> void:
	InvDialogueManager.open_laban()
