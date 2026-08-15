extends Node
## InvLocationData (autoload)
##
## Static reference data for the eight MVP locations. Purely descriptive --
## world position/geometry lives in the InvWorld scene itself, which
## registers each zone's NPC-standing-spot position with InvNPCDirector at
## runtime. This table just answers "what is this place called and what
## does it feel like," so HUD/Journal text and NPC schedules can reference
## a zone_id without repeating strings everywhere.

const ZONES: Dictionary = {
	"family_house": {
		"name": "Family House",
		"district": "Jerusalem",
		"blurb": "Home. Quiet, for now.",
	},
	"merchant_house": {
		"name": "Merchant's House",
		"district": "Jerusalem",
		"blurb": "Stalls and gossip. Someone always knows something.",
	},
	"potter_shop": {
		"name": "Potter's Shop",
		"district": "Jerusalem",
		"blurb": "Clay dust and long memory.",
	},
	"stable": {
		"name": "Stable",
		"district": "Jerusalem",
		"blurb": "Horses, hay, and comings and goings.",
	},
	"eastern_gate": {
		"name": "Eastern Gate",
		"district": "Jerusalem",
		"blurb": "Everyone who leaves the city passes here.",
	},
	"watchtower": {
		"name": "Old Watchtower",
		"district": "Hills",
		"blurb": "A crumbling post overlooking the northern road.",
	},
	"stone_house": {
		"name": "Stone House",
		"district": "Hills",
		"blurb": "Set apart from the road, deliberately.",
	},
	"caravan_road": {
		"name": "Northern Caravan Road",
		"district": "Hills",
		"blurb": "The road out of Jerusalem, toward the hill country.",
	},
}

## Ordered list, Jerusalem locations first, matching the design brief.
const ZONE_ORDER: Array[String] = [
	"family_house", "merchant_house", "potter_shop", "stable", "eastern_gate",
	"watchtower", "stone_house", "caravan_road",
]


func get_zone_name(zone_id: String) -> String:
	return String(ZONES.get(zone_id, {}).get("name", zone_id))


func get_blurb(zone_id: String) -> String:
	return String(ZONES.get(zone_id, {}).get("blurb", ""))
