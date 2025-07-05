/datum/status_effect/debuff/rooted
	id = "rooted"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/rooted
	duration = 5 SECONDS

/atom/movable/screen/alert/status_effect/debuff/rooted
	name = "Rooted"
	desc = "You are rooted in place by magical vines! You cannot move until the effect wears off."

/datum/status_effect/debuff/rooted/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(prevent_movement))

/datum/status_effect/debuff/rooted/proc/prevent_movement(mob/living/source, newloc)
    SIGNAL_HANDLER
    if(source == owner)
        to_chat(owner, span_warning("You are rooted in place and cannot move!"))
        return COMPONENT_MOVABLE_BLOCK_PRE_MOVE // This blocks the move

/datum/status_effect/debuff/rooted/on_remove()
    UnregisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE)

/datum/status_effect/debuff/singcurse
	id = "singingcurse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/singcurse
	duration = 20 SECONDS

/atom/movable/screen/alert/status_effect/debuff/singcurse
	name = "Singing Curse"
	desc = "You are compelled to sing everything you say!"

/datum/status_effect/buff/shield
	id = "shield"
	alert_type = /atom/movable/screen/alert/status_effect/buff/shield
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/buff/shield
	name = "Shield"
	desc = "You are surrounded by a magical shield that will absorb one attack!"

/datum/status_effect/buff/shield/on_apply()
    . = ..()
    RegisterSignal(owner, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_take_damage))

/datum/status_effect/buff/shield/on_remove()
    UnregisterSignal(owner, COMSIG_MOB_APPLY_DAMAGE)

/datum/status_effect/buff/shield/proc/on_take_damage(datum/source, datum/signal_damage/signal_data)
    SIGNAL_HANDLER

    // Notify players
    owner.visible_message(
        span_notice("[owner] is protected by a magical shield!"),
        span_notice("You feel a magical shield absorb the attack!")
    )

    // Remove the shield
    owner.remove_status_effect(src)

    // Cancel the damage
    signal_data.cancel = TRUE

/mob/living/carbon/proc/remove_night_vision(mob/living/target, mob/living/user)
	target.visible_message(span_notice("[target]'s eyes lose their night vision glow."))
	REMOVE_TRAIT(target, TRAIT_NIGHT_VISION, user)

/datum/status_effect/debuff/complimentcurse
	id = "complimentcurse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/complimentcurse
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/debuff/complimentcurse
	name = "Compliment Curse"
	desc = "You are compelled to compliment the next person you see!"

/datum/status_effect/debuff/questioncurse
	id = "questioncurse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/questioncurse
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/debuff/questioncurse
	name = "Question Curse"
	desc = "You are compelled to speak only in questions!"

/datum/status_effect/debuff/selfcomplimentcurse
	id = "selfcomplimentcurse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/selfcomplimentcurse
	duration = 20 SECONDS

/atom/movable/screen/alert/status_effect/debuff/selfcomplimentcurse
	name = "Self-Compliment Curse"
	desc = "You are compelled to compliment yourself!"

/datum/status_effect/debuff/mimiccurse
	id = "mimiccurse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/mimiccurse
	duration = 20 SECONDS

/atom/movable/screen/alert/status_effect/debuff/mimiccurse
	name = "Mimic Curse"
	desc = "You are compelled to mimic the last person who spoke!"

/datum/status_effect/debuff/secretcurse
	id = "Secret Curse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/secret
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/debuff/secret
	name = "Secret Curse"
	desc = "You are compelled to tell a secret!"

/datum/status_effect/buff/verdant_wild_gift
	id = "Verdant Wild Gift"
	effectedstats = list("intelligence" = 4)
	duration = 30 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/buff/verdant_wild_gift

/atom/movable/screen/alert/status_effect/buff/verdant_wild_gift
	name = "Verdant Wild Gift"
	desc = "Your mind is momentarily sharpened by fey magic. Everything feels brighter, faster, and more clever."
