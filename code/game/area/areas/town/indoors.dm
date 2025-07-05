/area/provincial/indoors/town
	name = "Interior"
	icon_state = "town"
	droning_sound = 'sound/music/area/towngen.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/provincial/outdoors/town
	town_area = TRUE
	brief_descriptor = "nestled within walls of walls inside Solaris Ridge."
	general_location = "Inside the town of Solaris Ridge!"

/// ADVENTURER'S GUILD ///

/area/provincial/indoors/town/adventurers_guild
	name = "Adventurer's Guild"
	droning_sound = 'sound/music/area/newbiemelody.ogg'
	droning_sound_dusk = 'sound/music/area/newbiemelody.ogg'
	droning_sound_night = 'sound/music/area/newbiemelody.ogg'

/area/provincial/indoors/town/adventurers_guild/handlers_office
	name = "Guild Handler's Office"

/area/provincial/indoors/town/adventurers_guild/handlers_office/bedroom
	name = "Guild Handler's Bedroom"

/// BASEMENT ///

/area/provincial/indoors/town/basement
	name = "Basement"
	icon_state = "basement"
	ambientsounds = AMB_BASEMENT
	ambientnight = AMB_BASEMENT
	spookysounds = SPOOKY_DUNGEON
	spookynight = SPOOKY_DUNGEON
	droning_sound = 'sound/music/area/towngen.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	soundenv = 5
	brief_descriptor = "beneath the bustle of the city"
	general_location = "From below Solaris Ridge!"

/// BLACKSMITH ///

/area/provincial/indoors/town/blacksmith
	name = "Blacksmith"
	icon_state = "dwarfin"
	droning_sound = 'sound/music/area/dwarf.ogg'
	brief_descriptor = "where craftsmen toil and legends are prepared"

/// DUSK QUARTER ///

/area/provincial/indoors/town/dusk_quarter
	name = "Dusk Quarter"
	icon_state = "dwarfin"
	first_time_text = "The Dusk Quarter"

/// FARMHOUSE ///
/area/provincial/indoors/town/farm
	name = "Farmhouse"

/area/provincial/indoors/town/farm/basement
	name = "Farmhouse Basement"

/area/provincial/indoors/town/farm/secondary
	name = "Secondary Farmhouse"

/area/provincial/indoors/town/farm/secondary/basement
	name = "Secondary Farmhouse Basement"

/area/provincial/indoors/town/farm/secondary/stall
	name = "Soilson Stall"

/area/provincial/indoors/town/farm/barn
	name = "Barn"

/area/provincial/indoors/town/farm/chicken_coop
	name = "Chicken Coop"

/// HOUSES ///

/area/provincial/indoors/town/house
	name = "Townhouse"

/area/provincial/indoors/town/house/janitor
	name = "Janitor's Abode"

/area/provincial/indoors/town/house/veteran
	name = "Veteran's House"
	icon_state = "garrison"

/area/provincial/indoors/town/house/village_elder
	name = "Village Elder's House"

/// MAGE'S UNIVERSITY ///

/area/provincial/indoors/town/mages_university
	name = "Mage's University"

/area/provincial/indoors/town/mages_university/alchemy_lab
	name = "University Alchemy Lab"

/area/provincial/indoors/town/mages_university/archivist
	name = "Archivist's Office"

/area/provincial/indoors/town/mages_university/archivist/quarters
	name = "Archivist's Quarters"

/area/provincial/indoors/town/mages_university/artificer
	name = "Artificer's Office"

/area/provincial/indoors/town/mages_university/established_mage_hall
	name = "Established Mage Hall"

/area/provincial/indoors/town/mages_university/head_mage
	name = "Head Mage's Quarters"

/area/provincial/indoors/town/mages_university/kitchen
	name = "University Kitchen"

/area/provincial/indoors/town/mages_university/library
	name = "Library"

/area/provincial/indoors/town/mages_university/shared_storage
	name = "University Shared Storage"

/// STALLS ///

/area/provincial/indoors/town/stall
	name = "Stall I"

/area/provincial/indoors/town/stall/stall_two
	name = "Stall II"

/area/provincial/indoors/town/stall/stall_three
	name = "Stall III"

/// STEWARD ///

/area/provincial/indoors/town/steward
	name = "Stewardry"
	icon_state = "warehouse"

/area/provincial/indoors/town/steward/import_platform
	name = "dock warehouse import"
	brief_descriptor = "where the steward imports goods"
	general_location = "Below town!"

/area/provincial/indoors/town/steward/import_platform/can_craft_here()
	return FALSE

/// RAMPARTS ///

/area/provincial/indoors/town/ramparts
	name = "Ramparts"
	icon_state = "garrison"

/// SEWERS ///

/area/provincial/indoors/town/sewer
	name = "Sewers"
	icon_state = "sewer"
	ambientsounds = AMB_CAVEWATER
	ambientnight = AMB_CAVEWATER
	spookysounds = SPOOKY_RATS
	spookynight = SPOOKY_RATS
	droning_sound = 'sound/music/area/sewers.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambientrain = RAIN_SEWER
	soundenv = 21
	brief_descriptor = "where rat and murk mingle twice-over"
	general_location = /area/provincial/indoors/town/basement::general_location

/area/provincial/indoors/town/sewer/rogues_den
	name = "Rogue's Den"

/// SHOP ///

/area/provincial/indoors/town/shop
	name = "Shop"
	icon_state = "shop"
	droning_sound = 'sound/music/area/shop.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/provincial/outdoors/town/shop

/// STABLES ///

/area/provincial/indoors/town/stables
	name = "Stables"

/area/provincial/indoors/town/stables/rented
	name = "Rented Stables"

/// TAVERN ///

/area/provincial/indoors/town/tavern
	name = "The Rasurian Pint"
	icon_state = "tavern"
	ambientsounds = AMB_INGEN
	ambientnight = AMB_INGEN
	droning_sound = 'sound/silence.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/provincial/outdoors/town/tavern
	brief_descriptor = "where merriment sparks and bards play"

/area/provincial/indoors/town/tavern/arena
	name = "Arena"

/area/provincial/indoors/town/tavern/arena/spectator
	name = "Arena Spectation"

/area/provincial/indoors/town/tavern/bath
	name = "Bathhouse"

/area/provincial/indoors/town/tavern/kitchen
	name = "Tavern's Kitchen"

/area/provincial/indoors/town/tavern/kitchen/pantry
	name = "Tavern's Pantry"

/area/provincial/indoors/town/tavern/public_meeting_room
	name = "Public Meeting Room"

/area/provincial/indoors/town/tavern/innkeeper
	name = "Innkeeper's Quarters"

/area/provincial/indoors/town/tavern/tapster_quarters
	name = "Tapster Quarters"

/// TAVERN ROOMS ///

/area/provincial/indoors/town/tavern/room
	name = "Room I"

/area/provincial/indoors/town/tavern/room/two
	name = "Room II"

/area/provincial/indoors/town/tavern/room/three
	name = "Room III"

/area/provincial/indoors/town/tavern/room/four
	name = "Room IV"

/area/provincial/indoors/town/tavern/room/five
	name = "Room V"

/area/provincial/indoors/town/tavern/room/six
	name = "Room VI"

/area/provincial/indoors/town/tavern/room/seven
	name = "Room VII"

/area/provincial/indoors/town/tavern/room/eight
	name = "Room VIII"

/area/provincial/indoors/town/tavern/room/luxury
	name = "Luxury Room I"

/area/provincial/indoors/town/tavern/room/luxury/two
	name = "Luxury Room II"

/area/provincial/indoors/town/tavern/room/luxury/three
	name = "Luxury Room III"

/area/provincial/indoors/town/tavern/room/luxury/four
	name = "Luxury Room IV"

/area/provincial/indoors/town/tavern/room/luxury/five
	name = "Luxury Room V"

/// TAILOR ///

/area/provincial/indoors/town/tailor
	name = "Tailor"
