extends Node
## InvLocationData (autoload)
##
## Static reference data for the seven MVP areas -- a compact, navigable
## slice of Jerusalem (Family Home, Lower City, Marketplace, Back Alleys,
## Temple District, Upper City) plus Laban's Storeroom, a specific
## destination tucked past the Temple District/Upper City boundary. Purely
## descriptive -- world position/geometry lives in the InvWorld scene
## itself, which registers each zone's NPC-standing-spot position with
## InvNPCDirector at runtime. This table just answers "what is this place
## called and what does it feel like," so HUD/Journal text and NPC
## schedules can reference a zone_id without repeating strings everywhere.

const ZONES: Dictionary = {
	"family_home": {
		"name": "Family Home",
		"district": "Lower City",
		"blurb": "Home. Quiet, for now.",
	},
	"lower_city": {
		"name": "Lower City",
		"district": "Lower City",
		"blurb": "Narrow residential streets, workshops, and courtyards.",
	},
	"marketplace": {
		"name": "Marketplace",
		"district": "Marketplace",
		"blurb": "Stalls and gossip. Someone always knows something.",
	},
	"alleys": {
		"name": "Back Alleys",
		"district": "Back Alleys",
		"blurb": "A winding network of narrow streets. Easy to lose your way.",
	},
	"temple_district": {
		"name": "Temple District",
		"district": "Temple District",
		"blurb": "Stone walls and a skyline that dwarfs everything below it.",
	},
	"upper_city": {
		"name": "Upper City",
		"district": "Upper City",
		"blurb": "Wider streets, larger houses. Laban's kind of neighborhood.",
	},
	"laban_storeroom": {
		"name": "Laban's Storeroom",
		"district": "Upper City",
		"blurb": "Tucked out of sight. Not a place you stumble onto by accident.",
	},
}

## Ordered list, roughly in the order the design brief introduces them.
const ZONE_ORDER: Array[String] = [
	"family_home", "lower_city", "marketplace", "alleys",
	"temple_district", "upper_city", "laban_storeroom",
]


func get_zone_name(zone_id: String) -> String:
	return String(ZONES.get(zone_id, {}).get("name", zone_id))


func get_blurb(zone_id: String) -> String:
	return String(ZONES.get(zone_id, {}).get("blurb", ""))
