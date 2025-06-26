/* Spell to test specific wild magic procs, uncomment if you need it.

/obj/effect/proc_holder/spell/invoked/wild_magic_testing
	name = "Wild Magic Testing"
	desc = "A spell that tests the unpredictable nature of wild magic."

/obj/effect/proc_holder/spell/invoked/wild_magic_testing/cast(target, mob/user)
	var/input = input(user, "Enter a wild magic effect number to test (1-50):", "Wild Magic Test", 1) as num

	if(isnum(input) && input >= 2 && input <= 49)
		trigger_wild_magic(list(target), user, src, input)

	else if(isnum(input) && (input == 50 || input == 1))
		var/choice = input("Choose a spell to use:", "Wild Magic Projectile") as null|anything in list(
			/obj/effect/proc_holder/spell/invoked/projectile/fireball,
			/obj/effect/proc_holder/spell/invoked/projectile/repel,
			/obj/effect/proc_holder/spell/invoked/projectile/fetch,
			/obj/effect/proc_holder/spell/invoked/projectile/guided_bolt,
			/obj/effect/proc_holder/spell/invoked/blade_burst,
			/obj/effect/proc_holder/spell/invoked/gravity,
		)

		if(choice)
			trigger_wild_magic(list(target), user, choice, input)
	else
		to_chat(user, span_warning("Invalid effect number. Please enter a number between 1 and 50."))

*/

///Apply a temporary illusion on the target.
/proc/apply_illusion(atom/movable/target, type)
    var/obj/overlay = new type
    target.vis_contents += overlay
    target.update_icon()
    spawn(150)
        if(!target || QDELETED(target)) return
        target.vis_contents -= overlay
        target.update_icon()
        qdel(overlay)

///Change the user's hair to neon green for 15 seconds.
/proc/temporarily_dye_hair_green(var/mob/living/carbon/human/target)
	var/obj/item/bodypart/head/head = target.get_bodypart(BODY_ZONE_HEAD)
	if(!head || !head.bodypart_features) return

	// Find current hair feature
	var/datum/bodypart_feature/hair/head/current_hair = null
	for(var/datum/bodypart_feature/hair/head/hair_feature in head.bodypart_features)
		current_hair = hair_feature
		break
	if(!current_hair) return

	// Store original color to revert later
	var/original_color = current_hair.hair_color

	// Create customizer objects
	var/datum/customizer_choice/bodypart_feature/hair/head/humanoid/hair_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/head/humanoid)
	var/datum/customizer_entry/hair/hair_entry = new()
	hair_entry.hair_color = sanitize_hexcolor("#00FF00", 6, TRUE) // Bright green

	// Make a new hair feature with the same type, new color
	var/datum/bodypart_feature/hair/head/new_hair = new()
	new_hair.set_accessory_type(current_hair.accessory_type, null, target)
	hair_choice.customize_feature(new_hair, target, null, hair_entry)

	// Apply new hair
	target.hair_color = hair_entry.hair_color
	target.dna.update_ui_block(DNA_HAIR_COLOR_BLOCK)
	head.remove_bodypart_feature(current_hair)
	head.add_bodypart_feature(new_hair)
	target.visible_message(span_notice("[target]'s hair take on a vibrant green hue!"))
	target.update_hair()

	// Spawn revert after 15s
	spawn(150)
		if(!target || QDELETED(target)) return

		// Revert using the stored color
		var/datum/customizer_entry/hair/revert_entry = new()
		revert_entry.hair_color = original_color

		var/datum/bodypart_feature/hair/head/revert_hair = new()
		revert_hair.set_accessory_type(new_hair.accessory_type, null, target)
		hair_choice.customize_feature(revert_hair, target, null, revert_entry)

		target.hair_color = revert_entry.hair_color
		target.dna.update_ui_block(DNA_HAIR_COLOR_BLOCK)
		head.remove_bodypart_feature(new_hair)
		head.add_bodypart_feature(revert_hair)
		target.update_hair()
		target.visible_message(span_notice("[target]'s hair returns to its original color!"))

///Change the user horn's into antler or give them if no horns, reverts after 15 sec.
/proc/temporary_antlers(mob/living/carbon/human/target)
    var/obj/item/organ/horns/current_horns = null
    var/old_accessory_type = null
    var/old_accessory_colors = null

    // Check for existing horns
    for (var/obj/item/organ/horn_organ in target.internal_organs)
        if (istype(horn_organ, /obj/item/organ/horns))
            current_horns = horn_organ
            old_accessory_type = horn_organ.accessory_type
            old_accessory_colors = horn_organ.accessory_colors
            break

    // If current horns exist, remove them completely before adding antlers
    if (current_horns)
        if (current_horns in target.internal_organs)
            target.internal_organs -= current_horns
        qdel(current_horns)
        current_horns = null

    // Now create new antler horns fresh
    current_horns = new /obj/item/organ/horns()
    current_horns.accessory_type = /datum/sprite_accessory/horns/antlers
    current_horns.accessory_colors = "#8B4513"
    target.internal_organs += current_horns
    target.update_hair()

    target.visible_message(span_notice("[target] grows majestic antlers!"))

    // Wait 15 seconds
    spawn(150) // 1 decisecond = 0.1 second, so 150 = 15s
        if (!target || !current_horns) return

        // Remove antlers
        if (current_horns in target.internal_organs)
            target.internal_organs -= current_horns
            qdel(current_horns)

        // Reapply old horns if they existed
        if (old_accessory_type)
            var/obj/item/organ/horns/restored = new /obj/item/organ/horns()
            restored.accessory_type = old_accessory_type
            restored.accessory_colors = old_accessory_colors
            target.internal_organs += restored
            target.visible_message(span_notice("[target]'s antlers vanish, replaced by their original horns!"))
        else
            target.visible_message(span_notice("[target]'s antlers vanish!"))
        target.update_hair()

///Change the target's eye for a "faerie blue" for 15 seconds.
/proc/temporary_faerie_eyes(mob/living/carbon/human/target)
	if(!istype(target)) return

	var/old_eye_color = target.eye_color
	target.eye_color = "#00FFCC" // faerie blue

	var/obj/item/organ/eyes/eyes_organ = target.getorganslot(ORGAN_SLOT_EYES)
	if(eyes_organ)
		eyes_organ.Remove(target)
		eyes_organ.eye_color = target.eye_color
		eyes_organ.Insert(target, TRUE, FALSE)

	target.update_body_parts()
	target.visible_message(span_notice("[target]'s eyes glow with faerie light!"))

	// Revert after 15 seconds
	spawn(150)
		if(!target || QDELETED(target)) return

		target.eye_color = old_eye_color

		var/obj/item/organ/eyes/current_eyes = target.getorganslot(ORGAN_SLOT_EYES)
		if(current_eyes)
			current_eyes.Remove(target)
			current_eyes.eye_color = old_eye_color
			current_eyes.Insert(target, TRUE, FALSE)

		target.update_body_parts()
		target.visible_message(span_notice("[target]'s eyes return to their natural color."))

///Change the target's skincolor for something garish for 15 seconds.
/proc/temporary_skin_color(mob/living/carbon/human/target)
	if(!istype(target)) return

	var/list/color_choices = list( //Yes I know, color code are supposed to have a # in front, but this is how the game handles them.
		"3B6EE3", // blue
		"3BE36E", // green
		"E33BBD", // pink
		"E3C53B", // gold
		"C0C0C0", // silver
		"A03BE3"  // violet
	)

	var/random_color = pick(color_choices)
	var/old_skin_color = target.skin_tone

	target.skin_tone = random_color
	target.update_body()
	target.visible_message(span_notice("[target]'s skin briefly shimmers with a new hue!"))

	// Revert after 15 seconds
	spawn(150)
		if(!target || QDELETED(target)) return

		target.skin_tone = old_skin_color
		target.update_body()

///Fire a received magic projectile that turns around to hit the caster after a delay.
/obj/effect/proc_holder/spell/invoked/projectile/proc/reflect_projectile_to_user(obj/effect/proc_holder/spell/invoked/projectile/spell_instance, mob/living/user, list/targets)
	var/turf/start = get_step(user, user.dir)
	var/obj/projectile/arced_proj = new spell_instance.projectile_type(start)

	var/atom/single_target = targets[1]

	arced_proj.original = single_target
	arced_proj.def_zone = user.zone_selected
	arced_proj.arcshot = user?.used_intent?.arc_check()
	if (arced_proj.arcshot)
		arced_proj.range = get_dist_euclidian(single_target, user)

	arced_proj.accuracy += (user.STAINT * -9) * 4
	arced_proj.bonus_accuracy += (user.STAINT - 8) * 3
	if (user.mind)
		arced_proj.bonus_accuracy += user.mind.get_skill_level(spell_instance.associated_skill) * 5

	arced_proj.firer = user
	arced_proj.preparePixelProjectile(single_target, user)

	for (var/V in spell_instance.projectile_var_overrides)
		if (arced_proj.vars[V])
			arced_proj.vv_edit_var(V, spell_instance.projectile_var_overrides[V])

	ready_projectile(arced_proj, single_target, user, 1)
	arced_proj.fire()

	var/old_speed = arced_proj.speed

	//redirection logic
	var/mob/living/dummy_firer = null
	spawn(3)
		if (arced_proj && !QDELETED(arced_proj))
			arced_proj.speed = 2

			spawn(2)
				if (arced_proj && !QDELETED(arced_proj))
					safely_cleanup_existing_fey_reflection(user)

					dummy_firer = get_dummy_firer(single_target, user)
					arced_proj.firer = dummy_firer
					arced_proj.original = user.loc

					var/turf/end = get_turf(user)
					var/angle = Get_Angle(get_turf(arced_proj), end)
					arced_proj.setAngle(angle)

			spawn(2)
				if (arced_proj && !QDELETED(arced_proj))
					arced_proj.speed = old_speed

			spawn(100) //dummy should clear after 10 sec, should be enough time for any projectile to hit.
				if (dummy_firer && !QDELETED(dummy_firer))
					safely_cleanup_fey_reflection(dummy_firer)

///Proc used to obtain a dummy "firer" variable for proc/reflect_projectile_to_user to avoid ground targetting breaking the proc.
/proc/get_dummy_firer(atom/target, mob/living/user)
	var/turf/current_turfget = null
	if(!isturf(target))
		current_turfget = get_turf(target)
	else
		current_turfget = target	
	var/mob/living/dummy = new /mob/living(current_turfget)
	dummy.name = "spell_dummy_[user.real_name]"
	dummy.invisibility = 101
	dummy.alpha = 0
	dummy.layer = initial(dummy.layer) - 1
	dummy.dir = get_dir(get_turf(target), get_turf(user))
	return dummy

///Cleans up old dummies that MIGHT cause issue if for some reason you get the exact same wild magic proc before the automated cleanup.
/proc/safely_cleanup_fey_reflection(mob/living/dummy)
	if (!dummy || QDELETED(dummy)) return
	if (is_spell_dummy(dummy))
		qdel(dummy)

/proc/safely_cleanup_existing_fey_reflection(mob/living/user)
	spawn(100)
		for (var/mob/living/mob in GLOB.mob_living_list)
			if (is_spell_dummy(mob) && findtext(mob.name, user.real_name))
				qdel(mob)

/proc/is_spell_dummy(mob/living/mob)
	return istype(mob) && mob.name && findtext(mob.name, "spell_dummy_") == 1
