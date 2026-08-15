extends Area2D
## Tiny, reusable interaction endpoint. Every interactable NPC in the
## vertical slice (generic wanderer, Laban, the shady contact, the family
## member) puts one of these on its InteractionArea child. It just forwards
## to the owning node's on_interact() -- the actual behavior differs per
## NPC type but they all implement the same on_interact() contract, so the
## player/interaction system never needs to know which kind of NPC it's
## looking at.

func _ready() -> void:
	add_to_group("interactable")


func interact() -> void:
	var owner_node := get_parent()
	if owner_node != null and owner_node.has_method("on_interact"):
		owner_node.on_interact()
