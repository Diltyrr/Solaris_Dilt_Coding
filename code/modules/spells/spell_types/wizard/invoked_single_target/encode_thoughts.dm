/obj/effect/proc_holder/spell/targeted/encodethoughts
	name = "Encode Thoughts"
	desc = "Latch onto the mind of one who is nearby, weaving a particular thought into their mind."
	name = "Encode Thoughts"
	overlay_state = "null"
	releasedrain = 25
	chargetime = 1
	recharge_time = 10 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 1

	xp_gain = TRUE
	miracle = FALSE

	invocation = ""
	invocation_type = "whisper"
	include_user = FALSE

	spell_tier = 2

/obj/effect/proc_holder/spell/targeted/encodethoughts/cast(list/targets, mob/user)
	. = ..()
	for(var/mob/living/carbon/C in targets)
		if(!C)
			return
		var/message = stripped_input(user, "What thought do you wish to weave into [C]'s mind?")
		if(!message)
			return
		to_chat(C, "Your mind thinks to itself: </span><font color=#7246ff>\"[message]\"</font>")
		to_chat(user, "I pluck the strings of [C]'s mind")
		log_game("[key_name(user)] sent a thought to [key_name(C)] with contents [message]")
		return TRUE
	to_chat(user, span_warning("I wasn't able to find a mind to weave here."))
	revert_cast()

/obj/effect/proc_holder/spell/targeted/encodethoughts/test
	antimagic_allowed = TRUE
