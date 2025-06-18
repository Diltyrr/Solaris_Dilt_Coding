/proc/trigger_wild_magic(list/targets, mob/living/carbon/user, /obj/effect/proc_holder/spell/spell)
	var/effect = rand(1, 50)
	switch(effect)
		if(1)
			// All targets and user are surrounded by a ring of blooming flowers
			for(var/mob/living/carbon/T in (targets + user))
				// Only spawn flowers if T.loc is open and doesn't have structures
				var/turf/flower_turf = T.loc
				if(flower_turf && !flower_turf.density && !flower_turf.opacity)
					var/has_structure = FALSE
					for(var/obj/O in flower_turf)
						if(istype(O, /obj/structure))
							has_structure = TRUE
							break
					if(!has_structure)
						for(var/i = 1, i <= 8, i++)
							new /obj/structure/flora/roguegrass/herb/random(flower_turf)
			user.visible_message(span_notice("A ring of vibrant flowers blooms around everyone!"))
		if(2)
			// Everyone is briefly invisible (faerie glamour)
			for(var/mob/living/carbon/T in (targets + user))
				if(T.anti_magic_check(TRUE, TRUE))
					continue
				T.visible_message(span_warning("[T] starts to fade into thin air!"), span_notice("You start to become invisible!"))
				animate(T, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
				T.mob_timers[MT_INVISIBILITY] = world.time + 10 SECONDS
				addtimer(CALLBACK(T, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 10 SECONDS)
				addtimer(CALLBACK(T, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[T] fades back into view."), span_notice("You become visible again.")), 10 SECONDS)
			user.visible_message(span_notice("A shimmering glamour makes everyone vanish for a moment!"))
		if(3)
			for(var/mob/living/carbon/T in (targets + user))
				for(var/i = 1, i <= 10, i++)
					new /obj/effect/illusion/mote(T.loc)
				T.visible_message(span_notice("[T] is surrounded by swirling motes of magical light!"))
			user.visible_message(span_notice("Wild magic surrounds everyone with swirling motes of light!"))
		if(4)
			// Butterflies swirl around everyone
			for(var/mob/living/carbon/T in (targets + user))
				for(var/i = 1, i <= 6, i++)
					new /obj/effect/illusion/butterfly(T.loc)
			user.visible_message(span_notice("A cloud of colorful butterflies swirls around everyone!"))
		if(5)
			// Everyone is compelled to speak in rhyme (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/debuff/rhymecurse)
			user.visible_message(span_notice("A mischievous fey curse compels everyone to speak in rhyme!"))
		if(6)
			// Harmless illusions: hair color, glowing eyes, skin sparkles, antlers, all revert after 15 seconds
			for(var/mob/living/carbon/human/T in (targets + user))
				var/illusion = pick("hair", "eyes", "skin", "antlers")
				switch(illusion)
					if("hair")
						var/old_color = T.hair_color
						T.hair_color = "#00FF00" // bright green
						T.update_hair()
						T.visible_message(span_notice("[T]'s hair turns bright green!"))
						addtimer(CALLBACK(T, TYPE_PROC_REF(/mob/living/carbon/human, reset_hair_color), T, old_color), 15 SECONDS)
					if("eyes")
						var/old_eye_color = T.eye_color
						T.eye_color = "#00FFCC" // faerie blue
						var/obj/item/organ/eyes/eyes = T.getorganslot(ORGAN_SLOT_EYES)
						if(eyes)
							eyes.Remove(T)
							eyes.eye_color = T.eye_color
							eyes.Insert(T, TRUE, FALSE)
						T.update_body_parts()
						T.visible_message(span_notice("[T]'s eyes glow with faerie light!"))
						addtimer(CALLBACK(T, TYPE_PROC_REF(/mob/living/carbon/human, reset_eye_color), T, old_eye_color), 15 SECONDS)
					if("skin")
						T.overlays += image('icons/effects/illusions.dmi', "sparkle")
						T.visible_message(span_notice("[T]'s skin sparkles with motes of magic!"))
						addtimer(CALLBACK(T, TYPE_PROC_REF(/mob/living/carbon/human, remove_sparkle_overlay)), 15 SECONDS)
					if("antlers")
						var/obj/item/bodypart/head/head = T.get_bodypart(BODY_ZONE_HEAD)
						if(head)
							var/datum/sprite_accessory/horns/antlers/antlers = new /datum/sprite_accessory/horns/antlers()
							head.add_bodypart_feature(antlers)
							T.update_body_parts()
							T.visible_message(span_notice("[T] sprouts illusory antlers!"))
							addtimer(CALLBACK(T, TYPE_PROC_REF(/mob/living/carbon/human, remove_antlers_illusion), antlers), 15 SECONDS)
			user.visible_message(span_notice("Fey magic weaves harmless illusions over everyone!"))
		if(7)
			// Everyone is rooted in place by magical vines
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/debuff/rooted)
			user.visible_message(span_warning("Vines erupt from the ground, rooting everyone in place!"))
		if(8)
			// Faerie dust heals everyone a small amount
			for(var/mob/living/carbon/T in (targets + user))
				T.adjustBruteLoss(-5)
				T.adjustFireLoss(-5)
				T.adjustToxLoss(-5)
				T.adjustOxyLoss(-5)
				T.visible_message(span_notice("Sparkling faerie dust heals [T] slightly!"))
			user.visible_message(span_notice("Faerie dust rains from above, mending minor wounds!"))
		if(9)
			// Everyone laughs uncontrollably (stun or emote effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/debuff/laughter, 6 SECONDS)
			user.visible_message(span_notice("A wave of fey mirth causes everyone to burst into laughter!"))
		if(10)
			// A random harmless animal appears at each person's feet
			var/list/animal_types = list(
				/mob/living/simple_animal/butterfly,
				/mob/living/simple_animal/chick,
				/mob/living/simple_animal/chicken,
				/mob/living/simple_animal/mouse,
				/mob/living/simple_animal/mudcrabcrab
			)
			for(var/mob/living/carbon/T in (targets + user))
				var/mob/living/simple_animal/animal_to_spawn = pick(animal_types)
				var/mob/living/simple_animal/spawned = new animal_to_spawn(T.loc)
				spawned.name = "Wild [animal_to_spawn.name]"
			user.visible_message(span_notice("Tiny woodland creatures scamper out of nowhere!"))
		if(11)
			// User and targets swap places randomly using forceMove for robust movement
			var/list/all = (targets + user)
			all = shuffle(all)
			var/list/original_locs = list()
			for(var/i = 1, i <= all.len, i++)
				var/atom/movable/A = all[i]
				original_locs += A.loc
			for(var/i = 1, i <= all.len, i++)
				var/next_index = (i % all.len) + 1
				var/dest = original_locs[next_index]
				if(istype(dest, /turf) && istype(all[i], /atom/movable))
					var/atom/movable/M = all[i]
					M.forceMove(dest)
			user.visible_message(span_warning("Reality twists!"))
		if(12)
			// Everyone is surrounded by a shield that absorbs one attack
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/buff/shield, 30 SECONDS)
			user.visible_message(span_notice("A shimmering shield surrounds everyone!"))
		if(13)
			// Everyone is randomly teleported a short distance
			for(var/mob/living/carbon/T in (targets + user))
				step(T, pick(GLOB.cardinals))
			user.visible_message(span_notice("Wild magic scatters everyone unpredictably!"))
		if(14)
			// Everyone is blinded or gains night vision
			for(var/mob/living/carbon/T in (targets + user))
				if(prob(50))
					T.blind_eyes(4)
					T.visible_message(span_danger("[T]'s eyes cloud over!"))
				else
					ADD_TRAIT(T, TRAIT_NIGHT_VISION, user)
					T.visible_message(span_notice("[T]'s eyes glow with night vision!"))
					addtimer(CALLBACK(T, TYPE_PROC_REF(/mob/living/carbon/human, remove_night_vision), T, user), user)
			user.visible_message(span_notice("Wild magic twists everyone's sight!"))
		if(15)
			// Everyone is healed, but silenced for 20 seconds
			for(var/mob/living/carbon/T in (targets + user))
				T.adjustBruteLoss(-20)
				T.adjustFireLoss(-20)
				T.adjustToxLoss(-20)
				T.adjustOxyLoss(-20)
				T.adjust_silence(20 SECONDS)
			user.visible_message(span_notice("Healing light, but no words, for all!"))
		if(16)
			// All are compelled to dance uncontrollably
			for(var/mob/living/carbon/T in (targets + user))
				T.emote("dance")
			user.visible_message(span_warning("Wild magic compels everyone to dance!"))
		if(17)
			// All blink a short distance in a random direction
			for(var/mob/living/carbon/T in (targets + user))
				step(T, pick(GLOB.cardinals))
				T.visible_message(span_notice("[T] suddenly blinks a short distance!"))
			user.visible_message(span_notice("Everyone blinks unpredictably!"))
		if(18)
			// All are briefly confused
			for(var/mob/living/carbon/T in (targets + user))
				T.confused += 10
			user.visible_message(span_notice("A wave of fey confusion muddles everyone's senses!"))
		if(19)
			// All are blessed with a random beneficial status effect
			var/list/buffs = list(/datum/status_effect/buff/bladeward, /datum/status_effect/buff/haste, /datum/status_effect/buff/fortitude)
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(pick(buffs), 20 SECONDS)
			user.visible_message(span_notice("Wild magic blesses everyone with fey power!"))
		if(20)
			// Flowers or vines sprout from everyone for 15 seconds
			for(var/mob/living/carbon/T in (targets + user))
				T.overlays += image('icons/effects/illusions.dmi', "flowers")
				T.visible_message(span_notice("Flowers and vines sprout from [T]'s body!"))
				addtimer(CALLBACK(T, TYPE_PROC_REF(/mob/living/carbon, remove_flower_overlay)), 15 SECONDS)
			user.visible_message(span_notice("Fey magic causes everyone to bloom!"))
		if(21)
			// All are compelled to speak only the truth (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/debuff/truthcurse, 30 SECONDS)
			user.visible_message(span_notice("A fey curse compels honesty from all!"))
		if(22)
			// All are surrounded by a gentle rain of petals
			for(var/mob/living/carbon/T in (targets + user))
				for(var/i = 1, i <= 8, i++)
					new /obj/effect/illusion/petal(T.loc)
			user.visible_message(span_notice("Petals rain gently from the air!"))
		if(23)
			// All are affected by a random color change (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				var/color = pick("blue", "green", "pink", "gold", "silver", "violet")
				T.visible_message(span_notice("[T]'s skin briefly shimmers [color]!"))
			user.visible_message(span_notice("Fey magic paints everyone in new hues!"))
		if(24)
			// All are surrounded by a faint, musical chime
			for(var/mob/living/carbon/T in (targets + user))
				//We don't have a chime sound I don't think.
			user.visible_message(span_notice("A musical chime echoes through the air!"))
		if(25)
			// All are briefly weightless (float for a few seconds)
			for(var/mob/living/carbon/T in (targets + user))
				T.float(on = TRUE)
				addtimer(CALLBACK(T, TYPE_PROC_REF(/mob/living/carbon, float), FALSE), 5 SECONDS)
			user.visible_message(span_notice("Everyone floats a few inches above the ground!"))
		if(26)
			// All are surrounded by a swirl of autumn leaves
			for(var/mob/living/carbon/T in (targets + user))
				for(var/i = 1, i <= 8, i++)
					new /obj/effect/illusion/leaf(T.loc)
			user.visible_message(span_notice("Autumn leaves swirl around everyone!"))
		if(27)
			// All are struck by a sudden, harmless gust of wind
			for(var/mob/living/carbon/T in (targets + user))
				step_away(T, user, 2)
			user.visible_message(span_notice("A playful wind tugs at everyone!"))
		if(28)
			// All are briefly silenced, but gain haste
		 for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/silenced, 10 SECONDS)
				T.apply_status_effect(/datum/status_effect/buff/haste, 10 SECONDS)
			user.visible_message(span_notice("Speedy silence falls upon all!"))
		if(29)
			// All are surrounded by a faint, glowing aura
			for(var/mob/living/carbon/T in (targets + user))
				T.visible_message(span_notice("[T] is surrounded by a faint, glowing aura!"))
			user.visible_message(span_notice("Fey magic makes everyone glow!"))
		if(30)
			// All are randomly swapped with a nearby animal (if any)
			for(var/mob/living/carbon/T in (targets + user))
				var/list/animals = list()
				for(var/mob/living/simple_animal/A in range(3, T))
					animals += A
				if(animals.len)
					var/mob/living/simple_animal/A = pick(animals)
					var/turf/Tloc = T.loc
					var/turf/Aloc = A.loc
					A.forceMove(Tloc)
					T.forceMove(Aloc)
					T.visible_message(span_notice("[T] swaps places with a startled animal!"))
			user.visible_message(span_notice("Wild magic swaps places with the local fauna!"))
		if(31)
			// All are briefly chilled, then warmed
		 for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/debuff/chilled, 5 SECONDS)
				sleep(5 SECONDS)
				T.apply_status_effect(/datum/status_effect/buff/fortitude, 5 SECONDS)
			user.visible_message(span_notice("A chill, then a warm breeze, passes over everyone!"))
		if(32)
			// All are surrounded by a faint, sweet scent
			for(var/mob/living/carbon/T in (targets + user))
				T.visible_message(span_notice("[T] is surrounded by the scent of honey and wildflowers!"))
			user.visible_message(span_notice("The air is thick with fey scents!"))
		if(33)
			// All are compelled to sing (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/debuff/singcurse, 20 SECONDS)
			user.visible_message(span_notice("A fey curse compels everyone to sing!"))
		if(34)
			// All are briefly slowed, then sped up using movement modifiers
			for(var/mob/living/carbon/T in (targets + user))
				// Apply a strong slow
				T.add_movespeed_modifier("wildmagic_slow", TRUE, 100, override=TRUE, multiplicative_slowdown=3)
			user.visible_message(span_notice("Time seems to slow for everyone!"))
			sleep(5 SECONDS)
			for(var/mob/living/carbon/T in (targets + user))
				// Remove slow, apply haste (faster than normal)
				T.remove_movespeed_modifier("wildmagic_slow")
				T.add_movespeed_modifier("wildmagic_haste", TRUE, 100, override=TRUE, multiplicative_slowdown=0.5)
			user.visible_message(span_notice("Time suddenly speeds up for everyone!"))
			sleep(5 SECONDS)
			for(var/mob/living/carbon/T in (targets + user))
				T.remove_movespeed_modifier("wildmagic_haste")
		if(35)
			// All are surrounded by a faint, sparkling mist
			for(var/mob/living/carbon/T in (targets + user))
				T.visible_message(span_notice("[T] is surrounded by sparkling fey mist!"))
			user.visible_message(span_notice("A sparkling mist fills the air!"))
		if(36)
			// All are compelled to compliment the next person they see (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/debuff/complimentcurse, 30 SECONDS)
			user.visible_message(span_notice("A fey compulsion to compliment others fills everyone!"))
		if(37)
			// All are briefly immune to damage (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.status_flags |= GODMODE
				T.visible_message(span_notice("[T] is surrounded by a protective aura!"))
			spawn(5 SECONDS)
				for(var/mob/living/carbon/T in (targets + user))
					T.status_flags &= ~GODMODE
					T.visible_message(span_notice("[T]'s protective aura fades away!"))	
			user.visible_message(span_notice("For a moment, nothing can harm anyone!"))
		if(38)
			// All are compelled to hop on one foot (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.emote("jump")
			user.visible_message(span_notice("A fey curse compels everyone to hop on one foot!"))
		if(39)
			// All are surrounded by a faint, silvery light
			for(var/mob/living/carbon/T in (targets + user))
				T.visible_message(span_notice("[T] is bathed in silvery moonlight!"))
			user.visible_message(span_notice("Moonlight bathes everyone in silver!"))
		if(40)
			// All are compelled to tell a secret (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/debuff/secretcurse, 30 SECONDS)
			user.visible_message(span_notice("A fey compulsion to reveal secrets fills everyone!"))
		if(41)
			// All are surrounded by a faint, buzzing sound (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.visible_message(span_notice("[T] hears a faint, buzzing sound!"))
			user.visible_message(span_notice("The air is filled with the sound of fey wings!"))
		if(42)
			// All are compelled to mimic the last person who spoke (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/debuff/mimiccurse, 20 SECONDS)
			user.visible_message(span_notice("A fey curse compels everyone to mimic others!"))
		if(43)
			// All are briefly immune to magic (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/antimagic, 5 SECONDS)
			user.visible_message(span_notice("For a moment, magic cannot touch anyone!"))
		if(44)
			// All are compelled to dance with the next person they see (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.emote("dance")
			user.visible_message(span_notice("A fey compulsion to dance with others fills everyone!"))
		if(45)
			// All are surrounded by a faint, golden glow
			for(var/mob/living/carbon/T in (targets + user))
				T.visible_message(span_notice("[T] is surrounded by a golden glow!"))
			user.visible_message(span_notice("A golden glow fills the air!"))
		if(46)
			// All are compelled to speak only in questions (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/debuff/questioncurse, 30 SECONDS)
			user.visible_message(span_notice("A fey curse compels everyone to speak only in questions!"))
		if(47)
			// All are surrounded by a faint, icy breeze
			for(var/mob/living/carbon/T in (targets + user))
				T.visible_message(span_notice("[T] shivers as an icy breeze passes by!"))
			user.visible_message(span_notice("An icy breeze chills the air!"))
		if(48)
			// All are compelled to compliment themselves (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/debuff/selfcomplimentcurse, 20 SECONDS)
			user.visible_message(span_notice("A fey curse compels everyone to compliment themselves!"))
		if(49)
			// All are surrounded by a faint, rainbow shimmer
			for(var/mob/living/carbon/T in (targets + user))
				T.visible_message(span_notice("[T] is surrounded by a rainbow shimmer!"))
			user.visible_message(span_notice("A rainbow shimmer fills the air!"))
		if(50)
			// All are compelled to giggle uncontrollably (RP effect)
			for(var/mob/living/carbon/T in (targets + user))
				T.apply_status_effect(/datum/status_effect/debuff/gigglecurse, 15 SECONDS)
			user.visible_message(span_notice("A fey curse compels everyone to giggle!"))
			
/obj/effect/illusion
	name = "Illusion"
	desc = "An illusionary effect that can be used to deceive or distract."
	icon = 'icons/effects/illusions.dmi'
	icon_state = ""
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = FALSE
	opacity = TRUE
	var/duration = 10 SECONDS // Default duration for the illusion effect

/obj/effect/illusion/Initialize()
	. = ..()
	spawn(duration)
		if (QDELETED(src))
			return
		qdel(src)

/obj/effect/illusion/mote
	name = "Mote of Light"
	desc = "A small, glowing mote of light."
	icon_state = "mote"
	light_outer_range = 1
	light_color = LIGHT_COLOR_WHITE
	icon_state = "mote"

/obj/effect/illusion/butterfly
	name = "Butterflies"
	desc = "A swarm of illusionary butterflies."
	icon_state = "butterflies"

/obj/effect/illusion/leaf
	name = "Autumn Leaves"
	desc = "A swirl of illusionary autumn leaves."
	icon_state = "leaf"

/mob/living/carbon/proc/reset_hair_color(mob/living/carbon/human/target, old_color)
    target.hair_color = old_color
    update_hair()

/mob/living/carbon/proc/reset_eye_color(mob/living/carbon/human/target, old_color)
	var/obj/item/organ/eyes/eyes = target.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(src)
		eyes.eye_color = old_color
		eyes.Insert(target, TRUE, FALSE)
	update_body_parts()

/mob/living/carbon/proc/remove_sparkle_overlay()
    overlays -= image('icons/effects/illusions.dmi', "sparkle")

/mob/living/carbon/proc/remove_antlers_illusion(antlers)
    var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
    if(head && antlers)
        head.remove_bodypart_feature(antlers)
    update_body_parts()

/datum/status_effect/debuff/rhymecurse
	id = "rhymecurse"
	alert_type = /atom/movable/screen/alert/status_effect/rhymecurse
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/rhymecurse
	name = "Rhyming Curse"
	desc = "You are compelled to speak in rhymes! (No effect on gameplay, just for fun.)"

/datum/status_effect/debuff/rooted
	id = "rooted"
	alert_type = /atom/movable/screen/alert/status_effect/rooted
	duration = 5 SECONDS

/atom/movable/screen/alert/status_effect/rooted
	name = "Rooted"
	desc = "You are rooted in place by magical vines! You cannot move until the effect wears off."

/datum/status_effect/debuff/rooted/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(prevent_movement))

/datum/status_effect/debuff/rooted/proc/prevent_movement(mob/living/source, direction)
	SIGNAL_HANDLER
	if(source == owner)
		return TRUE

/datum/status_effect/debuff/rooted/on_remove()
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED) // Stop preventing movement when removed

/datum/status_effect/debuff/laughter
	id = "laughter"
	alert_type = /atom/movable/screen/alert/status_effect/laughter
	duration = 6 SECONDS

/atom/movable/screen/alert/status_effect/laughter
	name = "Laughter"
	desc = "You can't stop laughing! (No effect on gameplay, just for fun.)"

/datum/status_effect/debuff/singcurse
	id = "singingcurse"
	alert_type = /atom/movable/screen/alert/status_effect/singcurse
	duration = 20 SECONDS

/atom/movable/screen/alert/status_effect/singcurse
	name = "Singing Curse"
	desc = "You are compelled to sing everything you say! (No effect on gameplay, just for fun.)"

/datum/status_effect/buff/shield
	id = "shield"
	alert_type = /atom/movable/screen/alert/status_effect/shield
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/shield
	name = "Shield"
	desc = "You are surrounded by a magical shield that will absorb one attack!"

/datum/status_effect/buff/shield/on_apply()
    . = ..()
    RegisterSignal(owner, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attacked))
    RegisterSignal(owner, COMSIG_ATOM_ATTACK_PAW, PROC_REF(on_attacked))
    RegisterSignal(owner, COMSIG_ATOM_ATTACK_ANIMAL, PROC_REF(on_attacked))
    RegisterSignal(owner, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_attacked))

/datum/status_effect/buff/shield/on_remove()
	UnregisterSignal(owner, COMSIG_ATOM_ATTACK_HAND)
	UnregisterSignal(owner, COMSIG_ATOM_ATTACK_PAW)
	UnregisterSignal(owner, COMSIG_ATOM_ATTACK_ANIMAL)
	UnregisterSignal(owner, COMSIG_ATOM_BULLET_ACT)
	
/datum/status_effect/buff/shield/proc/on_attacked(mob/living/source, damage, damage_type, attack_flags)
    SIGNAL_HANDLER
    if(source == owner)
        return // Ignore self-attacks
    if(damage > 0)
        owner.visible_message(span_notice("[owner] is protected by a magical shield!"), span_notice("You feel a magical shield absorb the attack!"))
        owner.remove_status_effect(src) // Remove the shield after absorbing one attack
        return TRUE // Prevent further damage from this attack
    return FALSE // Allow other effects to process normally

/mob/living/carbon/proc/remove_night_vision(mob/living/target, mob/living/user)
	target.visible_message(span_notice("[target]'s eyes lose their night vision glow."))
	REMOVE_TRAIT(target, TRAIT_NIGHT_VISION, user)

/datum/status_effect/debuff/complimentcurse
	id = "complimentcurse"
	alert_type = /atom/movable/screen/alert/status_effect/complimentcurse
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/complimentcurse
	name = "Compliment Curse"
	desc = "You are compelled to compliment the next person you see! (No effect on gameplay, just for fun.)"

/mob/living/carbon/proc/remove_flower_overlay()
    overlays -= image('icons/effects/illusions.dmi', "flowers")

/obj/effect/illusion/petal
	name = "Petal"
	desc = "A delicate petal that falls gently to the ground."
	icon_state = "petal"
	light_outer_range = 0.5
	light_color = LIGHT_COLOR_PINK
	icon_state = "petal"

/datum/status_effect/debuff/truthcurse
	id = "truthcurse"
	alert_type = /atom/movable/screen/alert/status_effect/truthcurse
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/truthcurse
	name = "Truth Curse"
	desc = "You are compelled to speak only the truth! (No effect on gameplay, just for fun.)"

/datum/status_effect/debuff/questioncurse
	id = "questioncurse"
	alert_type = /atom/movable/screen/alert/status_effect/questioncurse
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/questioncurse
	name = "Question Curse"
	desc = "You are compelled to speak only in questions! (No effect on gameplay, just for fun.)"

/datum/status_effect/debuff/selfcomplimentcurse
	id = "selfcomplimentcurse"
	alert_type = /atom/movable/screen/alert/status_effect/selfcomplimentcurse
	duration = 20 SECONDS

/atom/movable/screen/alert/status_effect/selfcomplimentcurse
	name = "Self-Compliment Curse"
	desc = "You are compelled to compliment yourself! (No effect on gameplay, just for fun.)"

/datum/status_effect/debuff/gigglecurse
	id = "gigglecurse"
	alert_type = /atom/movable/screen/alert/status_effect/gigglecurse
	duration = 15 SECONDS

/atom/movable/screen/alert/status_effect/gigglecurse
	name = "Giggle Curse"
	desc = "You can't stop giggling! (No effect on gameplay, just for fun.)"

/datum/status_effect/debuff/mimiccurse
	id = "mimiccurse"
	alert_type = /atom/movable/screen/alert/status_effect/mimiccurse
	duration = 20 SECONDS

/atom/movable/screen/alert/status_effect/mimiccurse
	name = "Mimic Curse"
	desc = "You are compelled to mimic the last person who spoke! (No effect on gameplay, just for fun.)"

/datum/status_effect/debuff/secretcurse
	id = "Secret Curse"
	alert_type = /atom/movable/screen/alert/status_effect/secret
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/secret
	name = "Secret Curse"
	desc = "You are compelled to tell a secret! (No effect on gameplay, just for fun.)"
