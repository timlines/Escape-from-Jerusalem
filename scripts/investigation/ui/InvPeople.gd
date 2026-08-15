extends Control
## People panel: the social network at a glance -- trust and attitude for
## everyone the player has met (and, by design, everyone else too, since
## simply knowing a name like "Laban's Companion" exists is not the same
## as knowing anything about them yet).

@onready var content: VBoxContainer = $Background/Margin/Layout/Scroll/Content
@onready var close_button: Button = $Background/Margin/Layout/Header/CloseButton


func _ready() -> void:
	visible = false
	close_button.pressed.connect(close)
	InvRelationshipSystem.trust_changed.connect(func(_id, _t): if visible: refresh())


func open() -> void:
	refresh()
	visible = true


func close() -> void:
	visible = false


func refresh() -> void:
	for child in content.get_children():
		child.queue_free()

	for npc_id in InvNPCData.all_npc_ids():
		content.add_child(_build_row(npc_id))


func _build_row(npc_id: String) -> Control:
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 2)

	var trust := InvRelationshipSystem.get_trust(npc_id)
	var name_label := Label.new()
	name_label.text = "%s" % InvNPCData.get_display_name(npc_id)
	name_label.add_theme_font_size_override("font_size", 18)
	box.add_child(name_label)

	var detail_label := Label.new()
	detail_label.text = "    Trust %d/5 · %s" % [trust, InvRelationshipSystem.get_attitude(npc_id)]
	detail_label.add_theme_font_size_override("font_size", 14)
	detail_label.modulate = Color(0.8, 0.8, 0.8, 1)
	box.add_child(detail_label)

	var spacer := Control.new()
	spacer.custom_minimum_size = Vector2(0, 8)
	box.add_child(spacer)

	return box
