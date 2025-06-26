/obj/effect/proc_holder/spell/self/trickarm
	name = "Trick Arm"
	desc = "Eject a field knife into your hand."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	recharge_time = 30 SECONDS
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/trickarm_eject.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/craft/engineering //can be arcane, druidic, blood, holy
	cost = 1
	miracle = FALSE
	xp_gain = FALSE

	invocation = "Bracchium Mendacis." //Roughly 'Liar's Arm' in latin.
	invocation_type = "whisper" //can be none, whisper, emote and shout

	var/obj/item/item
	var/item_type = /obj/item/rogueweapon/armknife
	var/delete_old = TRUE //TRUE to delete the last summoned object if it's still there, FALSE for infinite item stream weeeee

/obj/effect/proc_holder/spell/self/trickarm/cast(list/targets, mob/user = usr)
	if (delete_old && item && !QDELETED(item))
		QDEL_NULL(item)
	if(user.dropItemToGround(user.get_active_held_item()))
		do_sparks(1, TRUE, usr)
		user.put_in_hands(make_item(), TRUE)
		user.visible_message(span_info("[user]'s arm alights mechanically as a knife ejects from the wrist!"), span_info("Your arm sparks as you effortlessly eject a field knife into your hand."))
	return TRUE

/obj/effect/proc_holder/spell/self/trickarm/proc/make_item()
	item = new item_type
	return item
