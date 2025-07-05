//file name is voluntary, for it to be loaded before spell and still be in order in the dme.

/proc/trigger_wild_magic(list/targets, mob/living/carbon/user, spell_typepath, effect_override = null)
    playsound(user.loc, 'sound/misc/sudden noise.ogg', 100, TRUE)
    if(HAS_TRAIT(user, TRAIT_WILDMAGIC_BENEFIC))
        user.apply_status_effect(/datum/status_effect/buff/verdant_wild_gift)
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
            user.log_message(span_danger("Wild magic surge, user is the target."), LOG_ATTACK)
            if(spell_typepath)
                var/obj/effect/proc_holder/spell/spell_instance = new spell_typepath
                if(istype(spell_instance, /obj/effect/proc_holder/spell/invoked/projectile))
                    var/obj/effect/proc_holder/spell/invoked/projectile/projectile_instance = spell_instance
                    projectile_instance.reflect_projectile_to_user(spell_instance, user, targets[1])
                else
                    spell_instance.perform(list(user), FALSE, user)
                if(targets == user)
                    return
                else
                    user.visible_message(span_notice("The spell twists in the air, caught in unseen verdant whims, and turns its power upon [user]!"))

        if(2)
            for(var/mob/living/affected_mob in (surged_targets))
                if(affected_mob.anti_magic_check(TRUE, TRUE))
                    continue
                affected_mob.visible_message(span_warning("[affected_mob] starts to fade into thin air!"), span_notice("You start to become invisible!"))
                animate(affected_mob, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
                affected_mob.mob_timers[MT_INVISIBILITY] = world.time + 10 SECONDS
                addtimer(CALLBACK(affected_mob, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 10 SECONDS)
                addtimer(CALLBACK(affected_mob, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[affected_mob] fades back into view."), span_notice("You become visible again.")), 10 SECONDS)
            user.visible_message(span_notice("Figures shimmer, then vanish as if claimed by the will of the unseen court."))
        if(3)
            for(var/mob/living/affected_mob in (surged_targets))
                apply_illusion(affected_mob.loc, /obj/effect/overlay/vis/illusion/mote)
            user.visible_message(span_notice("Wild magic coalesces into swirling motes of faelight, drifting through the air."))
        if(4)
            // Butterflies swirl around everyone (vis_contents overlay)
            for(var/mob/living/affected_mob in (surged_targets))
                apply_illusion(affected_mob, /obj/effect/overlay/vis/illusion/butterfly_swirl)
            user.visible_message(span_notice("A host of butterflies drifts into being, circling all in quiet, spellbound grace."))
        if(5)
            user.log_message(span_danger("Wild magic surge, mass fetch"), LOG_ATTACK)
            for(var/mob/living/affected_mob in (surged_targets))
                if(affected_mob == user)
                    continue
                var/obj/projectile/magic/fetch/proj_fetch = new /obj/projectile/magic/fetch(user.loc)
                proj_fetch.firer = user
                proj_fetch.preparePixelProjectile(affected_mob, user)
                proj_fetch.fire()
            user.visible_message(span_notice("The air stirs, mystic tethers snap tight, drawing some figures toward their source."))
        if(6)
            user.log_message(span_danger("Wild magic surge, temporary glamours"), LOG_ATTACK)
            user.visible_message(span_notice("Harmless glamour flutters through the air, leaving behind curious transformations."))
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
        if(7)
            user.log_message(span_danger("Wild magic surge, mass root"), LOG_ATTACK)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/rooted)
            user.visible_message(span_notice("Twisting vines surge from the soil, binding all in place."))
        if(8)
            // Faerie dust heals everyone a small amount
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.adjustBruteLoss(-5)
                affected_mob.adjustFireLoss(-5)
                affected_mob.adjustToxLoss(-5)
                affected_mob.adjustOxyLoss(-5)
                to_chat(affected_mob, span_notice("You feel a gentle warmth as faerie dust heals your wounds."))
            user.visible_message(span_notice("Faerie dust drifts from above."))
        if(9)
            // Everyone laughs uncontrollably
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.emote("laugh")
            user.visible_message(span_notice("A wave of fey mirth causes some to burst into laughter!"))
        if(10)
            // A random harmless animal appears at each person's feet
            var/list/animal_types = list(
                /mob/living/simple_animal/butterfly,
                /mob/living/simple_animal/chick,
                /mob/living/simple_animal/hostile/retaliate/rogue/chicken,
                /mob/living/simple_animal/mouse,
                /mob/living/simple_animal/hostile/retaliate/rogue/mudcrab,
            )
            for(var/mob/living/affected_mob in (surged_targets))
                var/mob/living/simple_animal/animal_type = pick(animal_types)
                var/mob/living/simple_animal/spawned_animal = new animal_type(affected_mob.loc)
                spawned_animal.name = "Wild [animal_type.name]"
            user.visible_message(span_notice("Tiny woodland creatures scamper out of nowhere!"))
        if(11)
            user.log_message(span_danger("Wild magic surge, location swapping"), LOG_ATTACK)
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
            user.visible_message(span_notice("With a sly giggle from nowhere, wild magic swaps the steps of the unwitting like dancers at a faerie masque."))
        if(12)
            user.log_message(span_danger("Wild magic surge, one hit shield"), LOG_ATTACK)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/buff/shield, 30 SECONDS)
            user.visible_message(span_notice("Silent and sudden, protective glamour settles over some figures."))
        if(13)
            user.log_message(span_danger("Wild magic surge, random teleport"), LOG_ATTACK)
            for(var/mob/living/affected_mob in (surged_targets))
                step(affected_mob, pick(GLOB.cardinals))
            user.visible_message(span_notice("With a mischievous shimmer, wild magic skips some a step sideways."))
        if(14)
            user.log_message(span_danger("Wild magic surge, nightvision or blind"), LOG_ATTACK)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                if(prob(50))
                    affected_mob.blind_eyes(4)
                    to_chat(affected_mob, span_warning("Your eyes are blinded by wild magic!"))
                else
                    affected_mob.apply_status_effect(/datum/status_effect/buff/darkvision, 15 SECONDS)
                    to_chat(affected_mob, span_notice("Your eyes glow with wild magic, granting you night vision!"))
            user.visible_message(span_notice("Sight bends to the whim of wild forces, blessing or blinding in equal measure."))
        if(15)
            user.log_message(span_danger("Wild magic surge, silencing heal"), LOG_ATTACK)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.adjustBruteLoss(-20)
                affected_mob.adjustFireLoss(-20)
                affected_mob.adjustToxLoss(-20)
                affected_mob.adjustOxyLoss(-20)
                affected_mob.adjust_silence(20 SECONDS)
            user.visible_message(span_notice("Soothing light graces all wounds, but with it comes silence."))
        if(16)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.emote("dance")
            user.visible_message(span_notice("The world sways to a silent tune as wild magic seizes some in a spellbound dance."))
        if(17)
            user.log_message(span_danger("Wild magic surge, mass teleport"), LOG_ATTACK)
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
                    continue
            user.visible_message(span_notice("With a ripple of wild glamour, figures vanishes, only to reappear somewhere nearby."))
        if(18)
            user.log_message(span_danger("Wild magic surge, mass confusion"), LOG_ATTACK)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.confused += 10
            user.visible_message(span_notice("A shimmer passes through the air, thoughts tangle like vines as confusion sets in."))
        if(19)
            user.log_message(span_danger("Wild magic surge, mass buffs"), LOG_ATTACK)
            var/list/buff_types = list(/datum/status_effect/buff/haste, /datum/status_effect/buff/fortitude) ///datum/status_effect/buff/bladeward to add when the warlock PR is in.
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(pick(buff_types), 20 SECONDS)
            user.visible_message(span_notice("Glimmers of fey light dance from figure to figure, leaving behind curious enchantments and sudden strength."))
        if(20)
            for(var/mob/living/affected_mob in (surged_targets))
                apply_illusion(affected_mob, /obj/effect/overlay/vis/illusion/flowers)
                to_chat(affected_mob, span_notice("You feel a gentle warmth as flowers bloom on you."))
            user.visible_message(span_notice("With a rustle and a giggle, fey magic wraps each figure in flowers."))
        if(21)
            user.log_message(span_danger("Wild magic surge, mass repel"), LOG_ATTACK)
            for(var/mob/living/affected_mob in (surged_targets))
                if(affected_mob == user)
                    continue
                var/obj/projectile/magic/repel/proj_repel = new /obj/projectile/magic/repel(user.loc)
                proj_repel.firer = user
                proj_repel.preparePixelProjectile(affected_mob, user)
                proj_repel.fire()
            user.visible_message(span_notice("The ground shudders as verdant force pulses outward, those nearby are cast away."))
        if(22)
            for(var/mob/living/affected_mob in (surged_targets))
                apply_illusion(affected_mob, /obj/effect/overlay/vis/illusion/petal)
            user.visible_message(span_notice("The skies bloom with grace as petals descend."))
        if(23)
            user.log_message(span_danger("Wild magic surge, temporary color change"), LOG_ATTACK)
            for(var/mob/living/carbon/human/affected_human in (targets + list(user)))
                temporary_skin_color(affected_human)
        if(24)
            // All are surrounded by a faint, musical chime
            spawn (70) //we wait to not overlay the feedback from wild magic			
                playsound(user.loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
                user.visible_message(span_notice("The air hums with delicate tones, as if unseen bells were stirred by passing magic."))
        if(25)
            user.log_message(span_danger("Wild magic surge, mass guided bolt"), LOG_ATTACK)
            for(var/mob/living/affected_mob in (surged_targets))
                if(affected_mob == user)
                    continue
                var/obj/projectile/energy/guided_bolt/proj_guided = new /obj/projectile/energy/guided_bolt(user.loc)
                proj_guided.firer = user
                proj_guided.preparePixelProjectile(affected_mob, user)
                proj_guided.fire()
            user.visible_message(span_notice("Gleaming bolts spiral forth, each one weaving through the air with uncanny purpose."))
        if(26)
            for(var/mob/living/affected_mob in (surged_targets))
                apply_illusion(affected_mob, /obj/effect/overlay/vis/illusion/leaf)
            user.visible_message(span_notice("Emerald leaves spiral through the air."))
        if(27)
            for(var/mob/living/affected_mob in (surged_targets))
                step_away(affected_mob, user, 2)
            user.visible_message(span_notice("A sudden gust of wind pushes some back slightly!"))  
        if(28)
            user.log_message(span_danger("Wild magic surge, mass silence and haste"), LOG_ATTACK)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/silenced, 10 SECONDS)
                affected_mob.apply_status_effect(/datum/status_effect/buff/haste, 10 SECONDS)
            user.visible_message(span_notice("Silence grips the air, yet every motion feels unnaturally swift."))  
        if(29)
            for(var/mob/living/affected_mob in (surged_targets))
                var/glow_color = "#F0E68C"
                var/filter_id = "wildmagic_glow"
                if (!affected_mob.get_filter(filter_id))
                    affected_mob.add_filter(filter_id, 2, list("type" = "outline", "color" = glow_color, "alpha" = 120, "size" = 2))
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by a faint, glowing aura!"))
                addtimer(CALLBACK(affected_mob, "remove_filter", filter_id), 15 SECONDS)
                addtimer(CALLBACK(affected_mob, "update_icon"), 15 SECONDS)
            user.visible_message(span_notice("Glamour shimmers to life, some figures bathed in a gentle, enchanted glow."))  
        if(30)
            user.log_message(span_danger("Wild magic surge, mass swap with animals"), LOG_ATTACK)
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
                    to_chat(affected_mob, span_notice("You feel a strange sensation as you swap places with [animal_to_swap]!"))
            user.visible_message(span_notice("Suddenly, people and creatures find themselves in unfamiliar places!"))  
        if(31)
            user.log_message(span_danger("Wild magic surge, mass chill and warmth"), LOG_ATTACK)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/chilled, 5 SECONDS)
                sleep(5 SECONDS)
                affected_mob.apply_status_effect(/datum/status_effect/buff/fortitude, 5 SECONDS)
            user.visible_message(span_notice("A sudden chill prickles the skin, then warmth follows."))  
        if(32)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                to_chat(affected_mob, span_notice("You are surrounded by the scent of honey and wildflowers!"))
            user.visible_message(span_notice("The scent of blooming meadows and golden nectar fills the air, thick with fey enchantment."))  
        if(33)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/singcurse)
            user.visible_message(span_notice("A trickster's melody weaves into the world, Som voices caught in its spellbound tune."))  
        if(34)
            user.log_message(span_danger("Wild magic surge, time slow and haste"), LOG_ATTACK)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.add_movespeed_modifier("wildmagic_slow", TRUE, 100, multiplicative_slowdown=3)
                to_chat(user, span_warning("You feel the world speed up around you."))
            sleep(5 SECONDS)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.remove_movespeed_modifier("wildmagic_slow")
                affected_mob.add_movespeed_modifier("wildmagic_haste", TRUE, 200, multiplicative_slowdown=-1)
                to_chat(user, span_warning("You feel the world slow down around you."))
            sleep(5 SECONDS)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.remove_movespeed_modifier("wildmagic_haste")
        if(35)
            for(var/mob/living/affected_mob in (surged_targets))
                to_chat(affected_mob, span_notice("You feel a strange, shimmering mist around you!"))
                new /obj/effect/particle_effect/smoke/transparent(get_turf(affected_mob))
            user.visible_message(span_notice("A shimmering mist unfurls, curling through the air like whispered magic."))  
        if(36)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/complimentcurse, 30 SECONDS)
            user.visible_message(span_notice("Wild magic stirs—suddenly, kind words and praise spill forth, whether willed or not!"))
        if(37)
            user.log_message(span_danger("Wild magic surge, temporary godmode"), LOG_ATTACK)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.status_flags |= GODMODE
                to_chat(affected_mob, span_notice("You feel an unseen force shielding you from harm!"))  
            spawn(5 SECONDS)
                for(var/mob/living/affected_mob in (surged_targets))
                    affected_mob.status_flags &= ~GODMODE
                    to_chat(affected_mob, span_notice("The protective aura fades, leaving you vulnerable once more."))  
            user.visible_message(span_notice("A shimmering ward envelops some, no harm may touch them, if only for a moment."))  
        if(38)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.emote("jump")
            user.visible_message(span_notice("Suddenly, everyone is hopping about!"))  
        if(39)
            for(var/mob/living/affected_mob in (surged_targets))
                var/glow_color = "#C0C0FF" // pale silvery-blue
                var/filter_id = "wildmagic_silverglow"
                if (!affected_mob.get_filter(filter_id))
                    affected_mob.add_filter(filter_id, 2, list("type" = "outline", "color" = glow_color, "alpha" = 120, "size" = 2))
                addtimer(CALLBACK(affected_mob, "remove_filter", filter_id), 15 SECONDS)
                addtimer(CALLBACK(affected_mob, "update_icon"), 15 SECONDS)
            user.visible_message(span_notice("A soft, silvery glow washes over some, as if touched by moonlight itself."))  
        if(40)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/secretcurse, 30 SECONDS)
            user.visible_message(span_notice("Suddenly, secrets slip from tongues, whether meant to or not!"))  
        if(41)
            spawn(70) //Delayed to not overlay sounds
                for(var/mob/living/carbon/affected_mob in (surged_targets))
                    to_chat(affected_mob, span_notice("You hear a faint, buzzing sound!"))
                playsound(user.loc, 'sound/misc/fliesloop.ogg', 100, TRUE)
                user.visible_message(span_notice("The air is filled with the sound of fey wings!"))
        if(42)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/mimiccurse, 20 SECONDS)
            user.visible_message(span_notice("Suddenly, voices echoes as figures begins mimicking one another!"))  
        if(43)
            user.log_message(span_danger("Wild magic surge, mass magic immunity"), LOG_ATTACK)
            for(var/mob/living/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/antimagic, 5 SECONDS)
            user.visible_message(span_notice("A strange stillness fills the air, magic falters, unable to take hold."))  
        if(44)
            for(var/mob/living/affected_mob in (surged_targets))
                if(affected_mob.health > 0) //We don't want corpses moving around
                    spawn(0)
                        for(var/i = 1, i <= 5, i++)
                            step(affected_mob, pick(GLOB.cardinals))
                            sleep(1)
            user.visible_message(span_notice("Feet move of their own accord, sending figures into a frantic, unpredictable dance!"))  
        if(45)
            for(var/mob/living/affected_mob in (surged_targets))
                var/glow_color = "#FFD700" // gold
                var/filter_id = "wildmagic_goldglow"
                if (!affected_mob.get_filter(filter_id))
                    affected_mob.add_filter(filter_id, 2, list("type" = "outline", "color" = glow_color, "alpha" = 120, "size" = 2))
                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by a golden glow!"))
                addtimer(CALLBACK(affected_mob, "remove_filter", filter_id), 15 SECONDS)
                addtimer(CALLBACK(affected_mob, "update_icon"), 15 SECONDS)
            user.visible_message(span_notice("A warm, golden light envelops some figures, shimmering with an otherworldly radiance.")) 
        if(46)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/questioncurse, 30 SECONDS)
            user.visible_message(span_notice("Every sentence becomes a question, like a riddle gone rogue!"))
        if(47)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                to_chat(affected_mob, span_notice("A shiver runs down your spine as cold brushes past you!"))
            user.visible_message(span_notice("An icy gust winds through the air, each breath misting with sudden cold."))  
        if(48)
            for(var/mob/living/carbon/affected_mob in (surged_targets))
                affected_mob.apply_status_effect(/datum/status_effect/debuff/selfcomplimentcurse, 20 SECONDS)
            user.visible_message(span_notice("A fey enchantment falls upon a few figures, they instantly seem more confident."))
        if(49)
            // Add a rainbow shimmer with stacked colored outlines
            for(var/mob/living/affected_mob in surged_targets)
                var/list/rainbow_colors = list("#FF0000", "#FFA500", "#00FF00", "#0000FF", "#4B0082")
                var/base_filter_id = "wildmagic_rainbowglow"
                var/index = 1
                var/size = 1

                for (var/color in rainbow_colors)
                    size = index / 3
                    var/filter_id = "[base_filter_id]_[index]"
                    if (!affected_mob.get_filter(filter_id))
                        affected_mob.add_filter(
                            filter_id,
                            2, // priority
                            list(
                                "type" = "outline",
                                "color" = color,
                                "alpha" = 120,
                                "size" = size // Stagger sizes for layered glow
                            )
                        )
                    index++

                affected_mob.visible_message(span_notice("[affected_mob] is surrounded by a rainbow shimmer!"))

                // Timer to clean up the effect after 15 seconds
                spawn(15 SECONDS)
                    index = 1
                    for (var/_ in rainbow_colors)
                        var/filter_id = "[base_filter_id]_[index++]"
                        affected_mob.remove_filter(filter_id)
                        affected_mob.update_icon()

            user.visible_message(span_notice("A radiant shimmer fills the air, Some figures haloed in iridescent magic."))
        if (50)
            user.log_message(span_danger("Wild magic surge, twinned spell"), LOG_ATTACK)
            if (spell_typepath)
                var/obj/effect/proc_holder/spell/spell_instance = new spell_typepath
                spell_instance.perform(targets[1], FALSE, user)
                sleep(0.5 SECONDS)
                var/obj/effect/proc_holder/spell/spell_instance_two = new spell_typepath
                spell_instance_two.perform(targets[1], FALSE, user)
                user.visible_message(span_notice("A pulse of wild energy twists the weave, [user.name]'s spell erupts twice in quick succession!"))


/datum/charflaw/wildmagic
	name = "Wild Magic"
	desc = "I have a special connection to the Verdant Court, They sometimes interferes with my magic."

/datum/charflaw/wildmagic/on_mob_creation(mob/user)
	ADD_TRAIT(user, TRAIT_WILDMAGIC, "[type]")
