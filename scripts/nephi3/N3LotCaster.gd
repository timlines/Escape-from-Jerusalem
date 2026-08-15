extends Area2D
## The casting of lots (1 Nephi 3:11) as a deliberate, player-triggered
## action -- not something that happens automatically from talking to a
## brother. Scripture doesn't describe the physical mechanism, so this
## uses a simple, generic set of small tokens rather than presenting any
## specific practice as historical fact. The outcome is always fixed --
## the lot falls to Laman -- this is never a player choice.

signal lots_cast

const TOKEN_COLOR := Color(0.55, 0.5, 0.42, 1.0)
const CHOSEN_COLOR := Color(0.85, 0.7, 0.3, 1.0)
const TOKEN_COUNT := 4
const CHOSEN_INDEX := 3

@export var not_ready_lines: Array[String] = [
	"We should speak with one another before we decide who will go.",
]
@export var intro_lines: Array[String] = [
	"Nephi lays out four small stones -- one for each of you.",
]
@export var result_lines: Array[String] = [
	"Laman's stone is drawn. The lot falls to him.",
]
@export var already_cast_lines: Array[String] = [
	"The lot has already fallen to Laman.",
]

var _all_ready: bool = false
var _has_cast: bool = false
var _tokens: Array[Polygon2D] = []


func _ready() -> void:
	add_to_group("interactable")


func set_ready(is_ready: bool) -> void:
	_all_ready = is_ready


func interact() -> void:
	if _has_cast:
		DialogueManager.start_dialogue("", already_cast_lines)
		return
	if not _all_ready:
		DialogueManager.start_dialogue("", not_ready_lines)
		return
	_has_cast = true
	DialogueManager.start_dialogue("", intro_lines)
	DialogueManager.dialogue_ended.connect(_on_intro_closed, CONNECT_ONE_SHOT)


func _on_intro_closed() -> void:
	_spawn_tokens()
	var timer := get_tree().create_timer(1.1)
	timer.timeout.connect(_on_cast_delay_finished)


func _on_cast_delay_finished() -> void:
	_resolve_tokens()
	DialogueManager.start_dialogue("", result_lines)
	DialogueManager.dialogue_ended.connect(_on_result_closed, CONNECT_ONE_SHOT)


func _on_result_closed() -> void:
	lots_cast.emit()


func _spawn_tokens() -> void:
	for i in range(TOKEN_COUNT):
		var token := Polygon2D.new()
		token.color = TOKEN_COLOR
		token.polygon = PackedVector2Array([
			Vector2(-6, -6), Vector2(6, -6), Vector2(6, 6), Vector2(-6, 6),
		])
		token.position = Vector2(-30 + i * 20, -40)
		add_child(token)
		_tokens.append(token)


func _resolve_tokens() -> void:
	for i in range(_tokens.size()):
		if i == CHOSEN_INDEX:
			_tokens[i].color = CHOSEN_COLOR
			_tokens[i].scale = Vector2(1.8, 1.8)
		else:
			_tokens[i].queue_free()
