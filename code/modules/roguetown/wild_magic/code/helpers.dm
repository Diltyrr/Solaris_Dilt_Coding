/obj/effect/proc_holder/spell/invoked/wild_magic_testing
	name = "Wild Magic Testing"
	desc = "A spell that tests the unpredictable nature of wild magic."

/obj/effect/proc_holder/spell/invoked/wild_magic_testing/cast(target, mob/user)
	var/input = input(user, "Enter a wild magic effect number to test (1-50):", "Wild Magic Test", 1) as num
	if(isnum(input) && input >= 2 && input <= 49)
		trigger_wild_magic(list(target), user, src, input)
	else if(isnum(input) && (input == 50 || input == 1))
		to_chat(user, span_notice("Can't test those with this spell, It would loop infinitely.")) //Not actually procing it or it would get stuck in a loop.
	else
		to_chat(user, span_warning("Invalid effect number. Please enter a number between 1 and 50."))

/proc/apply_illusion(atom/movable/target, type)
    var/obj/overlay = new type
    target.vis_contents += overlay
    target.update_icon()
    spawn(150)
        if(!target || QDELETED(target)) return
        target.vis_contents -= overlay
        target.update_icon()
        qdel(overlay)

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

	if (current_horns)
		// Replace the accessory type with antlers
		current_horns.accessory_type = /datum/sprite_accessory/horns/antlers
		current_horns.accessory_colors = "#8B4513"
		target.update_body_parts()
	else
		// Create new antler horns
		current_horns = new /obj/item/organ/horns()
		current_horns.accessory_type = /datum/sprite_accessory/horns/antlers
		current_horns.accessory_colors = "#8B4513"
		target.internal_organs += current_horns
		target.equip_to_slot(current_horns, SLOT_HEAD)
		target.update_body_parts()
	
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
		target.update_body_parts()

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
