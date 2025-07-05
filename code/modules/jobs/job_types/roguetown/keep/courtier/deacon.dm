/datum/job/roguetown/deacon
	title = "Deacon"
	flag = DEACON
	department_flag = COURTIERS
	selection_color = JCOLOR_COURTIER
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_DEACON
	tutorial = "Yours was always one to help the lesser man - heal the wounded, cure the sick, mend what ails. Yet even the chapel of lights has \
				need to dabble in Rasurian politics, and your induction is evident as much as a trusted advisor for the court of Sunmarch. Represent \
				the interests of the church to the rest of the nobility - lest they lose sight of the nine and their guidance."
	outfit = /datum/outfit/job/roguetown/deacon
	whitelist_req = TRUE

	give_bank_account = 30
	min_pq = 3 // Please don't kill the marquis by operating on strong intent. Play barber surgeon until you're deserving of the great white beak of doom
	max_pq = null

	virtue_restrictions = list(/datum/virtue/utility/noble) // This one I'm iffy on. You're of the court; yeah, but you're still a churchie. IDK.
	round_contrib_points = 3

	cmode_music = 'sound/music/combat_physician.ogg'

/datum/job/roguetown/deacon/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name

/datum/outfit/job/roguetown/deacon
	name = "Deacon"
	jobtype = /datum/job/roguetown/deacon

/datum/outfit/job/roguetown/deacon/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/deacon
	mask = /obj/item/clothing/mask/rogue/deacon
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/deacon
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/black
	gloves = /obj/item/clothing/gloves/roguetown/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather/mourning
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/belt/rogue/surgery_bag/full/deacon
	beltr = /obj/item/storage/keyring/deacon
	id = /obj/item/scomstone/bad
	r_hand = /obj/item/rogueweapon/woodstaff
	backl = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 2,
		/obj/item/ritechalk = 1,
		/obj/item/natural/worms/leech/cheele = 1, //little buddy
		/obj/item/reagent_containers/glass/bottle/waterskin = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1
	)
	ADD_TRAIT(H, TRAIT_EMPATH, "[type]")
	ADD_TRAIT(H, TRAIT_NOSTINK, "[type]")
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 5, TRUE)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
		H.change_stat("strength", -1)
		H.change_stat("constitution", -1)
		H.change_stat("intelligence", 4)
		H.change_stat("fortune", 1)
		H.change_stat("endurance", 1)
		if(H.age == AGE_OLD)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
	var/datum/devotion/C = new /datum/devotion(H, H.patron) // This creates the cleric holder used for devotion spells
	C.grant_spells_deacon(H) // There can only be one true priest, so you're not as good.
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	switch(H.patron?.type)
		if(/datum/patron/lording_three/aeternus)
			neck = /obj/item/clothing/neck/roguetown/psicross/aeternus
		if(/datum/patron/lording_three/zira)
			neck = /obj/item/clothing/neck/roguetown/psicross/zira
		if(/datum/patron/peoples_pantheon/cinella)
			neck = /obj/item/clothing/neck/roguetown/psicross/cinella	
		if(/datum/patron/three_sisters/tamari)
			neck = /obj/item/clothing/neck/roguetown/psicross/tamari
		if(/datum/patron/lording_three/tsoridys)
			neck = /obj/item/clothing/neck/roguetown/psicross/tsoridys
		if(/datum/patron/peoples_pantheon/varielle)
			neck = /obj/item/clothing/neck/roguetown/psicross/varielle
		if(/datum/patron/three_sisters/nunos)
			neck = /obj/item/clothing/neck/roguetown/psicross/nunos
		if(/datum/patron/peoples_pantheon/carthus)
			neck = /obj/item/clothing/neck/roguetown/psicross/carthus
		if(/datum/patron/three_sisters/kasmidian)
			var/list/psicross_options = list(
				/obj/item/clothing/neck/roguetown/psicross, \
				/obj/item/clothing/neck/roguetown/psicross/aeternus, \
				/obj/item/clothing/neck/roguetown/psicross/zira, \
				/obj/item/clothing/neck/roguetown/psicross/cinella, \
				/obj/item/clothing/neck/roguetown/psicross/tamari, \
				/obj/item/clothing/neck/roguetown/psicross/tsoridys, \
				/obj/item/clothing/neck/roguetown/psicross/carthus, \
				/obj/item/clothing/neck/roguetown/psicross/nunos, \
				/obj/item/clothing/neck/roguetown/psicross/varielle, \
				/obj/item/clothing/neck/roguetown/psicross/wood, \
			)
			neck = pick(psicross_options) // Don't care to move this off xylix behavior yet
