extends Control
## Knowledge Journal: every InfoRecord the player has learned, grouped by
## subject, showing the claim, source, confidence, and age -- evidence,
## not a solution. Rows are generated in code from InvInformationSystem
## rather than hand-authored, so it always reflects exactly what the
## player has actually learned.

@onready var content: VBoxContainer = $Background/Margin/Layout/Scroll/Content
@onready var close_button: Button = $Background/Margin/Layout/Header/CloseButton


func _ready() -> void:
	visible = false
	close_button.pressed.connect(close)


func open() -> void:
	refresh()
	visible = true


func close() -> void:
	visible = false


func refresh() -> void:
	for child in content.get_children():
		child.queue_free()

	var subjects := InvInformationSystem.get_subjects_in_order()
	if subjects.is_empty():
		var empty_label := Label.new()
		empty_label.text = "You haven't learned anything yet. Go talk to people, or look around."
		empty_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		content.add_child(empty_label)
		return

	for subject in subjects:
		var header := Label.new()
		header.text = subject.to_upper()
		header.add_theme_font_size_override("font_size", 22)
		content.add_child(header)

		for record in InvInformationSystem.get_records_for_subject(subject):
			content.add_child(_build_record_row(record))

		var spacer := Control.new()
		spacer.custom_minimum_size = Vector2(0, 14)
		content.add_child(spacer)


func _build_record_row(record: InfoRecord) -> Control:
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 2)

	var claim_label := Label.new()
	claim_label.text = "%s %s" % [record.status_glyph(), record.claim]
	claim_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	claim_label.add_theme_font_size_override("font_size", 18)
	box.add_child(claim_label)

	var detail_label := Label.new()
	detail_label.text = "    %s · %s · %s confidence, %s" % [
		record.source, record.status, record.confidence_label(InvGameState.total_minutes),
		record.age_label(InvGameState.total_minutes),
	]
	detail_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	detail_label.add_theme_font_size_override("font_size", 14)
	detail_label.modulate = Color(0.8, 0.8, 0.8, 1)
	box.add_child(detail_label)

	return box
