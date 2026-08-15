extends Control
## Top-level entry point for the project -- what an itch.io player actually
## sees on launch. Lists playable scenes as simple buttons, built from a
## small data-driven array so another scripture scene can be added later
## by appending one entry here, without reworking this menu.

const AVAILABLE_SCENES: Array[Dictionary] = [
	{
		"title": "Play -- Laman and Laban (1 Nephi 3:9-14)",
		"scene_path": "res://scenes/nephi3/main/N3Main.tscn",
	},
]

@onready var button_list: VBoxContainer = $Center/Box/ButtonList


func _ready() -> void:
	for entry in AVAILABLE_SCENES:
		var button := Button.new()
		button.text = entry["title"]
		button.custom_minimum_size = Vector2(420, 64)
		button.pressed.connect(_on_scene_button_pressed.bind(entry["scene_path"]))
		button_list.add_child(button)


func _on_scene_button_pressed(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
