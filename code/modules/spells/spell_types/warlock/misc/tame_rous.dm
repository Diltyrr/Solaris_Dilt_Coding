/obj/effect/proc_holder/spell/targeted/roustame
	name = "tame rous"
	desc = "Calms a nearby hostile rous, turning them into loyal allies."
	range = 5
	overlay_state = "tamebeast"
	releasedrain = 30
	recharge_time = 3 MINUTES
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
