extends CanvasLayer
## End-of-slice summary. Shown once VSGameManager reports the slice is
## complete (plates obtained + family reaction seen). Reflects back the
## method used and the resulting flags so the player can see how their
## choices played out, then offers a way to restart.

const METHOD_SUMMARIES := {
	"trade": "You traded away the family's heirloom lamp in exchange for the plates.",
	"persuade": "You pieced together enough about Laban to persuade him -- no trade needed.",
	"theft": "You took the plates without permission, and without asking.",
}

@onready var summary_label: Label = $Overlay/Center/Box/SummaryLabel
@onready var menu_button: Button = $Overlay/Center/Box/MenuButton


func _ready() -> void:
	visible = false
	menu_button.pressed.connect(_on_menu_button_pressed)


func show_screen() -> void:
	summary_label.text = _build_summary()
	visible = true


func _build_summary() -> String:
	var fallback := "You obtained the plates."
	var method_text: String = METHOD_SUMMARIES.get(VSGameState.obtained_method, fallback)
	return "%s\n\nSuspicion: %s\nLaban's opinion of you: %d\nFamily trust: %d" % [
		method_text,
		VSGameState.suspicion_label(),
		VSGameState.merchant_relationship,
		VSGameState.family_trust,
	]


func _on_menu_button_pressed() -> void:
	VSGameManager.return_to_menu()
