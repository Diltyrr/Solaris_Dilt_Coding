/area/provincial/indoors/town/province_keep/garrison
	name = "The Garrison"
	icon_state = "garrison"
	droning_sound = 'sound/music/area/manorgarri.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	droning_sound_dusk = null
	droning_sound_night = null
	keep_area = TRUE
	brief_descriptor = "where soldiers haunt and drinks are poured"
	general_location = "Inside the Garrison!"

/// ARMORY ///

/area/provincial/indoors/town/province_keep/garrison/armory
	name = "Armory"

/area/provincial/indoors/town/province_keep/garrison/armory/secure
	name = "Secure Armory"

/area/provincial/indoors/town/province_keep/garrison/armory/toilets
	name = "Armory Toilets"

/// CANTEEN ///

/area/provincial/indoors/town/province_keep/garrison/canteen
	name = "Canteen"

/// DUNGEON ///

/area/provincial/indoors/town/province_keep/garrison/dungeon
	name = "Dungeon"
	spookysounds = SPOOKY_DUNGEON
	spookynight = SPOOKY_DUNGEON
	brief_descriptor = "where men rot and hope dwindles"
	general_location = /area/provincial/indoors/town/province_keep/garrison::general_location

/area/provincial/indoors/town/province_keep/garrison/dungeon/cell
	name = "Dungeon Cell"
	icon_state = "cell"

/// GATES ///

/area/provincial/indoors/town/province_keep/garrison/gate
	name = "Gatehouse"
	keep_area = FALSE
	first_time_text = null
	droning_sound = /area/provincial/indoors/town::droning_sound
	droning_sound_dusk = /area/provincial/indoors/town::droning_sound_dusk
	droning_sound_night = /area/provincial/indoors/town::droning_sound_night

/area/provincial/indoors/town/province_keep/garrison/gate/north
	name = "Northern Gatehouse"

/area/provincial/indoors/town/province_keep/garrison/gate/west
	name = "Western Gatehouse"

/area/provincial/indoors/town/province_keep/garrison/gate/east
	name = "Eastern Gatehouse"

/area/provincial/indoors/town/province_keep/garrison/gate/south
	name = "Southern Gatehouse"

/area/provincial/indoors/town/province_keep/garrison/gate/keep
	name = "Keep Gatehouse"
	keep_area = TRUE // nightmare
	droning_sound = /area/provincial/indoors/town/province_keep/garrison::droning_sound
	droning_sound_dusk = /area/provincial/indoors/town/province_keep/garrison::droning_sound_dusk
	droning_sound_night = /area/provincial/indoors/town/province_keep/garrison::droning_sound_night

/// QUARTERS ///

/area/provincial/indoors/town/province_keep/garrison/quarters
	name = "Barracks"

/area/provincial/indoors/town/province_keep/garrison/quarters/knight_captain
	name = "Knight Captain's Quarters"

/area/provincial/indoors/town/province_keep/garrison/quarters/marshal
	name = "Marshal's Quarters"

/area/provincial/indoors/town/province_keep/garrison/quarters/sergeant
	name = "Sergeant's Quarters"

/// RAMPARTS ///

/area/provincial/indoors/town/province_keep/garrison/ramparts
	name = "Keep Ramparts"

/// STABLES ///

/area/provincial/indoors/town/province_keep/garrison/stables
	name = "Keep Stables"

/// WARDEN'S WATCHTOWER ///

/area/provincial/indoors/town/province_keep/garrison/warden_watchtower
	name = "Warden's Watchtower"
