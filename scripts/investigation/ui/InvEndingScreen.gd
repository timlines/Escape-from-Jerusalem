extends CanvasLayer
## MVP end screen. Shown once InvGameManager reports the investigation
## complete (Laban has handed over the plates).

@onready var menu_button: Button = $Overlay/Center/Box/MenuButton
@onready var play_again_button: Button = $Overlay/Center/Box/PlayAgainButton


func _ready() -> void:
	visible = false
	menu_button.pressed.connect(func(): InvGameManager.return_to_menu())
	play_again_button.pressed.connect(func(): InvGameManager.start_investigation())


func show_screen() -> void:
	visible = true
