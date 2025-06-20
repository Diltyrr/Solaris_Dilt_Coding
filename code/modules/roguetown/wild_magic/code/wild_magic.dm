//file name is voluntary, for it to be loaded before spell and still be in order in the dme.

/proc/trigger_wild_magic(list/targets, mob/living/carbon/user, spell, effect_override = null)
    var/effect = effect_override ? effect_override : rand(1, 50)
    var/list/surged_targets = list()
    for(var/target in targets)
        surged_targets |= target
        for(var/mob/living/close_mob in range(3, target))
            surged_targets |= close_mob
    for(var/mob/living/close_mob_two in range(3, user))
        surged_targets |= close_mob_two
    surged_targets |= user
    switch(effect)
        if(1)
            // Spell fires normally but the target is the user
            if(spell)
                var/obj/effect/proc_holder/spell/spell_instance = new spell
                spell_instance.perform(list(user), FALSE, user)
                user.visible_message(span_notice("Wild magic causes the spell to fire at [user]!"))
        if(2)
            // Everyone is briefly invisible (faerie glamour)
            for(var/mob/living/affected_mob in (surged_targets))
                if(affected_mob.anti_magic_check(TRUE, TRUE))
                    continue
                affected_mob.visible_message(span_warning("[affected_mob] starts to fade into thin air!"), span_notice("You start to become invisible!"))
                animate(affected_mob, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
                affected_mob.mob_timers[MT_INVISIBILITY] = world.time + 10 SECONDS
                addtimer(CALLBACK(affected_mob, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 10 SECONDS)
                addtimer(CALLBACK(affected_mob, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[affected_mob] fades back into view."), span_notice("You become visible again.")), 10 SECONDS)
            user.visible_message(span_notice("A shimmering glamour makes everyone vanish for a moment!"))
        if(3)
            for(var/mob/living/affected_mob in (surged_targets))
                apply_illusion(affected_mob.loc, /obj/effect/overlay/vis/illusion/mote)
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by swirling motes of magical light!"))
            user.visible_message(span_notice("Wild magic surrounds everyone with swirling motes of light!"))
        if(4)
            // Butterflies swirl around everyone (vis_contents overlay)
            for(var/mob/living/affected_mob in (surged_targets))
                apply_illusion(affected_mob, /obj/effect/overlay/vis/illusion/butterfly_swirl)
            user.visible_message(span_notice("A cloud of colorful butterflies swirls around everyone!"))
        if(5)
            for(var/mob/living/affected_mob in (surged_targets))
                if(affected_mob == user)
                    continue
                var/obj/projectile/magic/fetch/proj_fetch = new /obj/projectile/magic/fetch(user.loc)
                proj_fetch.firer = user
                proj_fetch.preparePixelProjectile(affected_mob, user)
                proj_fetch.fire()
            user.visible_message(span_notice("Reality shudders as wild magic tears open the air. Dragging the unlucky toward their source!"))
        if(6)
            // Harmless illusions: hair color, glowing eyes, skin sparkles, antlers, all revert after 15 seconds
            for(var/mob/living/carbon/human/affected_human in (targets + list(user)))
                var/illusion_type = pick("hair", "eyes", "skin", "antlers")
                switch(illusion_type)
                    if("hair")
                        temporarily_dye_hair_green(affected_human)
                    if("eyes")
                        temporary_faerie_eyes(affected_human)
                    if("skin")
                        for(var/mob/living/affected_mob in (surged_targets))
                            apply_illusion(affected_mob, /obj/effect/overlay/vis/illusion/sparkles)
                            affected_human.visible_message(span_notice("[affected_human]'s skin sparkles with motes of magic!"))
                    if("antlers")
                        temporary_antlers(affected_human)
            user.visible_message(span_notice("Fey magic weaves harmless illusions over everyone!"))
        if(7)
            // Everyone is rooted in place by magical vines
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/rooted)
            user.visible_message(span_warning("Vines erupt from the ground, rooting everyone in place!"))
        if(8)
            // Faerie dust heals everyone a small amount
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.adjustBruteLoss(-5)
                affected_mob.adjustFireLoss(-5)
                affected_mob.adjustToxLoss(-5)
                affected_mob.adjustOxyLoss(-5)
                affected_mob.visible_message(span_notice("Sparkling faerie dust heals [affected_mob] slightly!"))
            user.visible_message(span_notice("Faerie dust rains from above, mending minor wounds!"))
        if(9)
            // Everyone laughs uncontrollably
            for(var/mob/living/affected_mob in (surged_targets))
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
            for(var/mob/living/affected_mob in (surged_targets))
                var/mob/living/simple_animal/animal_type = pick(animal_types)
                var/mob/living/simple_animal/spawned_animal = new animal_type(affected_mob.loc)
                spawned_animal.name = "Wild [animal_type.name]"
            user.visible_message(span_notice("Tiny woodland creatures scamper out of nowhere!"))
        if(11)
            // User and targets swap places randomly
            var/list/all_mobs = (surged_targets)
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
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/buff/shield, 30 SECONDS)
            user.visible_message(span_notice("A shimmering shield surrounds everyone!"))
        if(13)
            // Everyone is randomly teleported a short distance
            for(var/mob/living/affected_mob in (surged_targets))
                step(affected_mob, pick(GLOB.cardinals))
            user.visible_message(span_notice("Wild magic scatters everyone unpredictably!"))
        if(14)
            // Everyone is blinded or gains night vision
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                if(prob(50))
                    affected_mob.blind_eyes(4)
                    affected_mob.visible_message(span_danger("[affected_mob]'s eyes cloud over!"))
                else
                    affected_mob.apply_status_effect(/datum/status_effect/buff/darkvision, 15 SECONDS)
                    affected_mob.visible_message(span_notice("[affected_mob]'s eyes glow with night vision!"))
            user.visible_message(span_notice("Wild magic twists everyone's sight!"))
        if(15)
            // Everyone is healed, but silenced for 20 seconds
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.adjustBruteLoss(-20)
                affected_mob.adjustFireLoss(-20)
                affected_mob.adjustToxLoss(-20)
                affected_mob.adjustOxyLoss(-20)
                affected_mob.adjust_silence(20 SECONDS)
            user.visible_message(span_notice("A healing light washes over everyone, but no words can be spoken!"))
        if(16)
            //everyone is compelled to dance
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.emote("dance")
            user.visible_message(span_notice("A fey compulsion to dance overtakes everyone!"))
        if(17)
            // All blink a random distance (1-5 tiles) in a random cardinal direction, to the nearest open turf
            for(var/mob/living/affected_mob in (surged_targets))
                var/dir = pick(NORTH, SOUTH, EAST, WEST)
                var/max_dist = rand(1, 5)
                var/turf/origin = get_turf(affected_mob)
                var/turf/dest = null
                // Try from farthest to closest
                for(var/dist = max_dist, dist >= 1, dist--)
                    var/turf/check = get_step(origin, dir)
                    for(var/i = 2, i <= dist, i++)
                        if(check)
                            check = get_step(check, dir)
                    if(check && istype(check, /turf) && isopenturf(check))
                        dest = check
                        break
                if(dest)
                    affected_mob.forceMove(dest)
                    affected_mob.visible_message(span_notice("[affected_mob] suddenly blinks a short distance!"))
                else
                    affected_mob.visible_message(span_notice("[affected_mob] tries to blink, but nothing happens!"))
            user.visible_message(span_notice("Everyone blinks unpredictably!"))
        if(18)
            // All are briefly confused
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.confused += 10
            user.visible_message(span_notice("A wave of fey confusion muddles everyone's senses!"))
        if(19)
            // All are blessed with a random beneficial status effect
            var/list/buff_types = list(/datum/status_effect/buff/bladeward, /datum/status_effect/buff/haste, /datum/status_effect/buff/fortitude)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(pick(buff_types), 20 SECONDS)
            user.visible_message(span_notice("Wild magic blesses everyone with fey power!"))
        if(20)
            // Flowers or vines sprout from everyone for 15 seconds (vis_contents overlay)
            for(var/mob/living/affected_mob in (surged_targets))
                apply_illusion(affected_mob, /obj/effect/overlay/vis/illusion/flowers)
                affected_mob.visible_message(span_notice("Flowers and vines sprout from [affected_mob]'s body!"))
            user.visible_message(span_notice("Fey magic causes everyone to bloom!"))
        if(21)
            for(var/mob/living/affected_mob in (surged_targets))
                if(affected_mob == user)
                    continue
                var/obj/projectile/magic/repel/proj_repel = new /obj/projectile/magic/repel(user.loc)
                proj_repel.firer = user
                proj_repel.preparePixelProjectile(affected_mob, user)
                proj_repel.fire()
            user.visible_message(span_notice("A sure of wild magic erupts, nearby figures are cast away as though struck by an angry forest god."))
        if(22)
            for(var/mob/living/affected_mob in (surged_targets))
                apply_illusion(affected_mob, /obj/effect/overlay/vis/illusion/petal)
            user.visible_message(span_notice("Petals rain gently from the air!"))
        if(23)
            // All are affected by a random color change (RP effect)
            for(var/mob/living/carbon/human/affected_human in (targets + list(user)))
                temporary_skin_color(affected_human)
        if(24)
            // All are surrounded by a faint, musical chime
            playsound(user.loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
            user.visible_message(span_notice("A musical chime echoes through the air!"))
        if(25)
            // Fire a guided bolt at each affected mob (except the user)
            for(var/mob/living/affected_mob in (surged_targets))
                if(affected_mob == user)
                    continue
                var/obj/projectile/energy/guided_bolt/proj_guided = new /obj/projectile/energy/guided_bolt(user.loc)
                proj_guided.firer = user
                proj_guided.preparePixelProjectile(affected_mob, user)
                proj_guided.fire()
            user.visible_message(span_notice("Wild magic unleashes a volley of guided bolts!"))
        if(26)
            for(var/mob/living/affected_mob in (surged_targets))
                apply_illusion(affected_mob, /obj/effect/overlay/vis/illusion/leaf)
            user.visible_message(span_notice("Autumn leaves swirl around everyone!"))
        if(27)
            // All are struck by a sudden, harmless gust of wind
            for(var/mob/living/affected_mob in (surged_targets))
                step_away(affected_mob, user, 2)
            user.visible_message(span_notice("A playful wind tugs at everyone!"))
        if(28)
            // All are briefly silenced, but gain haste
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/silenced, 10 SECONDS)
                affected_mob.apply_status_effect(/datum/status_effect/buff/haste, 10 SECONDS)
            user.visible_message(span_notice("Speedy silence falls upon all!"))
        if(29)
            // All are surrounded by a faint, glowing aura
            for(var/mob/living/affected_mob in (surged_targets))
                var/glow_color = "#F0E68C"
                var/filter_id = "wildmagic_glow"
                if (!affected_mob.get_filter(filter_id))
                    affected_mob.add_filter(filter_id, 2, list("type" = "outline", "color" = glow_color, "alpha" = 120, "size" = 2))
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by a faint, glowing aura!"))
                addtimer(CALLBACK(affected_mob, "remove_filter", filter_id), 15 SECONDS)
                addtimer(CALLBACK(affected_mob, "update_icon"), 15 SECONDS)
            user.visible_message(span_notice("Fey magic makes everyone glow!"))
        if(30)
            // All are randomly swapped with a nearby animal (if any)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
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
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/chilled, 5 SECONDS)
                sleep(5 SECONDS)
                affected_mob.apply_status_effect(/datum/status_effect/buff/fortitude, 5 SECONDS)
            user.visible_message(span_notice("A chill, then a warm breeze, passes over everyone!"))
        if(32)
            // All are surrounded by a faint, sweet scent
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                to_chat(affected_mob, span_notice("You are surrounded by the scent of honey and wildflowers!"))
            user.visible_message(span_notice("The air is thick with fey scents!"))
        if(33)
            // All are compelled to sing (RP effect)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/singcurse)
            user.visible_message(span_notice("A fey curse compels everyone to sing!"))
        if(34)
            // All are briefly slowed, then sped.
            for(var/mob/living/affected_mob in (surged_targets))
                // Apply a strong slow
                affected_mob.add_movespeed_modifier("wildmagic_slow", TRUE, 100, multiplicative_slowdown=3)
            user.visible_message(span_notice("Time seems to slow for everyone!"))
            sleep(5 SECONDS)
            for(var/mob/living/affected_mob in (surged_targets))
                // Remove slow, apply haste (faster than normal)
                affected_mob.remove_movespeed_modifier("wildmagic_slow")
                affected_mob.add_movespeed_modifier("wildmagic_haste", TRUE, 200, multiplicative_slowdown=-1)
            user.visible_message(span_notice("Time suddenly speeds up for everyone!"))
            sleep(5 SECONDS)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.remove_movespeed_modifier("wildmagic_haste")
        if(35)
            // All are surrounded by a faint, sparkling mist
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by sparkling fey mist!"))
                // Add a faint, non-blocking smoke effect at their location
                new /obj/effect/particle_effect/smoke/transparent(get_turf(affected_mob))
            user.visible_message(span_notice("A sparkling mist fills the air!"))
        if(36)
            // All are compelled to compliment the next person they see (RP effect)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/complimentcurse, 30 SECONDS)
            user.visible_message(span_notice("A fey compulsion to compliment others fills everyone!"))
        if(37)
            // All are briefly immune to damage
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.status_flags |= GODMODE
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by a protective aura!"))
            spawn(5 SECONDS)
                for(var/mob/living/affected_mob in (surged_targets))
                    affected_mob.status_flags &= ~GODMODE
                    affected_mob.visible_message(span_notice("[affected_mob]'s protective aura fades away!"))	
            user.visible_message(span_notice("For a moment, nothing can harm anyone!"))
        if(38)
            // All are compelled to hop on one foot (RP effect)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.emote("jump")
            user.visible_message(span_notice("A fey curse compels everyone to hop on one foot!"))
        if(39)
            // All are surrounded by a faint, silvery light
            for(var/mob/living/affected_mob in (surged_targets))
                var/glow_color = "#C0C0FF" // pale silvery-blue
                var/filter_id = "wildmagic_silverglow"
                if (!affected_mob.get_filter(filter_id))
                    affected_mob.add_filter(filter_id, 2, list("type" = "outline", "color" = glow_color, "alpha" = 120, "size" = 2))
                affected_mob.visible_message(span_notice("[affected_mob] is bathed in silvery moonlight!"))
                addtimer(CALLBACK(affected_mob, "remove_filter", filter_id), 15 SECONDS)
                addtimer(CALLBACK(affected_mob, "update_icon"), 15 SECONDS)
            user.visible_message(span_notice("Moonlight bathes everyone in silver!"))
        if(40)
            // All are compelled to tell a secret (RP effect)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/secretcurse, 30 SECONDS)
            user.visible_message(span_notice("A fey compulsion to reveal secrets fills everyone!"))
        if(41)
            // All are surrounded by a faint, buzzing sound (RP effect)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                to_chat(affected_mob, span_notice("You hear a faint, buzzing sound!"))
            user.visible_message(span_notice("The air is filled with the sound of fey wings!"))
        if(42)
            // All are compelled to mimic the last person who spoke (RP effect)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/mimiccurse, 20 SECONDS)
            user.visible_message(span_notice("A fey curse compels everyone to mimic others!"))
        if(43)
            // All are briefly immune to magic (RP effect)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/antimagic, 5 SECONDS)
            user.visible_message(span_notice("For a moment, magic cannot touch anyone!"))
        if(44)
            // All are compelled to move in random directions for a short time (chaos dance)
            for(var/mob/living/affected_mob in (surged_targets))
                spawn(0)
                    for(var/i = 1, i <= 5, i++)
                        step(affected_mob, pick(GLOB.cardinals))
                        sleep(1)
            user.visible_message(span_notice("Wild magic causes everyone to stagger about unpredictably!"))
        if(45)
            // All are surrounded by a faint, golden glow (using outline filter)
            for(var/mob/living/affected_mob in (surged_targets))
                var/glow_color = "#FFD700" // gold
                var/filter_id = "wildmagic_goldglow"
                if (!affected_mob.get_filter(filter_id))
                    affected_mob.add_filter(filter_id, 2, list("type" = "outline", "color" = glow_color, "alpha" = 120, "size" = 2))
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by a golden glow!"))
                addtimer(CALLBACK(affected_mob, "remove_filter", filter_id), 15 SECONDS)
                addtimer(CALLBACK(affected_mob, "update_icon"), 15 SECONDS)
            user.visible_message(span_notice("A golden glow fills the air!"))
        if(46)
            // All are compelled to speak only in questions (RP effect)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/questioncurse, 30 SECONDS)
            user.visible_message(span_notice("A fey curse compels everyone to speak only in questions!"))
        if(47)
            // All are surrounded by a faint, icy breeze
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                to_chat(affected_mob, span_notice("You shiver as an icy breeze passes by!"))
            user.visible_message(span_notice("An icy breeze chills the air!"))
        if(48)
            // All are compelled to compliment themselves (RP effect)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/selfcomplimentcurse, 20 SECONDS)
            user.visible_message(span_notice("A fey curse compels everyone to compliment themselves!"))
        if(49)
            // All are surrounded by a faint, rainbow shimmer (I'm giving it a purple glow, no idea how to animate it)
            for(var/mob/living/affected_mob in (surged_targets))
                var/glow_color = "#B06FFC"
                var/filter_id = "wildmagic_rainbowglow"
                if (!affected_mob.get_filter(filter_id))
                    affected_mob.add_filter(filter_id, 2, list("type" = "outline", "color" = glow_color, "alpha" = 120, "size" = 2))
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by a rainbow shimmer!"))
                addtimer(CALLBACK(affected_mob, "remove_filter", filter_id), 15 SECONDS)
                addtimer(CALLBACK(affected_mob, "update_icon"), 15 SECONDS)
            user.visible_message(span_notice("A rainbow shimmer fills the air!"))
        if(50)
            sleep(0.5 SECONDS)
            var/obj/effect/proc_holder/spell/doubled = new spell
            doubled.perform(targets, FALSE, user)
            user.visible_message(span_notice("Wild magic causes the spell to fire twice!"))

/datum/charflaw/wildmagic
	name = "Wild Magic"
	desc = "I have a special connection to the Verdant Court, They sometimes interferes with my magic."

/datum/charflaw/wildmagic/on_mob_creation(mob/user)
	ADD_TRAIT(user, TRAIT_WILDMAGIC, "[type]")
