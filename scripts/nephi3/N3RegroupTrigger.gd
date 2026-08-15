extends Area2D
## Marks the spot where the brothers were waiting. Walking back into it
## after Laban's refusal closes out the scene (1 Nephi 3:14). Before the
## refusal has happened, walking through here does nothing -- N3Main.gd
## decides what to do with the signal.

signal reached


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		reached.emit()
