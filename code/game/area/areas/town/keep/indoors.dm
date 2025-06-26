/area/provincial/indoors/town/province_keep
	name = "The Keep of Sunmarch" // Here making another map? Subtype this and change only the relevant lines.
	icon_state = "manor"
	droning_sound = list('sound/music/area/manor.ogg', 'sound/music/area/manor2.ogg')
	droning_sound_dusk = null
	droning_sound_night = list('sound/music/area/manor.ogg', 'sound/music/area/manor.ogg')
	first_time_text = "THE KEEP OF SUNMARCH"
	keep_area = TRUE
	brief_descriptor = "nestled within the keep of Sunmarch."
	general_location = "Inside the keep!"

/// BATHS ///

/area/provincial/indoors/town/province_keep/baths
	name = "Keep of Sunmarch - Baths"

/area/provincial/indoors/town/province_keep/baths/marquis
	name = "Keep of Sunmarch - Marquis' Bath"

/area/provincial/indoors/town/province_keep/baths/toilets
	name = "Keep of Sunmarch - Toilets"

/// BASEMENT ///

/area/provincial/indoors/town/province_keep/basement
	name = "Keep of Sunmarch - Basement"
	icon_state = "basement"
	ambientsounds = AMB_BASEMENT
	ambientnight = AMB_BASEMENT
	spookysounds = SPOOKY_DUNGEON
	spookynight = SPOOKY_DUNGEON
	soundenv = 5
	brief_descriptor = "beneath the bustle of the keep"
	general_location = "From below the Keep!"

/area/provincial/indoors/town/province_keep/wine_cellar
	name = "Keep of Sunmarch - Wine Cellar"

/// COUNCIL ///

/area/provincial/indoors/town/province_keep/councillor
	name = "Keep of Sunmarch - Council"

/// DRESSING ROOM ///

/area/provincial/indoors/town/province_keep/dressing_room
	name = "Keep of Sunmarch - Dressing Room"

/// KITCHEN ///

/area/provincial/indoors/town/province_keep/kitchen
	name = "Keep of Sunmarch - Kitchen"

/area/provincial/indoors/town/province_keep/kitchen/marquis
	name = "Keep of Sunmarch - Marquis' Kitchen"

/// MEETING ROOM ///

/area/provincial/indoors/town/province_keep/meeting_room
	name = "Keep of Sunmarch - Meeting Room"

/// QUARTERS ///
/area/provincial/indoors/town/province_keep/quarters
	name = "Keep of Sunmarch - Quarters"

/area/provincial/indoors/town/province_keep/quarters/councillor
	name = "Keep of Sunmarch - Councillor Quarters"

/area/provincial/indoors/town/province_keep/quarters/guest
	name = "Keep of Sunmarch - Guest Quarters"

/area/provincial/indoors/town/province_keep/quarters/hand
	name = "Keep of Sunmarch - Hand's Quarters"

/area/provincial/indoors/town/province_keep/quarters/marquis
	name = "Keep of Sunmarch - Marquis' Apartment"

/area/provincial/indoors/town/province_keep/quarters/nobleman
	name = "Keep of Sunmarch - Noble's Apartment"

/area/provincial/indoors/town/province_keep/quarters/knight
	name = "Keep of Sunmarch - Knight Quarters"
	icon_state = "manorgarri"

/area/provincial/indoors/town/province_keep/quarters/squire
	name = "Keep of Sunmarch - Squire Quarters"
	icon_state = "manorgarri"

/area/provincial/indoors/town/province_keep/quarters/jester
	name = "Keep of Sunmarch - Jester's Quarters"

/area/provincial/indoors/town/province_keep/quarters/servant
	name = "Keep of Sunmarch - Servant's Quarters"

/area/provincial/indoors/town/province_keep/quarters/seneschal
	name = "Keep of Sunmarch - Seneschal's Quarters"

/// LIBRARY ///
/area/provincial/indoors/town/province_keep/library
	name = "Keep of Sunmarch - Library"

/// THRONE ///

/area/provincial/indoors/town/province_keep/throneroom
	name = "Keep of Sunmarch - Throneroom"

/area/provincial/indoors/town/province_keep/throneroom/overlook
	name = "Keep of Sunmarch - Throneroom Overlook"

/// VAULT ///

/area/provincial/indoors/town/province_keep/vault
	name = "Keep of Sunmarch - Vault"
	icon_state = "vault"
	keep_area = TRUE
	brief_descriptor = "where the realm's riches lie so safe"
	general_location = span_danger("It's from the vault!") // RUN FORREST RUN

/area/provincial/indoors/town/province_keep/vault/can_craft_here()
	return FALSE

/// DIGNITARIES ///

/area/provincial/indoors/town/province_keep/magician
	name = "Court Magician's Tower"
	icon_state = "magician"
	spookysounds = SPOOKY_MYSTICAL
	spookynight = SPOOKY_MYSTICAL
	droning_sound = 'sound/music/area/magiciantower.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	keep_area = TRUE
	brief_descriptor = "where the university sent dignitary to persuade the Marquis."
	general_location = "Inside the Dignitary's Quarter!"

/area/provincial/indoors/town/province_keep/magician/alchemylab
	name = "Court Magician's Alchemy Lab"

/area/provincial/indoors/town/province_keep/magician/quarters
	name = "Court Magician's Quarters"

/area/provincial/indoors/town/province_keep/deacon
	name = "Deacon's Office"
	icon_state = "physician"
	droning_sound = 'sound/music/area/shop.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	brief_descriptor = "where the chapel of lights sent dignitary to persuade the Marquis."
	general_location = "Inside the Dignitary's Quarter!"

/area/provincial/indoors/town/province_keep/deacon/alchemylab
	name = "Archivist-Deacon Alchemy Lab"

/area/provincial/indoors/town/province_keep/deacon/quarters
	name = "Deacon's Quarters"

