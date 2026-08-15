extends Node
## InvNPCData (autoload)
##
## Every NPC's knowledge, schedule, and social behavior as plain data.
## InvDialogueManager (the conversation FSM) and InvNPCDirector (the
## routine scheduler) both read from here; neither one hard-codes an NPC's
## name or lines. Adding an eleventh NPC later means adding one more entry
## to NPCS, not touching the systems that drive them.
##
## Topic entry shape (used in ask_topics):
##   id, label, requires_fact, requires_favor, min_trust,
##   lines, repeat_lines, reveals_fact, reveal_subject, reveal_claim,
##   reveal_status, trust_delta
## Favor entry shape: id, prompt_lines, requires_fact, resolve_lines,
##   not_ready_lines, trust_delta, reveals_fact/reveal_* (optional)
## Persuade entry shape: success_min_trust, success_lines, fail_lines,
##   success_trust_delta, fail_trust_delta
## Lie entry shape (guard_younger only): lines, reveals_fact/reveal_*,
##   reputation_delta

const NPCS: Dictionary = {
	"merchant": {
		"display_name": "Merchant",
		"sprite": "res://assets/vslice/characters/vendor_cloth.png",
		"modulate": Color(1, 1, 1, 1),
		"starting_trust": 2,
		"home_zone": "merchant_house",
		"schedule": {
			"Morning": ["merchant_house"], "Afternoon": ["merchant_house"],
			"Evening": ["merchant_house"], "Night": ["merchant_house"],
		},
		"greeting_first": ["A face I don't know. Looking to trade, or just looking?"],
		"greeting_return": ["Back again. What do you need?"],
		"observe_line": "You watch him work the stalls -- sharp-eyed, misses nothing that crosses his counter.",
		"ask_topics": [
			{
				"id": "ask_laban_seen", "label": "Ask about Laban",
				"requires_fact": "", "min_trust": 0,
				"lines": ["Laban? He came through earlier today, actually.", "Didn't stay long."],
				"repeat_lines": ["Still asking about Laban? He was here today, like I told you."],
				"reveals_fact": "f_laban_seen_merchant", "reveal_subject": "Laban",
				"reveal_claim": "Was seen at the Merchant's House earlier today.",
				"reveal_status": "Reported", "trust_delta": 0,
			},
			{
				"id": "ask_laban_cloak", "label": "Ask what Laban bought",
				"requires_fact": "f_laban_seen_merchant", "min_trust": 0,
				"lines": ["Now that you mention it -- he bought a dark cloak off my rack.", "Paid without haggling, which isn't like him."],
				"repeat_lines": ["The dark cloak, yes. Paid full price for it."],
				"reveals_fact": "f_laban_bought_cloak", "reveal_subject": "Laban",
				"reveal_claim": "Bought a dark cloak from the merchant.",
				"reveal_status": "Reported", "trust_delta": 0,
			},
		],
		"tell_reactions": {},
		"favor": null,
		"persuade": null,
	},
	"potter": {
		"display_name": "Potter",
		"sprite": "res://assets/vslice/characters/vendor_fruit.png",
		"modulate": Color(0.92, 0.86, 0.72, 1),
		"starting_trust": 2,
		"home_zone": "potter_shop",
		"schedule": {
			"Morning": ["potter_shop"], "Afternoon": ["potter_shop"],
			"Evening": ["potter_shop"], "Night": ["potter_shop"],
		},
		"greeting_first": ["Careful of the wheel. What brings you here?"],
		"greeting_return": ["Back for more clay talk?"],
		"observe_line": "Rows of drying jars, evenly spaced. A patient sort of work.",
		"ask_topics": [
			{
				"id": "ask_laban_pattern", "label": "Ask about Laban's habits",
				"requires_fact": "", "min_trust": 0,
				"lines": ["Laban? I've known him for years.", "He keeps to habits -- often down at the Stable in the afternoons, seeing to his animals."],
				"repeat_lines": ["Still the same habits, far as I know. Stable, most afternoons."],
				"reveals_fact": "f_laban_pattern_stable", "reveal_subject": "Laban",
				"reveal_claim": "Often goes to the Stable in the afternoon.",
				"reveal_status": "Reported", "trust_delta": 0,
			},
			{
				"id": "ask_stone_house", "label": "Ask who knows Laban well",
				"requires_fact": "", "min_trust": 1,
				"lines": ["There's a woman up in the Stone House who's known Laban longer than most of us.", "If anyone understands the man, it's her."],
				"repeat_lines": ["The Stone House. That's still where I'd send you."],
				"reveals_fact": "", "reveal_subject": "", "reveal_claim": "",
				"reveal_status": "", "trust_delta": 0,
			},
		],
		"tell_reactions": {},
		"favor": {
			"id": "seal_search",
			"prompt_lines": ["My good seal-stamp went missing off the shelf.", "If you spot a clay seal fallen somewhere near the market, I'd be glad of it back."],
			"requires_fact": "f_clay_seal_merchant",
			"resolve_lines": ["That's it! My mark, right there. My thanks -- properly, this time."],
			"not_ready_lines": ["Keep an eye out, then. Near the market stalls, most likely."],
			"trust_delta": 2,
		},
		"persuade": null,
	},
	"stable_worker": {
		"display_name": "Stable Worker",
		"sprite": "res://assets/vslice/characters/watchman.png",
		"modulate": Color(0.85, 0.72, 0.55, 1),
		"starting_trust": 1,
		"home_zone": "stable",
		"schedule": {
			"Morning": ["stable", "stable", "merchant_house"], "Afternoon": ["stable"],
			"Evening": ["stable", "stable", "merchant_house"], "Night": ["stable"],
		},
		"greeting_first": ["Mind the horses. What do you want?"],
		"greeting_return": ["Yeah? What now?"],
		"observe_line": "Fresh hoofprints crisscross the yard -- more traffic through here than usual.",
		"ask_topics": [
			{
				"id": "ask_laban_here", "label": "Ask about Laban",
				"requires_fact": "", "min_trust": 0,
				"lines": ["Laban? ...Might've seen him round here.", "Hard to say exactly when, been a busy few days."],
				"repeat_lines": ["Like I said, he's been through, but I couldn't tell you exactly when."],
				"reveals_fact": "f_laban_stable_rumor", "reveal_subject": "Laban",
				"reveal_claim": "Was seen at the Stable.", "reveal_status": "Rumor", "trust_delta": 0,
			},
			{
				"id": "ask_laban_direction", "label": "Ask which way he went",
				"requires_fact": "", "requires_favor": "mend_bridle", "min_trust": 0,
				"lines": ["Since you asked proper -- he rode out north, toward the hills road, and hasn't been back since."],
				"repeat_lines": ["North, toward the hills. That's the last I saw of him."],
				"reveals_fact": "f_laban_stable_direction", "reveal_subject": "Laban",
				"reveal_claim": "Rode out north toward the hills road and hasn't returned.",
				"reveal_status": "Reported", "trust_delta": 0,
			},
		],
		"tell_reactions": {},
		"favor": {
			"id": "mend_bridle",
			"prompt_lines": ["This bridle's come apart at the buckle.", "If you'd hold it steady while I fix it, I'd remember the favor."],
			"requires_fact": "",
			"resolve_lines": ["There. Obliged to you -- ask me anything, I'll give you a straight answer."],
			"not_ready_lines": [],
			"trust_delta": 2,
		},
		"persuade": null,
	},
	"guard_older": {
		"display_name": "Older Guard",
		"sprite": "res://assets/vslice/characters/watchman.png",
		"modulate": Color(1, 1, 1, 1),
		"starting_trust": 2,
		"home_zone": "eastern_gate",
		"schedule": {
			"Morning": ["eastern_gate"], "Afternoon": ["eastern_gate"],
			"Evening": ["eastern_gate"], "Night": ["eastern_gate"],
		},
		"greeting_first": ["Move along -- or state your business."],
		"greeting_return": ["Still here?"],
		"observe_line": "He watches the road more than the crowd -- old habit, or old orders.",
		"ask_topics": [
			{
				"id": "ask_laban_gate", "label": "Ask if Laban passed through",
				"requires_fact": "", "min_trust": 0,
				"lines": ["Laban? Aye, he passed through maybe twenty minutes ago, heading out toward the hills."],
				"repeat_lines": ["Twenty minutes or so, like I told you. Heading for the hills."],
				"reveals_fact": "f_laban_gate_recent", "reveal_subject": "Laban",
				"reveal_claim": "Passed through the Eastern Gate about twenty minutes ago, heading toward the hills.",
				"reveal_status": "Reported", "trust_delta": 0,
			},
		],
		"tell_reactions": {},
		"favor": null,
		"persuade": null,
	},
	"guard_younger": {
		"display_name": "Younger Guard",
		"sprite": "res://assets/vslice/characters/watchman.png",
		"modulate": Color(1.12, 1.1, 0.95, 1),
		"starting_trust": 1,
		"home_zone": "eastern_gate",
		"schedule": {
			"Morning": ["eastern_gate"], "Afternoon": ["eastern_gate"],
			"Evening": ["eastern_gate"], "Night": ["eastern_gate"],
		},
		"greeting_first": ["Keep moving."],
		"greeting_return": ["What now?"],
		"observe_line": "Younger, jumpier than the other one. Easier to rattle.",
		"ask_topics": [
			{
				"id": "ask_laban_gate2", "label": "Ask if Laban passed through",
				"requires_fact": "", "min_trust": 0,
				"lines": ["Laban passing through? That was yesterday, not today.", "You've got your days mixed up."],
				"repeat_lines": ["Yesterday. I already told you."],
				"reveals_fact": "f_laban_gate_yesterday", "reveal_subject": "Laban",
				"reveal_claim": "Laban's gate crossing was yesterday, not today.",
				"reveal_status": "Reported", "trust_delta": 0,
			},
		],
		"tell_reactions": {},
		"favor": null,
		"persuade": null,
		"lie": {
			"id": "lie_official",
			"lines": [
				"\"I'm here on the household's business -- sent to find him.\"",
				"The guard studies you a moment, then shrugs.",
				"\"Didn't hear it from me, but he keeps company at the Stone House some nights.\"",
			],
			"reveals_fact": "f_laban_hint_stonehouse", "reveal_subject": "Laban",
			"reveal_claim": "Rumored to keep company at the Stone House some nights.",
			"reveal_status": "Rumor",
			"reputation_delta": 10, "trust_delta": 0,
		},
	},
	"shepherd": {
		"display_name": "Shepherd",
		"sprite": "res://assets/vslice/characters/beggar.png",
		"modulate": Color(0.78, 0.9, 0.8, 1),
		"starting_trust": 2,
		"home_zone": "watchtower",
		"schedule": {
			"Morning": ["watchtower", "watchtower", "caravan_road"], "Afternoon": ["caravan_road", "watchtower"],
			"Evening": ["watchtower"], "Night": ["watchtower", "stone_house"],
		},
		"greeting_first": ["Quiet up here. Not much passes I don't see."],
		"greeting_return": ["Back again."],
		"observe_line": "The flock grazes without much minding him -- he's done this a long time.",
		"ask_topics": [
			{
				"id": "ask_general", "label": "Ask what he's seen",
				"requires_fact": "", "min_trust": 0,
				"lines": ["Watch the road long enough, you get a feel for who's meant to be on it and who isn't."],
				"repeat_lines": ["Same road, same watching."],
				"reveals_fact": "", "reveal_subject": "", "reveal_claim": "",
				"reveal_status": "", "trust_delta": 0,
			},
			{
				"id": "ask_cloak", "label": "Ask about a man in a dark cloak",
				"requires_fact": "f_laban_bought_cloak", "min_trust": 0,
				"lines": ["A man in a dark cloak went by, heading north on the road.", "Didn't look back once."],
				"repeat_lines": ["North on the road. That's all I saw of him."],
				"reveals_fact": "f_cloak_seen_north", "reveal_subject": "Laban",
				"reveal_claim": "A man in a dark cloak was seen heading north on the caravan road.",
				"reveal_status": "Reported", "trust_delta": 0,
			},
		],
		"tell_reactions": {},
		"favor": null,
		"persuade": null,
	},
	"courier": {
		"display_name": "Courier Boy",
		"sprite": "res://assets/vslice/characters/beggar.png",
		"modulate": Color(1.05, 0.98, 0.65, 1),
		"starting_trust": 1,
		"home_zone": "eastern_gate",
		"schedule": {
			"Morning": ["eastern_gate", "merchant_house"], "Afternoon": ["merchant_house", "caravan_road"],
			"Evening": ["eastern_gate", "caravan_road"], "Night": ["caravan_road", "eastern_gate"],
		},
		"greeting_first": ["No time to talk unless it's quick."],
		"greeting_return": ["Make it quick."],
		"observe_line": "Always moving. If anyone knows the roads in and out, it's him.",
		"ask_topics": [
			{
				"id": "ask_caravan", "label": "Ask about the road north",
				"requires_fact": "", "requires_favor": "deliver_word", "min_trust": 0,
				"lines": ["There's a caravan gathering out on the Northern Road these next few days.", "If Laban means to leave the city, that's where he'd go."],
				"repeat_lines": ["Caravan's still gathering out north. That's where I'd look."],
				"reveals_fact": "f_courier_route", "reveal_subject": "Laban",
				"reveal_claim": "A caravan is gathering on the Northern Caravan Road -- likely where he'd go if he left the city.",
				"reveal_status": "Reported", "trust_delta": 0,
			},
		],
		"tell_reactions": {},
		"favor": {
			"id": "deliver_word",
			"prompt_lines": ["Look, I'm run off my feet.", "Carry a word to the Potter for me and I'll owe you one."],
			"requires_fact": "",
			"resolve_lines": ["Message delivered? Good. I don't forget a favor."],
			"not_ready_lines": [],
			"trust_delta": 2,
		},
		"persuade": null,
	},
	"stone_house_woman": {
		"display_name": "Stone House Woman",
		"sprite": "res://assets/vslice/characters/mother.png",
		"modulate": Color(1, 1, 1, 1),
		"starting_trust": 1,
		"home_zone": "stone_house",
		"schedule": {
			"Morning": ["stone_house"], "Afternoon": ["stone_house"],
			"Evening": ["stone_house"], "Night": ["stone_house"],
		},
		"greeting_first": ["Few come this far out. What is it you want?"],
		"greeting_return": ["You again."],
		"observe_line": "She keeps her distance from the road, and from most people.",
		"tell_reactions": {
			"f_laban_distrust": {
				"label": "Tell her Laban refused you",
				"lines": ["He refused you outright? That sounds like him.", "He's not cruel. Just guarded."],
				"trust_delta": 1,
			},
		},
		"ask_topics": [
			{
				"id": "ask_secret", "label": "Ask why Laban trusts no one",
				"requires_fact": "", "min_trust": 2,
				"lines": [
					"...You want to know why he trusts no one?",
					"Years back, a false trader cheated him -- vanished with his late brother's signet ring.",
					"He's never let a stranger close to anything valuable since.",
				],
				"repeat_lines": ["The signet ring, the false trader. I've told you what I know."],
				"reveals_fact": "f_laban_secret_motive", "reveal_subject": "Laban",
				"reveal_claim": "Years ago a false trader cheated Laban and vanished with his late brother's signet ring -- he's refused to trust strangers with anything valuable since.",
				"reveal_status": "Reported", "trust_delta": 0,
			},
		],
		"favor": null,
		"persuade": {
			"success_min_trust": 2,
			"success_lines": ["She studies you a long moment, then seems to decide something.", "\"...Ask me plainly, then, if you must.\""],
			"fail_lines": ["I'm already listening. Just ask, if you're going to."],
			"success_trust_delta": 1, "fail_trust_delta": 0,
			"cap_trust": 2,
		},
	},
	"laban_companion": {
		"display_name": "Laban's Companion",
		"sprite": "res://assets/vslice/characters/shady_contact.png",
		"modulate": Color(1, 1, 1, 1),
		"starting_trust": 1,
		"home_zone": "stone_house",
		"schedule": {
			"Morning": ["merchant_house", "stable"], "Afternoon": ["stable", "merchant_house"],
			"Evening": ["stone_house", "caravan_road"], "Night": ["stone_house", "stone_house", "caravan_road"],
		},
		"greeting_first": ["Whatever you want, make it fast. I don't know you."],
		"greeting_return": ["You again. Still following him around?"],
		"observe_line": "He stays close to Laban's shoulder, watching everyone who gets near.",
		"ask_topics": [
			{
				"id": "ask_values", "label": "Ask what matters to Laban",
				"requires_fact": "", "min_trust": 2,
				"lines": ["He doesn't care about gold half as much as people think.", "Loyalty, though -- that he notices."],
				"repeat_lines": ["Loyalty. I've told you that already."],
				"reveals_fact": "f_laban_values_loyalty", "reveal_subject": "Laban",
				"reveal_claim": "Values loyalty and being taken seriously more than gold.",
				"reveal_status": "Reported", "trust_delta": 0,
			},
		],
		"tell_reactions": {},
		"favor": {
			"id": "cover_watch",
			"prompt_lines": ["Stand watch a moment while I see to something.", "Won't take long."],
			"requires_fact": "",
			"resolve_lines": ["...Appreciated. Most people don't bother."],
			"not_ready_lines": [],
			"trust_delta": 2,
		},
		"persuade": {
			"success_min_trust": 0,
			"success_lines": ["Hm. Maybe you're not just another stranger."],
			"fail_lines": ["You've already made your case. No need to keep pushing."],
			"success_trust_delta": 1, "fail_trust_delta": 0,
			"cap_trust": 4,
		},
	},
	"laban": {
		"display_name": "Laban",
		"sprite": "res://assets/vslice/characters/laban.png",
		"modulate": Color(1, 1, 1, 1),
		"starting_trust": 0,
		"home_zone": "merchant_house",
		"schedule": {
			"Morning": ["merchant_house", "stable"], "Afternoon": ["stable", "merchant_house", "stable"],
			"Evening": ["eastern_gate", "caravan_road"], "Night": ["stone_house", "caravan_road", "stone_house"],
		},
		"greeting_first_meeting": ["I don't know you. State your business, and be quick about it."],
		"greeting_after_refusal": ["Back again? I don't do business with strangers -- but you already knew that."],
		"greeting_trusted": ["You again. Well? What is it this time?"],
		"refusal_lines": ["No.", "I don't give valuable things to strangers.", "You'll need to give me a better reason than asking."],
		"success_lines": [
			"...Very well.",
			"You've earned more than most who've stood where you're standing.",
			"Take the plates. Go swiftly, before I reconsider.",
		],
		"not_yet_lines": ["Not yet. You haven't given me a reason to trust you."],
		"persuade_fail_lines": ["Fine words, but words don't pay for trust.", "Come back when you've done more than talk."],
		"persuade_success_lines": ["...Perhaps I've misjudged you.", "Keep proving it."],
		"leverage_lines": [
			"\"I know about the false trader. About your brother's ring.\"",
			"Laban goes very still.",
			"\"...How do you know that?\"",
			"\"Careful who you say that to. But -- I see you've done your homework.\"",
		],
		"threaten_lines": ["Threaten me? In my own city?", "You've made yourself an enemy, not a friend."],
		"observe_line": "He counts everything twice -- coin, goods, and the people around him.",
		"trust_threshold_for_plates": 3,
	},
}


func get_entry(npc_id: String) -> Dictionary:
	return NPCS.get(npc_id, {})


func get_starting_trust(npc_id: String) -> int:
	return int(NPCS.get(npc_id, {}).get("starting_trust", 1))


func get_display_name(npc_id: String) -> String:
	return String(NPCS.get(npc_id, {}).get("display_name", npc_id))


func get_home_zone(npc_id: String) -> String:
	return String(NPCS.get(npc_id, {}).get("home_zone", "family_house"))


func get_schedule_for_block(npc_id: String, block_name: String) -> Array:
	var entry: Dictionary = NPCS.get(npc_id, {})
	var schedule: Dictionary = entry.get("schedule", {})
	var options: Array = schedule.get(block_name, [])
	if options.is_empty():
		return [get_home_zone(npc_id)]
	return options


func all_npc_ids() -> Array[String]:
	var ids: Array[String] = []
	for key in NPCS.keys():
		ids.append(String(key))
	return ids
