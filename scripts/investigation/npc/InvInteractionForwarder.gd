extends Area2D
## Tiny, reusable interaction endpoint -- identical pattern to the other
## two prototypes' forwarders, duplicated here (rather than shared) so the
## Investigation MVP has zero script dependencies on the other builds.

func _ready() -> void:
	add_to_group("interactable")


func interact() -> void:
	var owner_node := get_parent()
	if owner_node != null and owner_node.has_method("on_interact"):
		owner_node.on_interact()
