extends Area2D
## Marks one of the eight named locations. Two jobs: tell InvGameState the
## player has entered it (drives the HUD location label and gates a few
## dialogue lines), and register this zone's NPC-standing spot with
## InvNPCDirector so routine-driven NPCs know where to walk.

@export var zone_id: String = ""


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	var spot := get_node_or_null("NPCSpot")
	var spot_position: Vector2 = spot.global_position if spot != null else global_position
	InvNPCDirector.register_zone_position(zone_id, spot_position)


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("inv_player"):
		return
	InvGameState.set_location(zone_id)
