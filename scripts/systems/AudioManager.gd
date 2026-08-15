extends Node
## AudioManager (autoload)
##
## Shared, stateless audio playback used by every version in the project
## -- the launcher and all four playable builds. It holds no game state
## and no knowledge of any specific prototype's systems (same spirit as
## TouchInput), so it's safe for all of them to call into without
## coupling to each other. One ambient loop plays continuously from boot
## through the launcher and every version; a small pooled set of
## AudioStreamPlayers handles one-shot SFX so overlapping sounds don't
## cut each other off.

const MUSIC_PATH := "res://assets/audio/music/ambient_loop.wav"
const SFX_PATHS := {
	"step": "res://assets/audio/sfx/step.wav",
	"interact": "res://assets/audio/sfx/interact.wav",
	"positive": "res://assets/audio/sfx/positive.wav",
	"negative": "res://assets/audio/sfx/negative.wav",
	"success": "res://assets/audio/sfx/success.wav",
}

const SFX_POOL_SIZE := 4
const MUSIC_VOLUME_DB := -16.0
const SFX_VOLUME_DB := -6.0

var _music_player: AudioStreamPlayer
var _sfx_players: Array[AudioStreamPlayer] = []
var _sfx_pool_index: int = 0
var _sfx_cache: Dictionary = {} # name -> AudioStream


func _ready() -> void:
	_music_player = AudioStreamPlayer.new()
	_music_player.volume_db = MUSIC_VOLUME_DB
	add_child(_music_player)

	for i in SFX_POOL_SIZE:
		var player := AudioStreamPlayer.new()
		player.volume_db = SFX_VOLUME_DB
		add_child(player)
		_sfx_players.append(player)

	play_music()


## Starts the ambient loop if it isn't already playing. Safe to call from
## any version's menu/start flow -- it's a no-op once music is running,
## so the loop is never accidentally restarted on a scene change.
func play_music() -> void:
	if _music_player.playing:
		return
	var stream: Resource = load(MUSIC_PATH)
	if stream == null:
		return
	if stream is AudioStreamWAV:
		stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
	_music_player.stream = stream
	_music_player.play()


func stop_music() -> void:
	_music_player.stop()


## Plays a short one-shot sound by name (see SFX_PATHS). Unknown names
## are ignored rather than erroring, so a typo in a call site is silent
## rather than crashing a playthrough.
func play_sfx(sfx_name: String) -> void:
	if not SFX_PATHS.has(sfx_name):
		return
	var stream: Resource = _sfx_cache.get(sfx_name)
	if stream == null:
		stream = load(SFX_PATHS[sfx_name])
		if stream == null:
			return
		_sfx_cache[sfx_name] = stream

	var player: AudioStreamPlayer = _sfx_players[_sfx_pool_index]
	_sfx_pool_index = (_sfx_pool_index + 1) % _sfx_players.size()
	player.stream = stream
	player.play()
