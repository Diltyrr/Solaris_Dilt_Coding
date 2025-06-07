/obj/effect/proc_holder/spell/invoked/magicstone
	name = "Magic Stone"
	desc = "Infuses a stone with magical energy, increasing its damage and throwing force."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 10
	recharge_time = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 1
	spell_tier = 2

	xp_gain = TRUE
	miracle = FALSE

	invocation = "Esto acutus et fortis."
	invocation_type = "whisper"
	var/magic_color = "#c8daff"

/obj/effect/proc_holder/spell/invoked/magicstone/cast(list/targets, mob/living/user)
	if(istype(targets[1], /obj/item/natural/stone))
		var/obj/item/natural/stone/S = targets[1]
		if (!S.magicstone)
			to_chat(user, "<span class='info'>[S] is infused with magical energy!</span>")
			S.name = "magic "+S.name
			S.force *= 1.5 //ouchy
			S.throwforce *= 1.5 //ouchy
			S.color = magic_color
			S.magicstone = TRUE
			var/mutable_appearance/magic_overlay = mutable_appearance('icons/effects/effects.dmi', "electricity")
			//PLAY A SOUND OR SOMETHING
			S.add_overlay(magic_overlay)
		else
			to_chat(user, span_warning("That stone can't get any more magical!"))
			revert_cast()
	else
		to_chat(user, span_warning("There is no stone here!"))
		revert_cast()
