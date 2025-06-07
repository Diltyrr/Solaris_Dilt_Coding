/obj/effect/proc_holder/spell/self/primalsavagery
	name = "Primal Savagery"
	desc = "Empowers you with venomous fangs, adding poison to your bite attacks for 30 seconds."
	clothes_req = FALSE
	range = 8
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	recharge_time = 60 SECONDS

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/druidic
	cost = 2
	spell_tier = 2

	xp_gain = TRUE
	miracle = FALSE

	invocation = "Dentes Serpentis."
	invocation_type = "whisper"

/obj/effect/proc_holder/spell/self/primalsavagery/cast(mob/user = usr)
	var/mob/living/target = user
	target.apply_status_effect(/datum/status_effect/buff/primalsavagery)
	ADD_TRAIT(target, TRAIT_POISONBITE, TRAIT_GENERIC)
	user.visible_message(span_info("[user] looks more primal!"), span_info("You feel more primal."))

/datum/status_effect/buff/primalsavagery
	id = "primal savagery"
	alert_type = /atom/movable/screen/alert/status_effect/buff/primalsavagery
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/buff/primalsavagery
	name = "Primal Savagery"
	desc = "I have grown venomous fangs."
	icon_state = "buff"

/datum/status_effect/buff/primalsavagery/on_remove()
	var/mob/living/target = owner
	REMOVE_TRAIT(target, TRAIT_POISONBITE, TRAIT_GENERIC)
	. = ..()
