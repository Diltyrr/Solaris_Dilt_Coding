/datum/job/roguetown/ghandler
	title = "Guild Handler"
	flag = GHANDLER
	department_flag = YEOMEN
	selection_color = JCOLOR_YEOMAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS

	tutorial = "You are the proud handler for the local branch of the Rasurian Adventurer's Guild. You've taken upon yourself the task of wrangling the constant flow of adventurers and treasure-seekers into the March. It is a job of constant diplomacy and occasional action, keeping the local lords happy while arranging quests and affairs for the adventurers."
	outfit = /datum/outfit/job/roguetown/ghandler
	display_order = JDO_GHANDLER
	give_bank_account = 43
	min_pq = 1
	max_pq = null
	round_contrib_points = 2

/datum/job/roguetown/ghandler/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name

/datum/outfit/job/roguetown/ghandler
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/ghandler
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
	pants = /obj/item/clothing/under/roguetown/tights/black
	neck = /obj/item/clothing/neck/roguetown/horus
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/keyring/ghandler
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	id = /obj/item/scomstone
	backpack_contents = list(/obj/item/paper = 4, /obj/item/natural/feather = 1, /obj/item/rogueweapon/huntingknife/idagger/steel/parrying = 1)

/datum/outfit/job/roguetown/ghandler/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("fortune", 2)
		H.change_stat("speed", 1)
