extends Control
## Compact status panel: the small number of resources/flags the design
## calls for (gold, the family heirloom, suspicion, whether the plates are
## in hand yet). Deliberately not a full inventory screen -- just enough
## for the player to see their situation at a glance.

@onready var gold_label: Label = $Background/Margin/Content/GoldLabel
@onready var heirloom_label: Label = $Background/Margin/Content/HeirloomLabel
@onready var suspicion_label: Label = $Background/Margin/Content/SuspicionLabel
@onready var plates_label: Label = $Background/Margin/Content/PlatesLabel


func _ready() -> void:
	VSGameState.resource_changed.connect(_refresh)
	VSGameState.flags_changed.connect(_refresh)
	_refresh()


func _refresh() -> void:
	gold_label.text = "Gold: %d" % VSGameState.gold
	heirloom_label.text = "Heirloom: %s" % ("Yes" if VSGameState.has_family_heirloom else "Given away")
	suspicion_label.text = "Suspicion: %s" % VSGameState.suspicion_label()
	plates_label.text = "Plates: %s" % ("Obtained" if VSGameState.plates_obtained else "Not yet")
