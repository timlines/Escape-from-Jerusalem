extends CharacterBody2D
## Vertical-slice player controller. Same shape as the Act I Player.gd
## (8-directional, collision-aware movement; keyboard and touch both drive
## the same code path) but talks to the vslice-specific VSDialogueManager
## instead of the Act I one, since the two prototypes are kept independent.

signal interactable_in_range_changed(has_target: bool)

const SPEED: float = 200.0
const FOOTSTEP_INTERVAL: float = 0.35
const FOOTSTEP_MIN_SPEED: float = 10.0

var _nearby_interactables: Array[Area2D] = []
var _current_target: Area2D = null
var _footstep_timer: float = 0.0

@onready var interaction_area: Area2D = $InteractionArea


func _ready() -> void:
	add_to_group("vs_player")
	interaction_area.area_entered.connect(_on_interaction_area_entered)
	interaction_area.area_exited.connect(_on_interaction_area_exited)


func _physics_process(delta: float) -> void:
	velocity = _get_movement_input() * SPEED
	move_and_slide()
	_update_footsteps(delta)

	if _wants_interact():
		_try_interact()


func _update_footsteps(delta: float) -> void:
	if velocity.length() < FOOTSTEP_MIN_SPEED:
		_footstep_timer = 0.0
		return
	_footstep_timer -= delta
	if _footstep_timer <= 0.0:
		_footstep_timer = FOOTSTEP_INTERVAL
		AudioManager.play_sfx("step")


func _get_movement_input() -> Vector2:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	input_vector += TouchInput.movement
	if input_vector.length() > 1.0:
		input_vector = input_vector.normalized()
	return input_vector


func _wants_interact() -> bool:
	return Input.is_action_just_pressed("interact") or TouchInput.consume_interact_press()


func _try_interact() -> void:
	if VSDialogueManager.is_active:
		return
	if _current_target != null and _current_target.has_method("interact"):
		_current_target.interact()
		AudioManager.play_sfx("interact")


func _on_interaction_area_entered(area: Area2D) -> void:
	if not area.is_in_group("interactable"):
		return
	if not _nearby_interactables.has(area):
		_nearby_interactables.append(area)
	_update_target()


func _on_interaction_area_exited(area: Area2D) -> void:
	_nearby_interactables.erase(area)
	_update_target()


func _update_target() -> void:
	var previous_had_target := _current_target != null
	_current_target = null
	var closest_distance := INF

	for area in _nearby_interactables:
		if not is_instance_valid(area):
			continue
		var distance := global_position.distance_to(area.global_position)
		if distance < closest_distance:
			closest_distance = distance
			_current_target = area

	var has_target := _current_target != null
	if has_target != previous_had_target:
		interactable_in_range_changed.emit(has_target)
