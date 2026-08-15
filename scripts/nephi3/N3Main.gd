extends Node2D
## Orchestrates the 1 Nephi 3:9-14 scene: spawn/camera setup (same pattern
## as Main.gd/VSMain.gd), and the two beats that need to reach across
## nodes -- Laban's refusal repositioning the player back outside, and
## returning to the brothers afterward closing out the scene. No new
## autoload or global state; everything here is local to this scene, so a
## fresh scene load is already a clean slate.

var _laban_rejected: bool = false
var _scene_ended: bool = false
var _brothers_talked_to: Dictionary = {}

@onready var world: Node2D = $World
@onready var player: CharacterBody2D = $Player
@onready var interact_prompt: Control = $UI/InteractPrompt
@onready var touch_controls: CanvasLayer = $TouchControls
@onready var ending_screen: CanvasLayer = $N3EndingScreen


func _ready() -> void:
	_place_player_at_spawn()
	_configure_camera_limits()

	player.interactable_in_range_changed.connect(_on_interactable_in_range_changed)

	var laban: Area2D = world.get_node("Laban/InteractionArea")
	laban.rejected.connect(_on_laban_rejected)

	var regroup: Area2D = world.get_node("RegroupZone")
	regroup.reached.connect(_on_regroup_reached)

	var lot_caster: Area2D = world.get_node("LotCaster")
	for brother_name in ["Nephi", "Lemuel", "Sam"]:
		var brother: Area2D = world.get_node("%s/InteractionArea" % brother_name)
		brother.talked_to.connect(_on_brother_talked_to.bind(brother_name, lot_caster))


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


## Tracks conversations with the three brothers so the lot cannot be cast
## until the player has spoken with all of them at least once.
func _on_brother_talked_to(brother_name: String, lot_caster: Area2D) -> void:
	_brothers_talked_to[brother_name] = true
	if _brothers_talked_to.size() >= 3:
		lot_caster.set_ready(true)


## Laban has just thrust Laman out (1 Nephi 3:13). Repositions the player
## back outside the house -- the player still has to walk back to the
## brothers themselves, so "Laman fled" remains something the player does.
func _on_laban_rejected() -> void:
	_laban_rejected = true
	var exterior_spawn: Marker2D = world.get_node("ExteriorDoorSpawn")
	player.global_position = exterior_spawn.global_position


func _on_regroup_reached() -> void:
	if not _laban_rejected or _scene_ended:
		return
	_scene_ended = true
	DialogueManager.start_dialogue("Laman", [
		"Laban would not hear me.",
		"He named me a robber, and swore he would kill me. I fled his house.",
	])
	DialogueManager.dialogue_ended.connect(_on_report_closed, CONNECT_ONE_SHOT)


func _on_report_closed() -> void:
	DialogueManager.start_dialogue("", [
		"The brothers grow exceedingly sorrowful, uncertain what is now to be done.",
	])
	DialogueManager.dialogue_ended.connect(_on_final_narration_closed, CONNECT_ONE_SHOT)


func _on_final_narration_closed() -> void:
	ending_screen.show_screen()
