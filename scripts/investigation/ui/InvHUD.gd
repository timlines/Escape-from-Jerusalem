extends Control
## Minimal HUD: current location, world clock, the ever-vague standing
## objective, and the buttons that open Journal/People/Wait. Deliberately
## does not add a quest tracker -- the objective label always reads "Find
## Laban and obtain the plates," the Journal is where the player actually
## reasons about how to do that.

signal journal_requested
signal people_requested

const WAIT_OPTIONS: Array[int] = [30, 60, 120]

@onready var location_label: Label = $TopBar/Background/Margin/Content/LocationLabel
@onready var time_label: Label = $TopBar/Background/Margin/Content/TimeLabel
@onready var objective_label: Label = $ObjectivePanel/Background/Margin/ObjectiveLabel
@onready var journal_button: Button = $BottomBar/JournalButton
@onready var people_button: Button = $BottomBar/PeopleButton
@onready var wait_button: Button = $BottomBar/WaitButton
@onready var wait_popup: Panel = $WaitPopup
@onready var wait_30_button: Button = $WaitPopup/Margin/Content/Wait30Button
@onready var wait_60_button: Button = $WaitPopup/Margin/Content/Wait60Button
@onready var wait_120_button: Button = $WaitPopup/Margin/Content/Wait120Button
@onready var wait_cancel_button: Button = $WaitPopup/Margin/Content/CancelButton


func _ready() -> void:
	InvGameState.location_changed.connect(func(_zone_id): _refresh_location())
	InvGameState.time_advanced.connect(func(_minutes): _refresh_time())
	InvGameState.time_block_changed.connect(func(_block): _refresh_time())

	journal_button.pressed.connect(func(): journal_requested.emit())
	people_button.pressed.connect(func(): people_requested.emit())
	wait_button.pressed.connect(func(): wait_popup.visible = true)
	wait_30_button.pressed.connect(func(): _do_wait(WAIT_OPTIONS[0]))
	wait_60_button.pressed.connect(func(): _do_wait(WAIT_OPTIONS[1]))
	wait_120_button.pressed.connect(func(): _do_wait(WAIT_OPTIONS[2]))
	wait_cancel_button.pressed.connect(func(): wait_popup.visible = false)

	wait_popup.visible = false
	objective_label.text = "Find Laban, and obtain the plates."
	_refresh_location()
	_refresh_time()


func _do_wait(minutes: int) -> void:
	wait_popup.visible = false
	InvGameState.advance_time(minutes)


func _refresh_location() -> void:
	location_label.text = InvLocationData.get_name(InvGameState.current_location)


func _refresh_time() -> void:
	time_label.text = "%s · %s" % [InvGameState.get_clock_string(), InvGameState.get_block_name()]


func _unhandled_input(event: InputEvent) -> void:
	if InvDialogueManager.is_active:
		return
	if event.is_action_pressed("inv_journal"):
		journal_requested.emit()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("inv_people"):
		people_requested.emit()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("inv_wait"):
		wait_popup.visible = true
		get_viewport().set_input_as_handled()
