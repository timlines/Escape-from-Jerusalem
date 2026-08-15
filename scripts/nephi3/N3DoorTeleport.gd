extends Area2D
## Walking through a door within the same scene -- reuses the exact
## position-assignment technique Main.gd/VSMain.gd already use to place the
## player at a spawn marker, rather than introducing a new scene-transition
## system just for this one interior.

@export var target_spawn_path: NodePath
@export var narration_lines: Array[String] = []

var _target: Node2D = null


func _ready() -> void:
	add_to_group("interactable")
	if target_spawn_path != NodePath():
		_target = get_node_or_null(target_spawn_path)


func interact() -> void:
	if _target == null:
		return
	var player := get_tree().get_first_node_in_group("player")
	if player == null:
		return
	if narration_lines.is_empty():
		player.global_position = _target.global_position
	else:
		DialogueManager.start_dialogue("", narration_lines)
		DialogueManager.dialogue_ended.connect(_on_narration_closed, CONNECT_ONE_SHOT)


func _on_narration_closed() -> void:
	var player := get_tree().get_first_node_in_group("player")
	if player != null and _target != null:
		player.global_position = _target.global_position
