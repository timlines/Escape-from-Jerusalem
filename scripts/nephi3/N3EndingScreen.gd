extends CanvasLayer
## End-of-scene screen for 1 Nephi 3:9-14. Shown once Laman has reported
## back to his brothers.

@onready var menu_button: Button = $Overlay/Center/Box/MenuButton


func _ready() -> void:
	visible = false
	menu_button.pressed.connect(_on_menu_button_pressed)


func show_screen() -> void:
	visible = true
	AudioManager.play_sfx("success")


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/launcher/LauncherMenu.tscn")
