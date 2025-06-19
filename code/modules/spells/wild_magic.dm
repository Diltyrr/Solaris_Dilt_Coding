/proc/trigger_wild_magic(list/targets, mob/living/carbon/user, spell, effect_override = null)
    var/effect = effect_override ? effect_override : rand(1, 50)
    //we grab people close to the targets, more chaotic that way.
    for(var/target in targets)
        for(var/mob/living/close_mob in range(3, target))
            target |= close_mob
    switch(effect)
        if(1)
            // Spell fires normally but the target is the user
            if(spell)
                var/obj/effect/proc_holder/spell/spell_instance = new spell
                spell_instance.perform(list(user), FALSE, user)
                user.visible_message(span_notice("Wild magic causes the spell to fire at [user]!"))
        if(2)
            // Everyone is briefly invisible (faerie glamour)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                if(affected_mob.anti_magic_check(TRUE, TRUE))
                    continue
                affected_mob.visible_message(span_warning("[affected_mob] starts to fade into thin air!"), span_notice("You start to become invisible!"))
                animate(affected_mob, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
                affected_mob.mob_timers[MT_INVISIBILITY] = world.time + 10 SECONDS
                addtimer(CALLBACK(affected_mob, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 10 SECONDS)
                addtimer(CALLBACK(affected_mob, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[affected_mob] fades back into view."), span_notice("You become visible again.")), 10 SECONDS)
            user.visible_message(span_notice("A shimmering glamour makes everyone vanish for a moment!"))
        if(3)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                for(var/mote_index = 1, mote_index <= 10, mote_index++)
                    new /obj/effect/illusion/mote(affected_mob.loc)
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by swirling motes of magical light!"))
            user.visible_message(span_notice("Wild magic surrounds everyone with swirling motes of light!"))
        if(4)
            // Butterflies swirl around everyone
            for(var/mob/living/carbon/affected_mob in (targets + user))
                for(var/butterfly_index = 1, butterfly_index <= 6, butterfly_index++)
                    new /obj/effect/illusion/butterfly(affected_mob.loc)
            user.visible_message(span_notice("A cloud of colorful butterflies swirls around everyone!"))
        if(5)
            // Everyone is compelled to speak in rhyme (RP effect)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/rhymecurse)
            user.visible_message(span_notice("A mischievous fey curse compels everyone to speak in rhyme!"))
        if(6)
            // Harmless illusions: hair color, glowing eyes, skin sparkles, antlers, all revert after 15 seconds
            for(var/mob/living/carbon/human/affected_human in (targets + user))
                var/illusion_type = pick("hair", "eyes", "skin", "antlers")
                switch(illusion_type)
                    if("hair")
                        var/old_hair_color = affected_human.hair_color
                        affected_human.hair_color = "#00FF00" // bright green
                        affected_human.update_hair()
                        affected_human.visible_message(span_notice("[affected_human]'s hair turns bright green!"))
                        addtimer(CALLBACK(affected_human, TYPE_PROC_REF(/mob/living/carbon/human, reset_hair_color), affected_human, old_hair_color), 15 SECONDS)
                    if("eyes")
                        var/old_eye_color = affected_human.eye_color
                        affected_human.eye_color = "#00FFCC" // faerie blue
                        var/obj/item/organ/eyes/eyes_organ = affected_human.getorganslot(ORGAN_SLOT_EYES)
                        if(eyes_organ)
                            eyes_organ.Remove(affected_human)
                            eyes_organ.eye_color = affected_human.eye_color
                            eyes_organ.Insert(affected_human, TRUE, FALSE)
                        affected_human.update_body_parts()
                        affected_human.visible_message(span_notice("[affected_human]'s eyes glow with faerie light!"))
                        addtimer(CALLBACK(affected_human, TYPE_PROC_REF(/mob/living/carbon/human, reset_eye_color), affected_human, old_eye_color), 15 SECONDS)
                    if("skin")
                        affected_human.overlays += image('icons/effects/effects.dmi', "shieldsparkles")
                        affected_human.visible_message(span_notice("[affected_human]'s skin sparkles with motes of magic!"))
                        addtimer(CALLBACK(affected_human, TYPE_PROC_REF(/mob/living/carbon/human, remove_sparkle_overlay)), 15 SECONDS)
                    if("antlers")
                        var/obj/item/bodypart/head/head_part = affected_human.get_bodypart(BODY_ZONE_HEAD)
                        var/datum/sprite_accessory/horns/old_horns = null
                        if(head_part && islist(head_part.bodypart_features))
                            for(var/datum/sprite_accessory/horns/horns_feature in head_part.bodypart_features)
                                if(istype(horns_feature, /datum/sprite_accessory/horns))
                                    old_horns = horns_feature
                                    break
                            // Remove any existing antlers
                            for(var/datum/sprite_accessory/horns/antlers/antler_feature in head_part.bodypart_features)
                                if(istype(antler_feature, /datum/sprite_accessory/horns/antlers))
                                    head_part.remove_bodypart_feature(antler_feature)
                        if(head_part)
                            var/datum/sprite_accessory/horns/antlers/new_antlers = new /datum/sprite_accessory/horns/antlers()
                            head_part.add_bodypart_feature(new_antlers)
                            affected_human.update_body_parts()
                            affected_human.visible_message(span_notice("[affected_human] sprouts illusory antlers!"))
                            addtimer(CALLBACK(affected_human, TYPE_PROC_REF(/mob/living/carbon/human, remove_antlers_illusion), affected_human, old_horns), 15 SECONDS)
            user.visible_message(span_notice("Fey magic weaves harmless illusions over everyone!"))
        if(7)
            // Everyone is rooted in place by magical vines
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/rooted)
            user.visible_message(span_warning("Vines erupt from the ground, rooting everyone in place!"))
        if(8)
            // Faerie dust heals everyone a small amount
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.adjustBruteLoss(-5)
                affected_mob.adjustFireLoss(-5)
                affected_mob.adjustToxLoss(-5)
                affected_mob.adjustOxyLoss(-5)
                affected_mob.visible_message(span_notice("Sparkling faerie dust heals [affected_mob] slightly!"))
            user.visible_message(span_notice("Faerie dust rains from above, mending minor wounds!"))
        if(9)
            // Everyone laughs uncontrollably (stun or emote effect)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.emote("laugh")
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
            for(var/mob/living/carbon/affected_mob in (targets + user))
                var/mob/living/simple_animal/animal_type = pick(animal_types)
                var/mob/living/simple_animal/spawned_animal = new animal_type(affected_mob.loc)
                spawned_animal.name = "Wild [animal_type.name]"
            user.visible_message(span_notice("Tiny woodland creatures scamper out of nowhere!"))
        if(11)
            // User and targets swap places randomly
            var/list/all_mobs = (targets + user)
            all_mobs = shuffle(all_mobs)
            var/list/original_locations = list()
            for(var/location_index = 1, location_index <= all_mobs.len, location_index++)
                var/atom/movable/current_mob = all_mobs[location_index]
                original_locations += current_mob.loc
            for(var/swap_index = 1, swap_index <= all_mobs.len, swap_index++)
                var/next_index = (swap_index % all_mobs.len) + 1
                var/destination = original_locations[next_index]
                if(istype(destination, /turf) && istype(all_mobs[swap_index], /atom/movable))
                    var/atom/movable/movable_mob = all_mobs[swap_index]
                    movable_mob.forceMove(destination)
            user.visible_message(span_warning("Reality twists!"))
        if(12)
            // Everyone is surrounded by a shield that absorbs one attack
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/buff/shield, 30 SECONDS)
            user.visible_message(span_notice("A shimmering shield surrounds everyone!"))
        if(13)
            // Everyone is randomly teleported a short distance
            for(var/mob/living/carbon/affected_mob in (targets + user))
                step(affected_mob, pick(GLOB.cardinals))
            user.visible_message(span_notice("Wild magic scatters everyone unpredictably!"))
        if(14)
            // Everyone is blinded or gains night vision
            for(var/mob/living/carbon/affected_mob in (targets + user))
                if(prob(50))
                    affected_mob.blind_eyes(4)
                    affected_mob.visible_message(span_danger("[affected_mob]'s eyes cloud over!"))
                else
                    ADD_TRAIT(affected_mob, TRAIT_NIGHT_VISION, user)
                    affected_mob.visible_message(span_notice("[affected_mob]'s eyes glow with night vision!"))
                    addtimer(CALLBACK(affected_mob, TYPE_PROC_REF(/mob/living/carbon/human, remove_night_vision), affected_mob, user), user)
            user.visible_message(span_notice("Wild magic twists everyone's sight!"))
        if(15)
            // Everyone is healed, but silenced for 20 seconds
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.adjustBruteLoss(-20)
                affected_mob.adjustFireLoss(-20)
                affected_mob.adjustToxLoss(-20)
                affected_mob.adjustOxyLoss(-20)
                affected_mob.adjust_silence(20 SECONDS)
                affected_mob.emote("dance")
            user.visible_message(span_notice("A healing light washes over everyone, but no words can be spoken!"))
            user.visible_message(span_warning("Wild magic compels everyone to dance!"))
        if(17)
            // All blink a short distance in a random direction
            for(var/mob/living/carbon/affected_mob in (targets + user))
                step(affected_mob, pick(GLOB.cardinals))
                affected_mob.visible_message(span_notice("[affected_mob] suddenly blinks a short distance!"))
            user.visible_message(span_notice("Everyone blinks unpredictably!"))
        if(18)
            // All are briefly confused
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.confused += 10
            user.visible_message(span_notice("A wave of fey confusion muddles everyone's senses!"))
        if(19)
            // All are blessed with a random beneficial status effect
            var/list/buff_types = list(/datum/status_effect/buff/bladeward, /datum/status_effect/buff/haste, /datum/status_effect/buff/fortitude)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(pick(buff_types), 20 SECONDS)
            user.visible_message(span_notice("Wild magic blesses everyone with fey power!"))
        if(20)
            // Flowers or vines sprout from everyone for 15 seconds
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.overlays += image('icons/effects/illusions.dmi', "flowers")
                affected_mob.visible_message(span_notice("Flowers and vines sprout from [affected_mob]'s body!"))
                addtimer(CALLBACK(affected_mob, TYPE_PROC_REF(/mob/living/carbon, remove_flower_overlay)), 15 SECONDS)
            user.visible_message(span_notice("Fey magic causes everyone to bloom!"))
        if(21)
            // All are compelled to speak only the truth (RP effect)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/truthcurse, 30 SECONDS)
            user.visible_message(span_notice("A fey curse compels honesty from all!"))
        if(22)
            // All are surrounded by a gentle rain of petals
            for(var/mob/living/carbon/affected_mob in (targets + user))
                for(var/petal_index = 1, petal_index <= 8, petal_index++)
                    new /obj/effect/illusion/petal(affected_mob.loc)
            user.visible_message(span_notice("Petals rain gently from the air!"))
        if(23)
            // All are affected by a random color change (RP effect)
            for(var/mob/living/carbon/human/affected_human in (targets + user))
                var/list/color_choices = list(
                    "#3b6ee3", // blue
                    "#3be36e", // green
                    "#e33bbd", // pink
                    "#e3c53b", // gold
                    "#c0c0c0", // silver
                    "#a03be3"  // violet
                )
                var/random_color = pick(color_choices)
                var/old_skin_color = affected_human.skin_tone
                affected_human.skin_tone = random_color
                affected_human.update_body()
                affected_human.visible_message(span_notice("[affected_human]'s skin briefly shimmers with a new hue!"))
                addtimer(CALLBACK(affected_human, TYPE_PROC_REF(/mob/living/carbon/human, reset_skin_color), affected_human, old_skin_color), 15 SECONDS)
            user.visible_message(span_notice("Fey magic paints everyone in new hues!"))
        if(24)
            // All are surrounded by a faint, musical chime
            for(var/mob/living/carbon/affected_mob in (targets + user))
                //We don't have a chime sound I don't think.
            user.visible_message(span_notice("A musical chime echoes through the air!"))
        if(25)
            // All are briefly weightless (float for a few seconds)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.float(on = TRUE)
                addtimer(CALLBACK(affected_mob, "float", FALSE), 5 SECONDS)
            user.visible_message(span_notice("Everyone floats a few inches above the ground!"))
        if(26)
            // All are surrounded by a swirl of autumn leaves
            for(var/mob/living/carbon/affected_mob in (targets + user))
                for(var/leaf_index = 1, leaf_index <= 8, leaf_index++)
                    new /obj/effect/illusion/leaf(affected_mob.loc)
            user.visible_message(span_notice("Autumn leaves swirl around everyone!"))
        if(27)
            // All are struck by a sudden, harmless gust of wind
            for(var/mob/living/carbon/affected_mob in (targets + user))
                step_away(affected_mob, user, 2)
            user.visible_message(span_notice("A playful wind tugs at everyone!"))
        if(28)
            // All are briefly silenced, but gain haste
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/silenced, 10 SECONDS)
                affected_mob.apply_status_effect(/datum/status_effect/buff/haste, 10 SECONDS)
            user.visible_message(span_notice("Speedy silence falls upon all!"))
        if(29)
            // All are surrounded by a faint, glowing aura
            for(var/mob/living/carbon/affected_mob in (targets + user))
                var/glow_color = "#F0E68C"
                var/filter_id = "wildmagic_glow"
                if (!affected_mob.get_filter(filter_id))
                    affected_mob.add_filter(filter_id, 2, list("type" = "outline", "color" = glow_color, "alpha" = 120, "size" = 2))
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by a faint, glowing aura!"))
                addtimer(CALLBACK(affected_mob, "remove_filter", filter_id), 15 SECONDS)
            user.visible_message(span_notice("Fey magic makes everyone glow!"))
        if(30)
            // All are randomly swapped with a nearby animal (if any)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                var/list/nearby_animals = list()
                for(var/mob/living/simple_animal/nearby_animal in range(3, affected_mob))
                    nearby_animals += nearby_animal
                if(nearby_animals.len)
                    var/mob/living/simple_animal/animal_to_swap = pick(nearby_animals)
                    var/turf/affected_mob_loc = affected_mob.loc
                    var/turf/animal_loc = animal_to_swap.loc
                    animal_to_swap.forceMove(affected_mob_loc)
                    affected_mob.forceMove(animal_loc)
                    affected_mob.visible_message(span_notice("[affected_mob] swaps places with a startled animal!"))
            user.visible_message(span_notice("Wild magic swaps places with the local fauna!"))
        if(31)
            // All are briefly chilled, then warmed
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/chilled, 5 SECONDS)
                sleep(5 SECONDS)
                affected_mob.apply_status_effect(/datum/status_effect/buff/fortitude, 5 SECONDS)
            user.visible_message(span_notice("A chill, then a warm breeze, passes over everyone!"))
        if(32)
            // All are surrounded by a faint, sweet scent
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by the scent of honey and wildflowers!"))
            user.visible_message(span_notice("The air is thick with fey scents!"))
        if(33)
            // All are compelled to sing (RP effect)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/singcurse, 20 SECONDS)
            user.visible_message(span_notice("A fey curse compels everyone to sing!"))
        if(34)
            // All are briefly slowed, then sped.
            for(var/mob/living/carbon/affected_mob in (targets + user))
                // Apply a strong slow
                affected_mob.add_movespeed_modifier("wildmagic_slow", TRUE, 100, override=TRUE, multiplicative_slowdown=3)
            user.visible_message(span_notice("Time seems to slow for everyone!"))
            sleep(5 SECONDS)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                // Remove slow, apply haste (faster than normal)
                affected_mob.remove_movespeed_modifier("wildmagic_slow")
                affected_mob.add_movespeed_modifier("wildmagic_haste", TRUE, 100, override=TRUE, multiplicative_slowdown=0.5)
            user.visible_message(span_notice("Time suddenly speeds up for everyone!"))
            sleep(5 SECONDS)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.remove_movespeed_modifier("wildmagic_haste")
        if(35)
            // All are surrounded by a faint, sparkling mist
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by sparkling fey mist!"))
            user.visible_message(span_notice("A sparkling mist fills the air!"))
        if(36)
            // All are compelled to compliment the next person they see (RP effect)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/complimentcurse, 30 SECONDS)
            user.visible_message(span_notice("A fey compulsion to compliment others fills everyone!"))
        if(37)
            // All are briefly immune to damage
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.status_flags |= GODMODE
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by a protective aura!"))
            spawn(5 SECONDS)
                for(var/mob/living/carbon/affected_mob in (targets + user))
                    affected_mob.status_flags &= ~GODMODE
                    affected_mob.visible_message(span_notice("[affected_mob]'s protective aura fades away!"))	
            user.visible_message(span_notice("For a moment, nothing can harm anyone!"))
        if(38)
            // All are compelled to hop on one foot (RP effect)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.emote("jump")
            user.visible_message(span_notice("A fey curse compels everyone to hop on one foot!"))
        if(39)
            // All are surrounded by a faint, silvery light
            for(var/mob/living/carbon/affected_mob in (targets + user))
                var/glow_color = "#C0C0FF" // pale silvery-blue
                var/filter_id = "wildmagic_silverglow"
                if (!affected_mob.get_filter(filter_id))
                    affected_mob.add_filter(filter_id, 2, list("type" = "outline", "color" = glow_color, "alpha" = 120, "size" = 2))
                affected_mob.visible_message(span_notice("[affected_mob] is bathed in silvery moonlight!"))
                addtimer(CALLBACK(affected_mob, "remove_filter", filter_id), 15 SECONDS)
            user.visible_message(span_notice("Moonlight bathes everyone in silver!"))
        if(40)
            // All are compelled to tell a secret (RP effect)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/secretcurse, 30 SECONDS)
            user.visible_message(span_notice("A fey compulsion to reveal secrets fills everyone!"))
        if(41)
            // All are surrounded by a faint, buzzing sound (RP effect)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.visible_message(span_notice("[affected_mob] hears a faint, buzzing sound!"))
            user.visible_message(span_notice("The air is filled with the sound of fey wings!"))
        if(42)
            // All are compelled to mimic the last person who spoke (RP effect)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/mimiccurse, 20 SECONDS)
            user.visible_message(span_notice("A fey curse compels everyone to mimic others!"))
        if(43)
            // All are briefly immune to magic (RP effect)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/antimagic, 5 SECONDS)
            user.visible_message(span_notice("For a moment, magic cannot touch anyone!"))
        if(44)
            // All are compelled to move in random directions for a short time (chaos dance)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                spawn(0)
                    for(var/i = 1, i <= 5, i++)
                        step(affected_mob, pick(GLOB.cardinals))
                        sleep(1)
            user.visible_message(span_notice("Wild magic causes everyone to stagger about unpredictably!"))
        if(45)
            // All are surrounded by a faint, golden glow (using outline filter)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                var/glow_color = "#FFD700" // gold
                var/filter_id = "wildmagic_goldglow"
                if (!affected_mob.get_filter(filter_id))
                    affected_mob.add_filter(filter_id, 2, list("type" = "outline", "color" = glow_color, "alpha" = 120, "size" = 2))
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by a golden glow!"))
                addtimer(CALLBACK(affected_mob, "remove_filter", filter_id), 15 SECONDS)
            user.visible_message(span_notice("A golden glow fills the air!"))
        if(46)
            // All are compelled to speak only in questions (RP effect)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/questioncurse, 30 SECONDS)
            user.visible_message(span_notice("A fey curse compels everyone to speak only in questions!"))
        if(47)
            // All are surrounded by a faint, icy breeze
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.visible_message(span_notice("[affected_mob] shivers as an icy breeze passes by!"))
            user.visible_message(span_notice("An icy breeze chills the air!"))
        if(48)
            // All are compelled to compliment themselves (RP effect)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/selfcomplimentcurse, 20 SECONDS)
            user.visible_message(span_notice("A fey curse compels everyone to compliment themselves!"))
        if(49)
            // All are surrounded by a faint, rainbow shimmer (I'm giving it a purple glow, no idea how to animate it)
            for(var/mob/living/carbon/affected_mob in (targets + user))
                var/glow_color = "#B06FFC"
                var/filter_id = "wildmagic_rainbowglow"
                if (!affected_mob.get_filter(filter_id))
                    affected_mob.add_filter(filter_id, 2, list("type" = "outline", "color" = glow_color, "alpha" = 120, "size" = 2))
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by a rainbow shimmer!"))
                addtimer(CALLBACK(affected_mob, "remove_filter", filter_id), 15 SECONDS)
            user.visible_message(span_notice("A rainbow shimmer fills the air!"))
        if(50)
            sleep(0.5 SECONDS)
            var/obj/effect/proc_holder/spell/doubled = new spell
            doubled.perform(targets, FALSE, user)
            user.visible_message(span_notice("Wild magic causes the spell to fire twice!"))
		
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
    layer = ABOVE_MOB_LAYER
    plane = PLANE_EMISSIVE // This makes it render as emissive/glowing

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
    target.update_hair()

/mob/living/carbon/human/proc/reset_eye_color(mob/living/carbon/human/target, old_color)
    var/obj/item/organ/eyes/eyes = target.getorganslot(ORGAN_SLOT_EYES)
    if(eyes)
        eyes.Remove(src)
        eyes.eye_color = old_color
        eyes.Insert(target, TRUE, FALSE)
    target.update_body_parts()

/mob/living/carbon/proc/remove_sparkle_overlay()
    overlays -= image('icons/effects/effects.dmi', "shieldsparkles")

/mob/living/carbon/proc/remove_antlers_illusion(mob/living/carbon/human/target, old_horns)
    var/obj/item/bodypart/head/head = target.get_bodypart(BODY_ZONE_HEAD)
    if(head && islist(head.bodypart_features))
        // Remove any antlers present
        for(var/datum/sprite_accessory/horns/antlers/antler_feature in head.bodypart_features)
            if(istype(antler_feature, /datum/sprite_accessory/horns/antlers))
                head.remove_bodypart_feature(antler_feature)
        // Restore old horns if they existed
        if(old_horns)
            head.add_bodypart_feature(old_horns)
    target.update_body_parts()

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

/mob/living/carbon/human/proc/reset_skin_color(mob/living/carbon/human/target, old_color)
    target.skin_tone = old_color
    target.update_body()

/obj/effect/proc_holder/spell/invoked/wild_magic_testing
	name = "Wild Magic Testing"
	desc = "A spell that tests the unpredictable nature of wild magic."

/obj/effect/proc_holder/spell/invoked/wild_magic_testing/cast(target, mob/user)
	var/input = input(user, "Enter a wild magic effect number to test (1-50):", "Wild Magic Test", 1) as num
	if(isnum(input) && input >= 2 && input <= 49)
		trigger_wild_magic(list(target), user, src, input)
	if(isnum(input) && (input == 50 || input == 1))
		to_chat(user, span_notice("Can't test those with this spell, It would loop infinitely.")) //Not actually procing it or it would get stuck in a loop.
	else
		to_chat(user, span_warning("Invalid effect number. Please enter a number between 1 and 50."))
