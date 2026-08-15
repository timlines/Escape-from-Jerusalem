extends Node
## VSGameManager (autoload) -- scene flow for the vertical slice. Mirrors
## the Act I GameManager pattern but is kept fully separate (own autoload,
## own scenes) so the two prototypes don't interfere with each other.

signal slice_completed

const MAIN_SCENE := "res://scenes/vslice/main/VSMain.tscn"
const MENU_SCENE := "res://scenes/vslice/main/VSMainMenu.tscn"

var slice_complete: bool = false


func start_slice() -> void:
	slice_complete = false
	VSGameState.reset()
	VSDialogueManager.force_reset()
	get_tree().change_scene_to_file(MAIN_SCENE)


func return_to_menu() -> void:
	get_tree().change_scene_to_file(MENU_SCENE)


func complete_slice() -> void:
	if slice_complete:
		return
	slice_complete = true
	slice_completed.emit()
