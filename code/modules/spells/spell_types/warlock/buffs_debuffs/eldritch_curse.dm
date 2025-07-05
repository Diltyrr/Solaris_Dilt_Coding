/obj/effect/proc_holder/spell/invoked/eldritchcurse
	name = "curse of the "
	desc = "Inflicts a lingering curse that weakens various abilities depending on patron."
	overlay_state = null
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	sound = 'sound/misc/bellold.ogg'
	invocation = "Ceilt an dhorchadais ort."
	invocation_type = "whisper"
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	recharge_time = 20 SECONDS
	miracle = FALSE
	var/patronname = ""
	var/datum/status_effect/buff/eldritchcurse/curse

/obj/effect/proc_holder/spell/invoked/eldritchcurse/cast(list/targets, mob/living/user)
	. = .. ()
	if(!isliving(targets[1]))
		to_chat(user, span_warning("Your curse fades before it can take hold..."))
		return

	var/mob/living/carbon/target = targets[1]

	// Toggle curse
	if(target.has_status_effect(curse))
		to_chat(user, span_notice("You lift the curse from [target]."))
		to_chat(target, span_good("The oppressive energy surrounding you dissipates."))
		target.visible_message(span_notice("[target] exhales sharply as their curse is lifted."), target)
		target.remove_status_effect(curse)
	else
		to_chat(user, span_danger("You invoke the curse of [patronname] upon [target]!"))
		to_chat(target, span_danger("A dreadful chill settles over you... you have been cursed!"))
		target.visible_message(span_warning("[target] flinches as a dark curse wraps around them."), target)
		target.apply_status_effect(curse)


/datum/status_effect/buff/eldritchcurse
	id = "eldritchcurse"
	effectedstats = list("fortune" = -4) // This default case will be overridden for warlocks. Low luck is the closest to a "generic" curse, randomly failing a bit at everything.
	alert_type = /atom/movable/screen/alert/status_effect/buff/eldritchcurse
	duration = 10 MINUTES

/datum/status_effect/buff/eldritchcurse/archfey
	effectedstats = list("intelligence" = -2, "fortune" = -2)

/datum/status_effect/buff/eldritchcurse/celestial
	effectedstats = list("constitution" = -2, "perception" = -2)

/datum/status_effect/buff/eldritchcurse/fathomless
	effectedstats = list("endurance" = -2, "perception" = -2)

/datum/status_effect/buff/eldritchcurse/genie
	effectedstats = list("fortune" = -4)

/datum/status_effect/buff/eldritchcurse/goo
	effectedstats = list("intelligence" = -2, "constitution" = -2)

/datum/status_effect/buff/eldritchcurse/hexblade
	effectedstats = list("speed" = -1,"strength" = -1)

/datum/status_effect/buff/eldritchcurse/undead
	effectedstats = list("constitution" = -4)

/datum/status_effect/buff/eldritchcurse/fiend
	effectedstats = list("constitution" = -2, "endurance" = -2)

/atom/movable/screen/alert/status_effect/buff/eldritchcurse
	name = "eldritch curse"
	desc = "I am cursed."
	icon_state = "debuff"
