/obj/effect/proc_holder/spell/invoked/archfey_warlock_strip
	name = "strip clothes"
	desc = "Magically removes a piece of clothing from a nearby target."
	overlay_state = "bcry"
	releasedrain = 80
	charge_max = 3 MINUTES
	range = 1
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation_type = "none" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/archfey_warlock_strip/cast(list/targets, mob/user)
	. = ..()
	user.emote("giggle")
	var/mob/living/target = targets[1]
	if(iscarbon(target))
		var/obj/item/object = target.get_item_by_slot(pick(SLOT_GLOVES,SLOT_SHOES,SLOT_HEAD))
		if(!istype(object, /obj/item/clothing/head/roguetown/helmet))//Can't take helmets!
			target.dropItemToGround(object)
		user.log_message("has stripped a piece of clothing from [key_name(target)] via spell", LOG_ATTACK)
		target.log_message("has had a piece of clothing stripped by [key_name(user)] via spell", LOG_ATTACK)
	return TRUE

/obj/effect/proc_holder/spell/targeted/archfey_warlock_seelie_kiss
	name = "regenerative kiss"
	desc = "Heals a nearby ally with a magical kiss, restoring health and stamina but causing mild nausea."
	overlay_state = "heal"
	releasedrain = 0
	charge_max = 2 MINUTES
	range = 1
	invocation_type = "none" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/targeted/archfey_warlock_seelie_kiss/cast(list/targets, mob/user)
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.reagents.add_reagent_list(list(/datum/reagent/medicine/healthpot = 12, /datum/reagent/medicine/manapot = 12))
		target.add_nausea(9)
		to_chat(target, span_notice("I suddenly feel reinvigorated!"))
		to_chat(user, span_notice("I have reinvigorated [target] with a kiss."))
		user.log_message("has blessed [key_name(target)] with a kiss spell, healing them a little", LOG_ATTACK)
		target.log_message("has been blessed by [key_name(user)] with a kiss spell, healing them a little", LOG_ATTACK)
		user.emote("kiss")
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/summon_rat
	name = "call Beast"
	desc = "Summons a small rat or, rarely, a hostile giant rat."
	overlay_state = "dendor"
	releasedrain = 30
	charge_max = 2 MINUTES
	range = 7
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation = "Squeak!"
	invocation_type = "shout"

/obj/effect/proc_holder/spell/invoked/summon_rat/cast(list/targets, mob/user)
	. = ..()
	var/turf/T = get_turf(targets[1])
	user.emote("giggle")
	var/chance = rand(1,100)
	if(chance == 100)
		new /mob/living/simple_animal/hostile/retaliate/rogue/bigrat (T)
		user.log_message("has summoned a rous in an attempt to summon rat", LOG_GAME)
	else
		new /obj/item/reagent_containers/food/snacks/smallrat (T)
		user.log_message("has summoned a rat through the spell", LOG_GAME)
	return TRUE

/obj/effect/proc_holder/spell/targeted/roustame
	name = "tame rous"
	desc = "Calms a nearby hostile rous, turning them into loyal allies."
	range = 5
	overlay_state = "tamebeast"
	releasedrain = 30
	charge_max = 3 MINUTES
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation = "Feel my presence, and be calmed."
	invocation_type = "whisper" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/targeted/roustame/cast(list/targets, mob/user = usr)
	. = ..()
	visible_message(span_green("[usr] soothes the beast with Seelie dust."))
	var/tamed = FALSE
	for(var/mob/living/simple_animal/hostile/retaliate/rogue/bigrat/B in oview(2))
		if(!B.tame)
			B.tame = TRUE
			B.tamed()
			B.friends = list(user) //Makes the Rous not target the Seelie when on aggro
		B.enemies = list()
		B.aggressive = 0
		B.LoseTarget()
		tamed = B.tame
	user.log_message("has tamed a rous via the spell", LOG_GAME)
	return tamed
