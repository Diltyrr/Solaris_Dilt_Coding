/obj/effect/proc_holder/spell/self/overclock_arm
	name = "Valiant Arm"
	desc = "Release the limiters on your bronze arm for an increase in strength."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	recharge_time = 5 SECONDS
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/craft/engineering //can be arcane, druidic, blood, holy
	cost = 1
	miracle = FALSE
	xp_gain = FALSE

var/ison = FALSE
var/akimbo = FALSE
	
/obj/effect/proc_holder/spell/self/overclock_arm/cast(list/targets, mob/user = usr)
	var/mob/living/target = usr
	var/obj/item/bodypart/right_arm = target.get_bodypart(BODY_ZONE_R_ARM)
	var/obj/item/bodypart/left_arm = target.get_bodypart(BODY_ZONE_L_ARM)
	if((right_arm) && (right_arm.status == BODYPART_ROBOTIC) || (left_arm) && (left_arm.status == BODYPART_ROBOTIC)) //do you even have a bronze arm to start with. useful if someone gets a prosthetic then finds their original arm
	else
		target.visible_message(span_info("[user] searches for something that isn't there..."), span_info("You can't reach the arms safety lever!")) //put your arm on dingus
		return
	if((right_arm) && (right_arm.status == BODYPART_ROBOTIC) && (left_arm) && (left_arm.status == BODYPART_ROBOTIC)) //are both arms bronze and attached?
		akimbo = TRUE
	else
		akimbo = FALSE
	if((ison) == FALSE && (akimbo) == FALSE) //dealing with one arm, and its off currently
		target.apply_status_effect(/datum/status_effect/buff/overclock_arm1)
		playsound(target, 'sound/magic/overclock_start.ogg', 90)
		do_sparks(3, TRUE, target)
		target.visible_message(span_info("[user] racks their arm, it begins to rev and whirr with mechanical strength!"), span_info("You grip the safety lever on your arm and cock it! The cogs inside begin to hurtle around with centrifugal force!"))
		ison = TRUE
		return
	if((ison) == TRUE && (akimbo) == FALSE) //one arm, on currently
		ison = FALSE
		target.remove_status_effect(/datum/status_effect/buff/overclock_arm1)
		playsound(target, 'sound/magic/overclock_end.ogg', 90)
		do_sparks(3, TRUE, target)
		target.visible_message(span_info("[user] slaps their arm, the metallic racket slows and dies down..."), span_info("You throw the safety lever back into place, the cogs rattle in relief..."))
		return
	if((ison) == FALSE && (akimbo) == TRUE) //Two arms, off currently
		target.apply_status_effect(/datum/status_effect/buff/overclock_arm2)
		playsound(target, 'sound/magic/overclock_start.ogg', 90)
		do_sparks(3, TRUE, target)
		target.visible_message(span_info("[user] slams their arms together, they begin to rev and whirr with mechanical strength!"), span_info("You hook your arms safety levers around each other and let it rip! The cogs inside begin to hurtle around with centrifugal force!"))
		ison = TRUE
		return
	if((ison) == TRUE && (akimbo) == TRUE) //Two arms, on currently
		ison = FALSE
		target.remove_status_effect(/datum/status_effect/buff/overclock_arm2)
		playsound(target, 'sound/magic/overclock_end.ogg', 90)
		do_sparks(3, TRUE, target)
		target.visible_message(span_info("[user] slaps their arms together, the metallic racket slows and dies down..."), span_info("You throw the safety levers back into place by pressing your arms together, the cogs rattle in relief..."))
		return

//One prosthetic arm, one organic arm

/datum/status_effect/buff/overclock_arm1
	id = "Valiant Arm"
	alert_type = /atom/movable/screen/alert/status_effect/buff/overclock_arm1
	effectedstats = list("strength" = 1)

/datum/status_effect/buff/overclock_arm1/tick()
	. = ..()
	var/mob/living/target = owner
	var/obj/item/bodypart/right_arm = target.get_bodypart(BODY_ZONE_R_ARM)
	var/obj/item/bodypart/left_arm = target.get_bodypart(BODY_ZONE_L_ARM)
	if((!left_arm) || (!right_arm)) //This will stop the buff if an organic arm is severed but thats fine imo. something something pain threshold.
		target.remove_status_effect(/datum/status_effect/buff/overclock_arm1)
		target.visible_message(span_info("[owner]'s arm socket sparks madly before sputtering out and dieing!"), span_info("Your arm socket erupts into sparks and heat before the machinery slowly dies!"))
		playsound(target, 'sound/magic/overclock_end.ogg', 90)
		do_sparks(3, TRUE, target)
		ison = FALSE
		return
	if(right_arm.status == BODYPART_ROBOTIC && right_arm.get_damage() <= 100)
		if(prob(10))
			target.apply_damage(3, BRUTE, BODY_ZONE_R_ARM)
			playsound(target, pick('sound/magic/overclock_tick1.ogg','sound/magic/overclock_tick2.ogg'), 120)
			target.visible_message(span_info("[owner]'s right arm rattles angrily with strength!"), span_info("Your right arm protests loudly and sparks!")) //Right arm tell, informs attackers where to aim to stop buff
			do_sparks(3, TRUE, target)
			return
		target.apply_damage(2, BRUTE, BODY_ZONE_R_ARM)
		playsound(target, pick('sound/magic/overclock_tick1.ogg','sound/magic/overclock_tick2.ogg'), 90)
		return
	if(left_arm.status == BODYPART_ROBOTIC && left_arm.get_damage() <= 100)
		if(prob(10))
			target.apply_damage(3, BRUTE, BODY_ZONE_L_ARM)
			playsound(target, pick('sound/magic/overclock_tick1.ogg','sound/magic/overclock_tick2.ogg'), 120)
			target.visible_message(span_info("[owner]'s left arm rattles angrily with strength!"), span_info("Your left arm protests loudly and sparks!")) //Left arm tell, informs attackers where to aim to stop buff
			do_sparks(3, TRUE, target)
			return
		target.apply_damage(2, BRUTE, BODY_ZONE_L_ARM)
		playsound(target, pick('sound/magic/overclock_tick1.ogg','sound/magic/overclock_tick2.ogg'), 90)
		return
	target.remove_status_effect(/datum/status_effect/buff/overclock_arm1)
	playsound(target, 'sound/magic/overclock_end.ogg', 90)
	do_sparks(3, TRUE, target)
	target.visible_message(span_info("[owner]'s arm makes a horrible noise as it sparks and goes silent!"), span_info("Your arm stills and goes limp, unable to withstand any more punishment!"))
	ison = FALSE

/atom/movable/screen/alert/status_effect/buff/overclock_arm1
	name = "Valiant Arm"
	desc = "My bronze limb's limiters have been turned off! It's slowly falling apart in exchange for increased strength!"
	icon_state = "buff"

//Two Prosthetic arms

/datum/status_effect/buff/overclock_arm2
	id = "Valorious Arms"
	alert_type = /atom/movable/screen/alert/status_effect/buff/overclock_arm2
	effectedstats = list("strength" = 2)

/datum/status_effect/buff/overclock_arm2/tick()
	. = ..()
	var/mob/living/target = owner
	var/obj/item/bodypart/right_arm = target.get_bodypart(BODY_ZONE_R_ARM)
	var/obj/item/bodypart/left_arm = target.get_bodypart(BODY_ZONE_L_ARM)
	if((!left_arm) || (!right_arm)) //both your arms still on there chief?
		target.remove_status_effect(/datum/status_effect/buff/overclock_arm2)
		target.visible_message(span_info("[owner]'s arm socket sparks madly before sputtering out and dieing!"), span_info("Your arm socket erupts into sparks and heat before the machinery slowly dies!"))
		playsound(target, 'sound/magic/overclock_end.ogg', 90)
		do_sparks(3, TRUE, target)
		ison = FALSE
		return
	if(right_arm.status == BODYPART_ROBOTIC && right_arm.get_damage() <= 100 && left_arm.status == BODYPART_ROBOTIC && left_arm.get_damage() <= 100)
		target.apply_damage(2, BRUTE, pick(BODY_ZONE_R_ARM,BODY_ZONE_L_ARM))
		playsound(target, pick('sound/magic/overclock_tick1.ogg','sound/magic/overclock_tick2.ogg'), 90)
		return
	target.remove_status_effect(/datum/status_effect/buff/overclock_arm2)
	playsound(target, 'sound/magic/overclock_end.ogg', 90)
	do_sparks(3, TRUE, target)
	target.visible_message(span_info("[owner]'s arm makes a horrible noise as it sparks and goes silent!"), span_info("Your arm stills and goes limp, unable to withstand any more punishment!"))
	ison = FALSE

/atom/movable/screen/alert/status_effect/buff/overclock_arm2
	name = "Valorious Arms"
	desc = "Both my bronze limbs limiters have been turned off! They are slowly falling apart in exchange for increased strength!"
	icon_state = "buff"
