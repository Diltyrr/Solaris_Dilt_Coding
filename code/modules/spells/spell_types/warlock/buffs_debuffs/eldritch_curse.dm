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
	sound = 'sound/magic/heal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	recharge_time = 20 SECONDS
	miracle = FALSE
	var/patronname = ""
	var/datum/status_effect/buff/eldritchcurse/curse

/obj/effect/proc_holder/spell/invoked/eldritchcurse/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]

		if(target.has_status_effect(curse))
			target.remove_status_effect(curse)
		else
			target.apply_status_effect(curse) //apply debuff

/datum/status_effect/buff/eldritchcurse
	id = "eldritchcurse"
	effectedstats = list("fortune" = -4) // This default case will be overridden for warlocks. Low luck is the closest to a "generic" curse, randomly failing a bit at everything.
	alert_type = /atom/movable/screen/alert/status_effect/buff/eldritchcurse
	duration = -1

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
	effectedstats = list("speed" = -2,"strength" = -2)

/datum/status_effect/buff/eldritchcurse/undead
	effectedstats = list("constitution" = -4)

/atom/movable/screen/alert/status_effect/buff/eldritchcurse
	name = "eldritch curse"
	desc = "I am cursed by a lesser diety."
	icon_state = "debuff"
