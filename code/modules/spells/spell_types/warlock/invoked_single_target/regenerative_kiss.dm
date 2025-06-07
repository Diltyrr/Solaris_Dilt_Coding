/obj/effect/proc_holder/spell/invoked/archfey_warlock_seelie_kiss
	name = "regenerative kiss"
	desc = "Heals a nearby ally with a magical kiss, restoring health and stamina but causing mild nausea."
	overlay_state = "heal"
	releasedrain = 0
	recharge_time = 2 MINUTES
	range = 1
	invocation_type = "none" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/archfey_warlock_seelie_kiss/cast(list/targets, mob/user)
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
