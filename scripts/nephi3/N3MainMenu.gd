extends Control
## Minimal entry point for this scene, matching the existing menu pattern.
## Not wired as the project's default scene -- open this scene directly
## (or N3Main.tscn) and run it to play through 1 Nephi 3:9-14.

@onready var start_button: Button = $Center/Box/StartButton


func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)


func _on_start_pressed() -> void:
	AudioManager.play_sfx("interact")
	get_tree().change_scene_to_file("res://scenes/nephi3/main/N3Main.tscn")
