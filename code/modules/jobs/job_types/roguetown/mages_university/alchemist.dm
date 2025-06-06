/datum/job/roguetown/alchemist
	title = "Alchemist"
	flag = ALCHEMIST
	department_flag = MAGES_UNIVERSITY
	selection_color = JCOLOR_MAGES
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS

	tutorial = "You're a practiced alchemist under the Mage's University, having honed your craft upon years of study. \
				While you tutor understudies in a handful of Apothicant Apprentices, it's a rewarding craft that's helped \
				Solaris Ridge - and your own coin, goodness knows - more times than you can fathom remembering."

	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	outfit = /datum/outfit/job/roguetown/alchemist
	display_order = JDO_ALCHEMIST
	display_order = 6
	give_bank_account = 12
	min_pq = -3
	max_pq = null

/datum/outfit/job/roguetown/alchemist
	name = "Alchemist"
	jobtype = /datum/job/roguetown/alchemist
	backpack_contents = list(/obj/item/book/spellbook = 1)

/datum/outfit/job/roguetown/alchemist/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 6, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("speed", -1)
//Requires a lot of sprites, so this is just a placeholder
	if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/storage/keyring/mages_university
		cloak = /obj/item/clothing/cloak/apron/brown
	else if(should_wear_femme_clothes(H))
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/storage/keyring/mages_university
		cloak = /obj/item/clothing/cloak/apron/brown
