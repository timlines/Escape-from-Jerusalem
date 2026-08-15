extends Node
## GameManager (autoload)
##
## Owns high-level game flow: starting a new run, restarting, and marking
## Act I as complete. Keeps scene-transition logic out of gameplay scripts.

signal act_one_completed

const MAIN_SCENE := "res://scenes/main/Main.tscn"
const MAIN_MENU_SCENE := "res://scenes/main/MainMenu.tscn"

var act_one_complete: bool = false


func start_game() -> void:
	# Reset run-scoped state so a restart behaves like a fresh playthrough.
	act_one_complete = false
	ObjectiveManager.reset()
	DialogueManager.force_reset()
	get_tree().change_scene_to_file(MAIN_SCENE)


func return_to_main_menu() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_SCENE)


func complete_act_one() -> void:
	if act_one_complete:
		return
	act_one_complete = true
	act_one_completed.emit()
