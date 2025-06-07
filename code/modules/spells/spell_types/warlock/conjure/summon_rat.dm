/obj/effect/proc_holder/spell/invoked/summon_rat
	name = "call Beast"
	desc = "Summons a small rat or, rarely, a hostile giant rat."
	overlay_state = "dendor"
	releasedrain = 30
	recharge_time = 2 MINUTES
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
