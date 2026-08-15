extends Control
## Top-level entry point for the project -- the version selector an
## itch.io player (or anyone opening this project) actually sees on
## launch. Makes the project's development history visible: every
## previous playable iteration stays reachable here, and the newest build
## is clearly marked Current. Built from a small data-driven array so a
## fifth version can be added later by appending one entry, without
## reworking this menu.

const AVAILABLE_VERSIONS: Array[Dictionary] = [
	{
		"version": "01",
		"title": "Original Prototype",
		"subtitle": "Act I Greybox",
		"description": "The first playable slice: explore Jerusalem, find your family, and prepare to leave the city before the gates close.",
		"status": "Prototype",
		"scene_path": "res://scenes/main/MainMenu.tscn",
	},
	{
		"version": "02",
		"title": "Vertical Slice",
		"subtitle": "Escaping Jerusalem: The Brass Plates",
		"description": "An earlier attempt at the Laban storyline: gather rumors around the city, then trade, persuade, or steal your way to the plates.",
		"status": "Experimental",
		"scene_path": "res://scenes/vslice/main/VSMainMenu.tscn",
	},
	{
		"version": "03",
		"title": "Laman and Laban",
		"subtitle": "1 Nephi 3:9-14",
		"description": "A short scripture vignette: Laman's first, failed attempt to ask Laban outright for the plates.",
		"status": "Vignette",
		"scene_path": "res://scenes/nephi3/main/N3MainMenu.tscn",
	},
	{
		"version": "04",
		"title": "Conversational Investigation MVP",
		"subtitle": "Find Laban. Earn his trust. Obtain the plates.",
		"description": "The current build: a detective-style investigation driven by information, relationships, and trust -- not combat or inventory. Talk to people, weigh what they tell you, and figure out where Laban really is.",
		"status": "Current",
		"scene_path": "res://scenes/investigation/main/InvMainMenu.tscn",
	},
]

@onready var button_list: VBoxContainer = $Center/Box/Scroll/ButtonList
@onready var quit_button: Button = $Center/Box/QuitButton


func _ready() -> void:
	for entry in AVAILABLE_VERSIONS:
		button_list.add_child(_build_card(entry))
	quit_button.pressed.connect(_on_quit_pressed)


func _build_card(entry: Dictionary) -> Control:
	var card := PanelContainer.new()
	card.custom_minimum_size = Vector2(600, 0)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 18)
	margin.add_theme_constant_override("margin_top", 14)
	margin.add_theme_constant_override("margin_right", 18)
	margin.add_theme_constant_override("margin_bottom", 14)
	card.add_child(margin)

	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 16)
	margin.add_child(row)

	var text_box := VBoxContainer.new()
	text_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_box.add_theme_constant_override("separation", 4)
	row.add_child(text_box)

	var heading := Label.new()
	heading.text = "VERSION %s -- %s" % [entry["version"], String(entry["status"]).to_upper()]
	heading.add_theme_font_size_override("font_size", 13)
	heading.modulate = Color(0.85, 0.75, 0.45, 1) if entry["status"] == "Current" else Color(0.7, 0.68, 0.62, 1)
	text_box.add_child(heading)

	var title_label := Label.new()
	title_label.text = String(entry["title"])
	title_label.add_theme_font_size_override("font_size", 22)
	text_box.add_child(title_label)

	var subtitle_label := Label.new()
	subtitle_label.text = String(entry["subtitle"])
	subtitle_label.add_theme_font_size_override("font_size", 14)
	subtitle_label.modulate = Color(0.85, 0.83, 0.78, 1)
	text_box.add_child(subtitle_label)

	var description_label := Label.new()
	description_label.text = String(entry["description"])
	description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	description_label.custom_minimum_size = Vector2(380, 0)
	description_label.add_theme_font_size_override("font_size", 14)
	description_label.modulate = Color(0.75, 0.75, 0.72, 1)
	text_box.add_child(description_label)

	var play_button := Button.new()
	play_button.text = "PLAY"
	play_button.custom_minimum_size = Vector2(110, 48)
	play_button.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	play_button.pressed.connect(_on_play_pressed.bind(String(entry["scene_path"])))
	row.add_child(play_button)

	return card


func _on_play_pressed(scene_path: String) -> void:
	AudioManager.play_sfx("interact")
	get_tree().change_scene_to_file(scene_path)


func _on_quit_pressed() -> void:
	AudioManager.play_sfx("interact")
	get_tree().quit()
