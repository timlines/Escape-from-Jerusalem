extends Node2D
## Assembles one playthrough: places the player at the world's spawn point,
## clamps the camera to the world bounds, and wires world/UI signals
## together. Gameplay scenes (JerusalemWorld, Player) stay ignorant of the
## UI, and UI scenes stay ignorant of the world -- this script is the only
## place that connects them.

@onready var world: Node2D = $World
@onready var player: CharacterBody2D = $Player
@onready var interact_prompt: Control = $UI/InteractPrompt
@onready var touch_controls: CanvasLayer = $TouchControls
@onready var act_complete_screen: CanvasLayer = $ActICompleteScreen


func _ready() -> void:
	# Safety net for testing this scene directly in the editor without
	# going through the main menu / GameManager.start_game() first.
	if ObjectiveManager.current_index < 0:
		ObjectiveManager.reset()

	_place_player_at_spawn()
	_configure_camera_limits()

	player.interactable_in_range_changed.connect(_on_interactable_in_range_changed)
	GameManager.act_one_completed.connect(_on_act_one_completed)


func _place_player_at_spawn() -> void:
	var spawn: Marker2D = world.get_node("PlayerSpawn")
	player.global_position = spawn.global_position


func _configure_camera_limits() -> void:
	var bounds = world.get_node("WorldBounds")
	var camera: Camera2D = player.get_node("Camera2D")
	var rect: Rect2 = bounds.get_rect()
	camera.limit_left = int(rect.position.x)
	camera.limit_top = int(rect.position.y)
	camera.limit_right = int(rect.position.x + rect.size.x)
	camera.limit_bottom = int(rect.position.y + rect.size.y)


func _on_interactable_in_range_changed(has_target: bool) -> void:
	interact_prompt.set_prompt_visible(has_target)
	touch_controls.set_interact_highlighted(has_target)


func _on_act_one_completed() -> void:
	act_complete_screen.show_screen()
