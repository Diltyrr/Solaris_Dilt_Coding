/obj/effect/proc_holder/spell/invoked/seelie_dust
	name = "Seelie Dust"
	overlay_state = "createlight"
	releasedrain = 50
	recharge_time = 150 SECONDS
	range = 3
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation = " blows some dust from their palm."
	invocation_type = "emote"
	spell_tier = 1
	associated_skill = /datum/skill/magic/arcane
	xp_gain = TRUE

/obj/effect/proc_holder/spell/invoked/seelie_dust/cast(list/targets, mob/living/user)
	. = ..()
	user.emote("giggle")
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.reagents.add_reagent(/datum/reagent/seelie_drugs, 10)
		user.log_message("has drugged [key_name(target)] with Seelie dust", LOG_ATTACK)
	return TRUE
