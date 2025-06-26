//By DREAMKEEP, Vide Noir https://github.com/EaglePhntm.
//GRAPHICS & SOUNDS INCLUDED:
//DARKEST DUNGEON (STRESS, RELIEF, AFFLICTION)
/mob/living/proc/play_overhead_indicator(icon_path, overlay_name, clear_time, overlay_layer, private = FALSE, soundin = null, y_offset = 12)
	if(!ishuman(src))
		return
	if(stat != DEAD)
		var/mob/living/carbon/human/humie = src
		var/datum/species/species = humie.dna.species
		var/list/offset_list
		if(humie.gender == FEMALE)
			offset_list = species.offset_features[OFFSET_HEAD_F]
		else
			offset_list = species.offset_features[OFFSET_HEAD]

		// ==== 1. PATRON SIGNS (fsalute etc): RUNS EXCLUSIVELY ====
		if(ispath(private, /datum/patron))
			var	icon_plane = WEATHER_EFFECT_PLANE
			// Priest override --
			if (HAS_TRAIT(src, TRAIT_CHOSEN))
				// show the priest icon to everyone
				for (var/mob/living/carbon/human/H in viewers(world.view, src))
					vis_contents += new /obj/effect/temp_visual/stress_event/invisible(
						null, H, icon_path, "sign_Priest",
						offset_list, y_offset, icon_plane
					)
					if (soundin)
						H.playsound_local(get_turf(src), soundin, 100, FALSE)
				// buffs + mood (priest only)
				for(var/mob/living/carbon/human/T in view(5, src.loc))
					if (T != src)
						T.apply_status_effect(/datum/status_effect/buff/faithful)
						T.apply_status_effect(/datum/status_effect/buff/ffortune)
						// SEND_SIGNAL(target, COMSIG_ADD_MOOD_EVENT, "fsalute", /datum/stressevent/inner_peace)
			else
				// God sign for non-priests
				for (var/mob/living/carbon/human/H in viewers(world.view, src))
					if (H.patron?.type == private)
						vis_contents += new /obj/effect/temp_visual/stress_event/invisible(
							null, H, icon_path, "sign_[H.patron.name]",
							offset_list, y_offset, icon_plane
						)
						if (soundin)
							H.playsound_local(get_turf(src), soundin, 100, FALSE)
			return // EARLY RETURN: do not run stress/relief/trait logic below

		// ==== 2. STRESS/RELIEF OVERHEADS (not patron signs): ====
		// Always show to self
		var/mutable_appearance/appearance = mutable_appearance(icon_path, overlay_name, overlay_layer)
		if(offset_list)
			appearance.pixel_x += (offset_list[1])
			appearance.pixel_y += (offset_list[2]+y_offset)
		appearance.appearance_flags = RESET_COLOR
		overlays_standing[OBJ_LAYER] = appearance
		apply_overlay(OBJ_LAYER)
		addtimer(CALLBACK(humie, PROC_REF(clear_overhead_indicator), appearance), clear_time)
		playsound(src, soundin, 100, FALSE, extrarange = -1, ignore_walls = FALSE)

		// Show to empaths (and self, but that's fine)
		if(private) // only if a trait is passed (like TRAIT_EMPATH)
			var/list/can_see = list(src)
			for(var/mob/M in viewers(world.view, src))
				if(HAS_TRAIT(M, private))
					if(M != src)
						can_see += M
			for(var/mob/M in can_see)
				vis_contents += new /obj/effect/temp_visual/stress_event/invisible(null, M, icon_path, overlay_name, offset_list)
				if(soundin)
					var/turf/T = get_turf(src)
					M.playsound_local(T, soundin, 100, FALSE)

/obj/effect/temp_visual/stress_event
	icon = 'icons/mob/overhead_effects.dmi'
	duration = 20

/obj/effect/temp_visual/stress_event/invisible
	icon_state = null

/obj/effect/temp_visual/stress_event/invisible/Initialize(mapload, mob/seer, path, iname, list/offsets, y_offset = 12, plane)
	. = ..()
	var/image/I = image(icon = path, icon_state = iname, layer = ABOVE_MOB_LAYER, loc = src)
	I.alpha = 255
	if(plane)
		I.plane = plane
	I.appearance_flags = RESET_ALPHA
	if(offsets)
		I.pixel_x += (offsets[1])
		I.pixel_y += (offsets[2]+y_offset)
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/onePerson, iname, I, seer)

/mob/living/proc/clear_overhead_indicator(appearance)
	remove_overlay(OBJ_LAYER)
	cut_overlay(appearance, TRUE)
	qdel(appearance)
	update_icon()
	return

/mob/living/proc/play_stress_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "stress", 15, OBJ_LAYER, private = TRAIT_EMPATH, soundin = 'sound/ddstress.ogg')

/mob/living/proc/play_relief_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "relief", 15, OBJ_LAYER, private = TRAIT_EMPATH, soundin = 'sound/ddrelief.ogg')

/mob/living/proc/play_mental_break_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "mentalbreak", 20, OBJ_LAYER)
	playsound(src, 'sound/stressaffliction.ogg', 100, FALSE, ignore_walls = FALSE)

/mob/living/proc/clear_vis_indicator(image/I)
	vis_contents -= I