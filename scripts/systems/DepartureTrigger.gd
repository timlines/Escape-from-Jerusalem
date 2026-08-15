extends Area2D
## Act I finish line. When the player reaches the city exit, mark Act I
## complete via GameManager -- the UI listens for that signal to show the
## completion screen. No dialogue/interact button needed; reaching the
## spot is the trigger, matching the departure-from-the-city moment.

var _fired: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if _fired or not body.is_in_group("player"):
		return
	_fired = true
	GameManager.complete_act_one()
