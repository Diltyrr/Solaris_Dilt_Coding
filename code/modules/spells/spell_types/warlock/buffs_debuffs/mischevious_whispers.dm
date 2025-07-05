/obj/effect/proc_holder/spell/invoked/mischievous_whispers
	name = "Mischievous Whispers"
	desc = "Sends eerie fey whispers into the target's mind, disrupting their focus and slowing their actions."
	sound = list('sound/vo/female/gen/laugh (1).ogg')
	active = FALSE

	recharge_time = 15 SECONDS
	range = 7
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane

	invocation = "Féth ar fuaim, mallacht romhat."
	invocation_type = "whisper"
	xp_gain = TRUE

/obj/effect/proc_holder/spell/invoked/mischievous_whispers/cast(list/targets, mob/living/user)
	var/mob/living/carbon/target = targets[1]

	if(!target)
		to_chat(user, span_notice("No valid target."))
		revert_cast()
		return FALSE

	if(!isliving(target))
		to_chat(user, span_notice("You can only cast this on living targets."))
		revert_cast()
		return FALSE

	if(target.has_status_effect(/datum/status_effect/debuff/mischievous_whispers))
		to_chat(user, span_notice("[target] is already affected."))
		revert_cast()
		return FALSE

	target.apply_status_effect(/datum/status_effect/debuff/mischievous_whispers)
	user.visible_message(span_notice("You hear faint, unsettling whispers in your mind."), span_notice("[target] looks distracted as eerie whispers surround them."))
	return TRUE

/datum/status_effect/debuff/mischievous_whispers
	id = "mischievous_whispers"
	effectedstats = list("perception" = -2, "speed" = -2)
	duration = 30 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/debuff/mischievous_whispers

/atom/movable/screen/alert/status_effect/debuff/mischievous_whispers
	name = "Mischievous whispers"
	desc = "Fey voices echo faintly in your mind, clouding your focus and muddling your movements."
