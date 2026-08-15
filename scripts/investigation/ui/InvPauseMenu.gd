extends Control
## Pause menu: Resume / Knowledge / People / Return to Main Menu, per the
## design brief's UI requirements. Knowledge and People just forward to
## InvMain, which owns the actual journal/people panels.

signal resume_requested
signal knowledge_requested
signal people_requested

@onready var resume_button: Button = $Background/Margin/Box/ResumeButton
@onready var knowledge_button: Button = $Background/Margin/Box/KnowledgeButton
@onready var people_button: Button = $Background/Margin/Box/PeopleButton
@onready var menu_button: Button = $Background/Margin/Box/MenuButton


func _ready() -> void:
	visible = false
	resume_button.pressed.connect(func(): resume_requested.emit())
	knowledge_button.pressed.connect(func(): knowledge_requested.emit())
	people_button.pressed.connect(func(): people_requested.emit())
	menu_button.pressed.connect(func(): InvGameManager.return_to_menu())


func open() -> void:
	visible = true


func close() -> void:
	visible = false
