/* Beds... get your mind out of the gutter, they're for sleeping!
 * Contains:
 * 		Beds
 *		Roller beds
 */

/*
 * Beds
 */
/obj/structure/bed
	name = "bed"
	desc = ""
	icon_state = "bed"
	icon = 'icons/obj/objects.dmi'
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = 90
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 0.35
	var/buildstacktype
	var/buildstackamount = 2
	var/bolts = TRUE
	buckleverb = "lay"
	/// The base amount by which the buckled mob's pixel_y is offset when buckled.
	var/buckle_y_offset_base = 5
	/// The amount of additional pixel_y offset to add to the mob if it's not the first mob to buckle to the bed.
	var/additional_buckle_y_offset = 6
	/// The mob who buckled to this bed second (if applicable), to avoid other mobs getting pixel-shifted before he unbuckles.
	var/mob/living/goldilocks

/obj/structure/bed/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
	..()

/obj/structure/bed/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/bed/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WRENCH && !(flags_1&NODECONSTRUCT_1))
		W.play_tool_sound(src)
		deconstruct(TRUE)
	else
		return ..()

/obj/structure/bed/post_buckle_mob(mob/living/target)
	. = ..()
	var/buckle_y_offset = buckle_y_offset_base

	if(buckled_mobs.len > 1 && !goldilocks) // Push the second buckled mob a bit higher from the normal lying position
		buckle_y_offset += 12
		goldilocks = target

	target.set_mob_offsets("bed_buckle", _x = 0, _y = buckle_y_offset)
	target.update_cone_show()

/obj/structure/bed/post_unbuckle_mob(mob/living/target)
	. = ..()

	target.reset_offsets("bed_buckle")
	target.update_cone_show()

	if(target == goldilocks)
		goldilocks = null
