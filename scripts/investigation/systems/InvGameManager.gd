extends Node
## InvGameManager (autoload)
##
## Scene flow for the Conversational Investigation MVP. Mirrors the
## GameManager / VSGameManager pattern in the other two prototypes but is
## fully independent (its own autoloads, its own scenes), so this build
## never touches their state.

signal investigation_completed

const MAIN_SCENE := "res://scenes/investigation/main/InvMain.tscn"
# Finishing a run sends the player back to the version-selector launcher
# (not this build's own menu), so every version's ending funnels back to
# the same place.
const MENU_SCENE := "res://scenes/launcher/LauncherMenu.tscn"

var is_complete: bool = false


func start_investigation() -> void:
	is_complete = false
	InvGameState.reset()
	InvDialogueManager.force_reset()
	get_tree().change_scene_to_file(MAIN_SCENE)


func return_to_menu() -> void:
	get_tree().change_scene_to_file(MENU_SCENE)


func complete_investigation() -> void:
	if is_complete:
		return
	is_complete = true
	investigation_completed.emit()
	AudioManager.play_sfx("success")
