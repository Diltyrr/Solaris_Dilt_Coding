/obj/effect/proc_holder/spell/invoked/eldritchhealing/any
	ignore_faithless = TRUE

/obj/effect/proc_holder/spell/invoked/eldritchhealing
	name = "eldritch healing"
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
	var/targetnotification = "Shimmering arcane energy lessens my pain!" // This (and the line below) is a default message; Warlocks with patrons will have it overwritten in their job file.
	var/othernotification = "is surrounded by shimmering arcane energy."
	var/ignore_faithless = FALSE

/obj/effect/proc_holder/spell/invoked/eldritchhealing/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		target.visible_message(span_info("[target] "+othernotification), span_notice(targetnotification))
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(50, 50))
					C.update_damage_overlays()
				if(affecting.heal_wounds(50))
					C.update_damage_overlays()
		else
			target.adjustBruteLoss(-50)
			target.adjustFireLoss(-50)
		target.adjustToxLoss(-50)
		target.adjustOxyLoss(-50)
		target.blood_volume += BLOOD_VOLUME_SURVIVE
		return TRUE
	return FALSE
