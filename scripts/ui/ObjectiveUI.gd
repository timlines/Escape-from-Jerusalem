extends Control
## Displays the current objective in the top-left corner. Purely reactive --
## it just listens to ObjectiveManager and never sets objective state itself.

@onready var objective_label: Label = $Background/Margin/Content/ObjectiveLabel


func _ready() -> void:
	ObjectiveManager.objective_changed.connect(_on_objective_changed)
	if ObjectiveManager.current_index >= 0:
		objective_label.text = ObjectiveManager.get_current_text()


func _on_objective_changed(objective_text: String) -> void:
	objective_label.text = objective_text
