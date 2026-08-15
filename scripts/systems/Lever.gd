extends Area2D
## The Act I demonstrative puzzle piece: an interactable lever that opens a
## target Gate. Wire `target_gate_path` to a Gate node in the same scene
## from the editor -- no code changes needed to reuse this for a different
## gate elsewhere.

@export var target_gate_path: NodePath
@export var narration_lines: Array[String] = [
	"You pull the lever.",
	"Somewhere nearby, something heavy shifts.",
]

var _target_gate: Node = null
var _activated: bool = false

@onready var visual: Polygon2D = $Visual


func _ready() -> void:
	add_to_group("interactable")
	if target_gate_path != NodePath():
		_target_gate = get_node_or_null(target_gate_path)


func interact() -> void:
	if _activated:
		return
	_activated = true
	visual.color = Color(0.25, 0.8, 0.35, 1)
	DialogueManager.start_dialogue("", narration_lines)
	if _target_gate != null and _target_gate.has_method("open"):
		_target_gate.open()
