/obj/effect/proc_holder/spell/invoked/entangling_vines
	name = "Entangling Vines"
	desc = "Summons thorny vines that sprout from the ground around the target, slowing and damaging them."
	range = 5
	chargetime = 2 SECONDS
	recharge_time = 30 SECONDS
	invocation = "Fáinne an fhionnuisce!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/arcane
	chargedloop = /datum/looping_sound/invokegen
	releasedrain = 40

/obj/effect/proc_holder/spell/invoked/entangling_vines/cast(list/targets, mob/living/user)
	var/mob/living/target = targets[1]

	if(!target || !isliving(target))
		to_chat(user, span_notice("Invalid target for entangling vines."))
		return FALSE

	var/loc = target.loc

	// Spawn 3-5 vines around the target's location randomly within a two tile range
	var/vine_count = 3 + rand(3)
	var/list/shuffled_range = shuffle(range(1, loc))
	for(var/turf/turf_in_range in shuffled_range)
		if(turf_in_range && isopenturf(turf_in_range) && !(/obj/structure/spacevine in turf_in_range.contents))
			new /obj/structure/spacevine(turf_in_range)
			vine_count -= 1
			if(vine_count == 0)
				break

    to_chat(user, span_notice("Thorny vines burst from the ground, ensnaring your foes!"))
    playsound(user, 'sound/foley/plantcross1.ogg', 50)
    return TRUE

