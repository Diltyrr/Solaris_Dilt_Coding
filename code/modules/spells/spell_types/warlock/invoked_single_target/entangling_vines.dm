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
	. = ..()
	var/target = targets[1]
	var/turf/loc

	if(!target || (!isliving(target) && !istype(target, /turf/open)))
		to_chat(user, span_notice("The spell fizzles — no valid target."))
		revert_cast()
		return FALSE

	if (istype(target, /turf))
		loc = target
	else
		loc = get_turf(target)

	// Spawn 3-5 vines around the target's location
	var/vine_count = 3 + rand(3)
	var/list/shuffled_range = shuffle(range(1, loc))
	var/vines_spawned = 0

	for(var/turf/turf_in_range in shuffled_range)
		if(turf_in_range && isopenturf(turf_in_range) && !(/obj/structure/spacevine in turf_in_range.contents))
			new /obj/structure/spacevine(turf_in_range)
			vines_spawned++
			if(vines_spawned >= vine_count)
				break

	// Spell messages
	to_chat(user, span_notice("You call upon nature to bind your foes with thorny vines!"))
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.visible_message(span_warning("[target] is surrounded by writhing vines!"), span_warning("Thick vines erupt from the ground around you!"))

	return TRUE
