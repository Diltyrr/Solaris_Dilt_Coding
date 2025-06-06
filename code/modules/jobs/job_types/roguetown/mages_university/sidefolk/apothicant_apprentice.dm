/datum/job/roguetown/apothicant_apprentice
	title = "Apothicant Apprentice"
	flag = APOTHICANT_APPRENTICE
	department_flag = MAGES_UNIVERSITY
	selection_color = JCOLOR_MAGES
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT)
	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation)

	tutorial = "You're a novice study on Alchemy under the Mage's University, doing your best to learn and hone your \
				craft under the tutelage of Sunmarch's guildhall for the Mage's University and it's leader therein. \
				Answering directly to the Alchemists who've managed, you find it isn't always easy, alchemy a gruelling \
				process of trial and error - but it's rewards tempt you further within..."

	outfit = /datum/outfit/job/roguetown/apothecary


	display_order = JDO_APOTHICANT_APPRENTICE
	give_bank_account = 30

	min_pq = 0
	max_pq = null
	round_contrib_points = 2

/datum/outfit/job/roguetown/apothecary/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/black
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	belt = /obj/item/storage/belt/rogue/leather/rope
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/book/spellbook
	beltr = /obj/item/storage/keyring/mages_university
	id = /obj/item/scomstone/bad
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/natural/worms/leech/cheele = 1
	)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	H.change_stat("intelligence", 3)
	H.change_stat("perception", 2)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
