extends Node
## ObjectiveManager (autoload)
##
## Lightweight, linear objective tracker for the Act I greybox. Objectives
## are a plain data array rather than a full quest editor/resource graph --
## that can be swapped in later without changing how callers advance state.

signal objective_changed(objective_text: String)

const OBJECTIVES: Array[String] = [
	"Explore Jerusalem",
	"Find your family",
	"Speak with Lehi",
	"Prepare to leave Jerusalem",
]

var current_index: int = -1


func reset() -> void:
	current_index = -1
	advance_to(0)


## Moves the current objective forward to `index`. Ignores calls that would
## move backward or repeat the current objective, so multiple NPCs/triggers
## can safely reference the same index without regressing progress.
func advance_to(index: int) -> void:
	if index < 0 or index >= OBJECTIVES.size():
		return
	if index <= current_index:
		return
	current_index = index
	objective_changed.emit(OBJECTIVES[current_index])


func get_current_text() -> String:
	if current_index < 0 or current_index >= OBJECTIVES.size():
		return ""
	return OBJECTIVES[current_index]
