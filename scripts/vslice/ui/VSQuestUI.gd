extends Control
## Shows the current quest stage text. Purely reactive to VSGameState,
## same pattern as the Act I ObjectiveUI.

@onready var objective_label: Label = $Background/Margin/Content/ObjectiveLabel


func _ready() -> void:
	VSGameState.quest_stage_changed.connect(_on_quest_stage_changed)
	objective_label.text = VSGameState.get_quest_stage_text()


func _on_quest_stage_changed(stage_text: String) -> void:
	objective_label.text = stage_text
