/obj/effect/proc_holder/spell/invoked/verdant_blessing
	name = "Verdant Blessing"
	desc = "A gentle blessing from the Verdant Court, granting luck"
	overlay_state = "nature_glow"
	sound = list('sound/vo/mobs/bird/CROW_01.ogg')
	active = FALSE

	recharge_time = 60 SECONDS

	warnie = "spellwarning"

	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	xp_gain = TRUE

	invocation = "Bendacht na Féile."
	invocation_type = "whisper"

	range = 0
	clothes_req = FALSE
	movement_interrupt = FALSE
	releasedrain = 50
	chargedrain = 5
	chargetime = 3

/obj/effect/proc_holder/spell/invoked/verdant_blessing/cast(list/targets, mob/living/user)
	var/mob/living/carbon/target = targets[1]

	if(!target)
		to_chat(user, span_notice("No valid target."))
		return FALSE

	if(!isliving(target))
		to_chat(user, span_notice("You can only cast this on living targets."))
		return FALSE

	if(target.has_status_effect(/datum/status_effect/buff/verdant_blessing))
		to_chat(user, span_notice("[target] is already blessed."))
		return FALSE

	target.apply_status_effect(/datum/status_effect/buff/verdant_blessing)
	user.visible_message(span_notice("A soothing green light surrounds you, filling you with fortune."), span_notice("[target] glows softly with a verdant blessing."))
	playsound(user, 'sound/magic/magearmorup.ogg', 50)
	return TRUE


/datum/status_effect/buff/verdant_blessing
	id = "verdant_blessing"
	alert_type = /atom/movable/screen/alert/status_effect/buff/verdant_blessing
	effectedstats = list("fortune" = 3)
	duration = 5 MINUTES

/atom/movable/screen/alert/status_effect/buff/verdant_blessing
	name = "Verdant Blessing"
	desc = "The blessings of the Verdant Court enhance your fortune."
