/obj/effect/proc_holder/spell/invoked/archfey_warlock_strip
	name = "strip clothes"
	desc = "Magically removes a piece of clothing from a nearby target."
	overlay_state = "bcry"
	releasedrain = 80
	recharge_time = 3 MINUTES
	range = 1
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation_type = "none"

/obj/effect/proc_holder/spell/invoked/archfey_warlock_strip/cast(list/targets, mob/user)
	. = ..()
	user.emote("giggle")
	var/mob/living/target = targets[1]
	if(iscarbon(target))
		var/obj/item/object = target.get_item_by_slot(pick(SLOT_GLOVES,SLOT_SHOES,SLOT_HEAD))
		if(!istype(object, /obj/item/clothing/head/roguetown/helmet))//Can't take helmets!
			target.dropItemToGround(object)
		user.log_message("has stripped a piece of clothing from [key_name(target)] via spell", LOG_ATTACK)
		target.log_message("has had a piece of clothing stripped by [key_name(user)] via spell", LOG_ATTACK)
	return TRUE
