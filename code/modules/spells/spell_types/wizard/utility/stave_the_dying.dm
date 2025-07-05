/obj/effect/proc_holder/spell/invoked/stave_the_dying //this is traditionally a cleric spell, but this is a version for arcane healer classes like apothecary and Woadspeaker
	name = "Stave the Dying"
	desc = "Cloak your fellow man in stitches of mana, preventing them from slipping into death for a short period of time."
	associated_skill = /datum/skill/magic/arcane
	miracle = FALSE
	cost = 1
	xp_gain = FALSE
	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	recharge_time = 2 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	spell_tier = ""
	invocation = "sem vulnere"
	invocation_type = "whisper"
	glow_color = GLOW_COLOR_BUFF
	glow_intensity = GLOW_INTENSITY_LOW
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	var/list/near_death_lines = list(
		"A haze begins to envelop me, but then suddenly recedes, as if warded back by some great light...",
		"A terrible weight bears down upon me, as if the wyrld itself were crushing me with its heft...",
		"The sound of a placid river drifts into hearing, followed by the ominous toll of a ferryman's bell...",
		"Some vast, immeasurably distant figure looms beyond my perception - I feel it, more than I see. It waits. It watches.",
	)

/obj/effect/proc_holder/spell/invoked/stave_the_dying/cast(list/targets, mob/living/carbon/human/user)
	. = ..()
	var/atom/target = targets[1]
	if (!isliving(target))
		revert_cast()
		return FALSE

	var/mob/living/living_target = target
	if (!user.Adjacent(target))
		to_chat(user, span_warning("I must be beside [living_target] to avert His gaze from [living_target.p_them()]!"))
		revert_cast()
		return FALSE
	
	// add the no-death trait to them....
	user.visible_message(span_notice("Sharp threads of mana spring from [user]'s fingers as [user.p_they()] place a hand near [living_target], The threads holding the blood in place for but a moment longer."), span_notice("I stand beside [living_target] and thread their wounds in wisp-like mana, staying His grasp for just a little while longer..."))
	to_chat(user, span_small("I must remain still and at [living_target]'s side..."))
	to_chat(living_target, span_warning("An odd sensation blossoms in my chest, cold and unknown..."))

	ADD_TRAIT(living_target, TRAIT_NODEATH, "spare_spell")

	var/our_arcane_skill = user.mind?.get_skill_level(associated_skill)
	var/tickspeed = 30 + (5 * our_arcane_skill)

	while (do_after(user, tickspeed, target = living_target))
		user.rogfat_add(1)

		living_target.adjustOxyLoss(-10)
		living_target.blood_volume = max((BLOOD_VOLUME_SURVIVE * 1.5), living_target.blood_volume)

		if (living_target.health <= 5)
			if (prob(5))
				to_chat(living_target, span_small(pick(near_death_lines)))
		if (user.rogstam > 0)
			user.rogstam_add(-50)
		else
			to_chat(span_warning("My focus runs dry - the threads snap!"))
			break
	
	REMOVE_TRAIT(living_target, TRAIT_NODEATH, "spare_spell")

	user.visible_message(span_danger("[user]'s concentration breaks, the threads snapping violently from [living_target] and into [user.p_their()] hand once more."), span_danger("My concentration breaks, and the threads snap, leaving them to their fate."))
