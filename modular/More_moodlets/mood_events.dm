///Drakians and kobolds get a mood boost for sleeping with some amount of coin/gems. Though if they do, they will get a mood debuff if they don't sleep in a hoard later.
/mob/living/carbon/human
	var/gold_napped = FALSE


/mob/living/carbon/IsSleeping()
	. = ..()
	if (!istype(src, /mob/living/carbon/human))
		return

	var/mob/living/carbon/human/napper = src

	if (!(napper.dna.species.name == "Kobold" || !napper.dna.species.name == "Drakian"))
		return

	var/total_value = 0
	var/threshold = 75 // How big should a hoard be to give a bonus..

	for (var/obj/item/item_checked in napper.loc.contents)
		if (istype(item_checked, /obj/item/roguecoin) || istype(item_checked, /obj/item/roguegem))
			total_value += item_checked.sellprice

	if (total_value >= threshold)
		napper.add_stress(/datum/stressevent/gold_nap)
		napper.vars["gold_napped"] = TRUE
	else if (napper.vars["gold_napped"] == TRUE)
		napper.add_stress(/datum/stressevent/goldless_sleep)


///We get a small mood buff if we read a book.
/obj/item/book/attack_self(mob/user)
	. = ..()
	if(!user.is_literate())
		return
	user.add_stress(/datum/stressevent/good_book)

///Killing a boss rewards a small mood buff to the one finishing it and..
/mob/living/simple_animal/hostile/death()
	. = ..()

	var/list/boss_list = list(
		/mob/living/simple_animal/hostile/retaliate/rogue/dragon/broodmother, 
		/mob/living/simple_animal/hostile/boss/lich, 
		/mob/living/simple_animal/hostile/retaliate/rogue/dragon/
	)

	if(type in boss_list)
		if(src.lastattacker)
			var/mob/living/finisher = src.lastattacker 
			finisher.add_stress(/datum/stressevent/boss_finisher)
		boss_killer_mood(src)

///..it rewards a list of mood buffs to anyone in sight.
/mob/living/simple_animal/hostile/proc/boss_killer_mood(mob/killed)
	var/list/stress_to_add = list(
		/datum/stressevent/victory_rush,
		/datum/stressevent/wreathed_in_glory,
		/datum/stressevent/champion,
		/datum/stressevent/boss_slayer,
	)
	for(var/mob/living/carbon/killer in GLOB.player_list)
		if(can_see(killer, killed, 8))
			killer.add_stress_list(stress_to_add)

///If someone we can't see inspect us, we get a small mood debuff.
/mob/living/carbon/human/examine(mob/user)
	. = ..()
	if(!src.rogue_sneaking || src != user || (src.mob_timers[MT_INVISIBILITY] <= world.time))
		return
	user.add_stress(/datum/stressevent/watched)
