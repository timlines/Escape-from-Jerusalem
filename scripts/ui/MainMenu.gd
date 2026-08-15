extends Control
## Temporary greybox main menu. Only job: start (or restart) a run.

@onready var start_button: Button = $Center/Box/StartButton


func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)


func _on_start_pressed() -> void:
	GameManager.start_game()
