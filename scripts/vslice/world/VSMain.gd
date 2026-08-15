extends Node2D
## Assembles one vertical-slice playthrough: places the player at the
## world's spawn point, clamps the camera to the world bounds, and wires
## world/UI signals together. Mirrors the Act I Main.gd pattern.

@onready var world: Node2D = $World
@onready var player: CharacterBody2D = $Player
@onready var interact_prompt: Control = $UI/InteractPrompt
@onready var touch_controls: CanvasLayer = $TouchControls
@onready var ending_screen: CanvasLayer = $VSEndingScreen


func _ready() -> void:
	_place_player_at_spawn()
	_configure_camera_limits()

	player.interactable_in_range_changed.connect(_on_interactable_in_range_changed)
	VSGameManager.slice_completed.connect(_on_slice_completed)


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


func _on_slice_completed() -> void:
	ending_screen.show_screen()
