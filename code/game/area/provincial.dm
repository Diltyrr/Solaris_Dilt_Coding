GLOBAL_LIST_EMPTY(chosen_music)

GLOBAL_LIST_INIT(roguetown_areas_typecache, typecacheof(/area/provincial/indoors/town,/area/provincial/outdoors/town,/area/provincial/indoors/town/basement)) //hey

/area/provincial
	name = "Province Sunmarch"
	icon_state = "rogue"
	has_gravity = STANDARD_GRAVITY
	ambientsounds = null
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = TRUE
	power_equip = TRUE
	power_light = TRUE
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	requires_power = FALSE
	var/town_area = FALSE
	var/keep_area = FALSE
	var/warden_area = FALSE
	var/ceiling_protected = FALSE //Prevents tunneling into these from above

/area/provincial/Entered(mob/living/carbon/human/guy)
	. = ..()
	if((src.town_area == TRUE) && HAS_TRAIT(guy, TRAIT_GUARDSMAN) && guy.z == 3 && !guy.has_status_effect(/datum/status_effect/buff/guardbuffone)) //man at arms
		guy.apply_status_effect(/datum/status_effect/buff/guardbuffone)
		if(HAS_TRAIT(guy, TRAIT_KNIGHTSMAN) && guy.has_status_effect(/datum/status_effect/buff/knightbuff))
			guy.remove_status_effect(/datum/status_effect/buff/knightbuff)

/area/provincial/Entered(mob/living/carbon/human/guy)
	. = ..()
	if((src.warden_area == TRUE) && HAS_TRAIT(guy, TRAIT_WOODSMAN) && !guy.has_status_effect(/datum/status_effect/buff/wardenbuff)) // Warden
		guy.apply_status_effect(/datum/status_effect/buff/wardenbuff)

/area/provincial/Entered(mob/living/carbon/human/guy)
	. = ..()
	if((src.keep_area == TRUE) && HAS_TRAIT(guy, TRAIT_KNIGHTSMAN) && !guy.has_status_effect(/datum/status_effect/buff/knightbuff)) //royal guard
		guy.apply_status_effect(/datum/status_effect/buff/knightbuff)
		if(HAS_TRAIT(guy, TRAIT_GUARDSMAN) && guy.has_status_effect(/datum/status_effect/buff/guardbuffone))
			guy.remove_status_effect(/datum/status_effect/buff/guardbuffone)

/// the underworld - currently unused, formerly a death mechanic. maintained out of laziness
/area/underworld
	name = "underworld"
	icon_state = "underworld"
	droning_sound = 'sound/music/area/underworlddrone.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "The Forest of Repentence"
	brief_descriptor = "a place out of time"
	general_location = "From... from. Nowhere."
