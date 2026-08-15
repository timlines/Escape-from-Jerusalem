extends Control
## Entry point for the Conversational Investigation MVP. Only job: start
## (or restart) a run. Matches the MainMenu.gd / VSMainMenu.gd pattern.

@onready var start_button: Button = $Center/Box/StartButton


func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)


func _on_start_pressed() -> void:
	InvGameManager.start_investigation()
