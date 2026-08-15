extends CanvasLayer
## Prototype completion screen. Shown when GameManager reports Act I is
## complete; offers a single way back to the main menu so the loop
## (start -> play -> complete -> restart) can be tested end to end.

@onready var menu_button: Button = $Overlay/Center/Box/MenuButton


func _ready() -> void:
	visible = false
	menu_button.pressed.connect(_on_menu_button_pressed)


func show_screen() -> void:
	visible = true


func _on_menu_button_pressed() -> void:
	GameManager.return_to_main_menu()
