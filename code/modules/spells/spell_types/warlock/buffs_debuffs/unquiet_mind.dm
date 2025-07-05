/obj/effect/proc_holder/spell/self/unquiet_mind
	name = "Unquiet Mind"
	desc = "Your very presence grinds at the thoughts of those near you."
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE
	recharge_time = 2 SECONDS
	invocation = "Zha'runeth vel thagarn... the mind is not a vessel, but a wound."
	invocation_type = "whisper"
	associated_skill = /datum/skill/magic/arcane
	xp_gain = TRUE
	var/activated = FALSE

/obj/effect/proc_holder/spell/self/unquiet_mind/cast(mob/living/user, list/targets)
	. = ..()
	if(activated)
		user.remove_status_effect(/datum/status_effect/buff/unquiet_mind)
		activated = FALSE
		to_chat(user, span_notice("You draw your mind inward, the pressure on nearby thoughts receding."))
	else
		user.apply_status_effect(/datum/status_effect/buff/unquiet_mind)
		activated = TRUE
		to_chat(user, span_warning("You feel your mind unravel, pressing against the thoughts of others."))
	return TRUE

/datum/status_effect/buff/unquiet_mind
	id = "unquiet_mind"
	tick_interval = 2 SECONDS
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/buff/unquiet_mind

/atom/movable/screen/alert/status_effect/buff/unquiet_mind
	name = "Unquiet Mind"
	desc = "A psychic field radiates from you, disrupting nearby minds."

/datum/status_effect/buff/unquiet_mind/tick(mob/living/user)
	for(var/mob/living/carbon/carbon_targets in GLOB.player_list)
		if(prob(40) && get_dist(usr, carbon_targets) < 5 && !(usr == carbon_targets))
			to_chat(carbon_targets, span_warning("A wave of mental static washes over your thoughts."))
			carbon_targets.apply_status_effect(/datum/status_effect/debuff/psionic_scramble, 4 SECONDS)

/datum/status_effect/debuff/psionic_scramble
	id = "psionic_scramble"
	effectedstats = list("perception" = -2, "intelligence" = -2)
	duration = 4 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/debuff/psionic_scramble

/atom/movable/screen/alert/status_effect/debuff/psionic_scramble
	name = "Psionic Scramble"
	desc = "Your thoughts are clouded by ambient psychic interference."
