/obj/effect/proc_holder/spell/invoked/eldritchhealing
	name = "Eldritch Healing"
	desc = "Restores health with shimmering arcane energy."
	overlay_state = null
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	sound = 'sound/magic/heal.ogg'
	invocation = "Dóiteáin, bí daingean."
	invocation_type = "whisper"
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	recharge_time = 20 SECONDS
	miracle = FALSE
	var/patronname = ""
	var/targetnotification = "Shimmering arcane energy lessens my pain!"
	var/othernotification = "is surrounded by shimmering arcane energy."
	var/ignore_faithless = FALSE

/obj/effect/proc_holder/spell/invoked/eldritchhealing/cast(list/targets, mob/living/user)
	. = ..()
	if (!isliving(targets[1]))
		revert_cast()
		return FALSE

	var/mob/living/target = targets[1]
	target.visible_message(span_info("[target] [othernotification]"), span_notice(targetnotification))

	var/healing = 2.5 // Flat value, no patron bonuses like lesser_heal

	if (ishuman(target))
		var/mob/living/carbon/human/H = target
		var/no_embeds = TRUE
		var/list/embeds = H.get_embedded_objects()
		if (length(embeds))
			for (var/object in embeds)
				if (!istype(object, /obj/item/natural/worms/leech))
					no_embeds = FALSE
					break
		if (no_embeds)
			target.apply_status_effect(/datum/status_effect/buff/healing, healing)
		else
			target.visible_message(span_warning("[target]'s wounds tear and rip around embedded objects!"),
			                       span_warning("Agonising pain shoots through your body as eldritch energies try to close your wounds!"))
			H.adjustBruteLoss(20)
			playsound(target, 'sound/combat/dismemberment/dismem (2).ogg', 100)
			H.emote("agony")
	else
		// fallback for non-human living mobs
		target.apply_status_effect(/datum/status_effect/buff/healing, healing)
	return TRUE
