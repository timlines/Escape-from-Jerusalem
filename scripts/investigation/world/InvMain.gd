extends Node2D
## Assembles one Investigation MVP playthrough: places the player at the
## world's spawn point, clamps the camera to the world bounds, and wires
## world/UI signals together -- same shape as Main.gd/VSMain.gd/N3Main.gd,
## plus the extra panels this MVP adds (Journal, People, Pause, Wait).

@onready var world: Node2D = $World
@onready var player: CharacterBody2D = $Player
@onready var interact_prompt: Control = $UI/InteractPrompt
@onready var hud: Control = $UI/HUD
@onready var journal: Control = $UI/Journal
@onready var people: Control = $UI/People
@onready var pause_menu: Control = $UI/PauseMenu
@onready var touch_controls: CanvasLayer = $TouchControls
@onready var ending_screen: CanvasLayer = $EndingScreen


func _ready() -> void:
	_place_player_at_spawn()
	_configure_camera_limits()

	player.interactable_in_range_changed.connect(_on_interactable_in_range_changed)
	InvGameManager.investigation_completed.connect(_on_investigation_completed)

	hud.journal_requested.connect(_open_journal)
	hud.people_requested.connect(_open_people)
	pause_menu.resume_requested.connect(pause_menu.close)
	pause_menu.knowledge_requested.connect(func(): pause_menu.close(); _open_journal())
	pause_menu.people_requested.connect(func(): pause_menu.close(); _open_people())


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


func _on_investigation_completed() -> void:
	ending_screen.show_screen()


func _open_journal() -> void:
	people.close()
	journal.open()


func _open_people() -> void:
	journal.close()
	people.open()


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("ui_cancel"):
		return
	if InvDialogueManager.is_active:
		return
	if journal.visible:
		journal.close()
	elif people.visible:
		people.close()
	elif pause_menu.visible:
		pause_menu.close()
	else:
		pause_menu.open()
	get_viewport().set_input_as_handled()
