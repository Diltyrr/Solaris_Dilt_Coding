/obj/effect/proc_holder/spell/invoked/warlock/summon_weapon
	name = "Summon Pact Weapon"
	desc = "Summon your bound weapon to your side, reforging it if it has been lost."
	overlay_state = "arcane_cast"
	invocation = "Duregos meklom."
	invocation_type = "whisper"
	chargedloop = /datum/looping_sound/invokegen
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_LOW
	recharge_time = 10 SECONDS
	chargetime = 5 SECONDS
	xp_gain = TRUE

/obj/effect/proc_holder/spell/invoked/warlock/summon_weapon/cast(list/targets, mob/living/carbon/human/user = usr)
	if(!user.mind || !islist(user.mind.warlock_weapon_types) || !length(user.mind.warlock_weapon_types))
		to_chat(user, span_warning("You feel no weapon bound to your soul."))
		revert_cast()
		return FALSE

	// Ensure weapon list exists and has same length
	if(!islist(user.mind.warlock_weapons))
		user.mind.warlock_weapons = list()
	while(length(user.mind.warlock_weapons) < length(user.mind.warlock_weapon_types))
		user.mind.warlock_weapons += null

	var/summoned_any = FALSE

	for(var/i in 1 to length(user.mind.warlock_weapon_types))
		var/item_type = user.mind.warlock_weapon_types[i]
		var/obj/item/I = user.mind.warlock_weapons[i]

		if(I && !QDELETED(I))
			// Already exists, summon it
			to_chat(user, span_notice("Your blade tears through the veil and returns to your hand!"))
			user.put_in_hands(I)
			summoned_any = TRUE
		else
			// Reforge it
			var/obj/item/new_weapon = new item_type(user.loc)
			new_weapon.AddComponent(/datum/component/pact_weapon, user, user.patronchoice)
			new_weapon.AddComponent(/datum/component/singing_item, user, user.patronchoice, new_weapon)

			user.mind.warlock_weapons[i] = new_weapon
			to_chat(user, span_notice("You reach into the void... and draw forth your bound weapon anew."))
			user.put_in_hands(new_weapon)
			summoned_any = TRUE

	return summoned_any
