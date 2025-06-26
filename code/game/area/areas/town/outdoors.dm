/area/provincial/outdoors/town
	name = "Solaris Ridge"
	icon_state = "town"
	soundenv = 16
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	first_time_text = "THE CITY OF SOLARIS RIDGE"
	town_area = TRUE
	brief_descriptor = "inside the walls of Solaris Ridge"
	general_location = "From Solaris Ridge!"

/area/provincial/outdoors/shop
	name = /area/provincial/indoors/town/shop::name
	icon_state = /area/provincial/indoors/town/shop::icon_state
	droning_sound = /area/provincial/indoors/town/shop::droning_sound
	droning_sound_dusk = /area/provincial/indoors/town/shop::droning_sound_dusk
	droning_sound_night = /area/provincial/indoors/town/shop::droning_sound_night
	converted_type = /area/provincial/indoors/town/shop

/area/provincial/outdoors/tavern
	name = /area/provincial/indoors/town/tavern::name
	icon_state = /area/provincial/indoors/town/tavern::icon_state
	droning_sound = /area/provincial/indoors/town/tavern::droning_sound
	droning_sound_dusk = /area/provincial/indoors/town/tavern::droning_sound_dusk
	droning_sound_night = /area/provincial/indoors/town/tavern::droning_sound_night
	converted_type = /area/provincial/indoors/town/tavern
	brief_descriptor = /area/provincial/indoors/town/tavern::droning_sound_night

/// RAMPARTS ///

/area/provincial/outdoors/town/ramparts
	name = "Exterior Ramparts"
	icon_state = "manorgarri"

/// ROOFS ///

/area/provincial/outdoors/town/roofs
	name = "Rooftops"
	icon_state = "roofs"
	ambientsounds = AMB_MOUNTAIN
	ambientnight = AMB_MOUNTAIN
	spookysounds = SPOOKY_GEN
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/field.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	soundenv = 17
