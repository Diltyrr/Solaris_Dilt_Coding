GLOBAL_LIST_INIT(toyjester_aggro, world.file2list("strings/rt/toyjesteraggrolines.txt"))

/mob/living/carbon/human/species/construct/metal/toyjester
	aggressive=1
	mode = NPC_AI_IDLE
	faction = list("toybox")
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	possible_rmb_intents = list(/datum/rmb_intent/feint, /datum/rmb_intent/aimed, /datum/rmb_intent/strong, /datum/rmb_intent/weak)
	var/is_silent = FALSE /// Determines whether or not we will scream our funny lines at people.

/mob/living/carbon/human/species/construct/metal/toyjester/ambush
	aggressive=1
	wander = TRUE

/mob/living/carbon/human/species/construct/metal/toyjester/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
	if(!is_silent && target != newtarg)
		say(pick(GLOB.toyjester_aggro))
		linepoint(target)

/mob/living/carbon/human/species/construct/metal/toyjester/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/construct/metal/toyjester/Initialize()
	. = ..()
	set_species(/datum/species/construct/metal)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)
	is_silent = TRUE


/mob/living/carbon/human/species/construct/metal/toyjester/after_creation()
	..()
	job = "Toy Jester"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_KNEESTINGER_IMMUNITY, TRAIT_GENERIC) //Tamari devouts log off
	equipOutfit(new /datum/outfit/job/roguetown/human/species/construct/metal/toyjester)
	gender = pick(MALE, FEMALE)
	regenerate_icons()

	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	var/obj/item/organ/ears/organ_ears = getorgan(/obj/item/organ/ears)
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	var/hairf = pick(list(/datum/sprite_accessory/hair/head/doublebun, 
						/datum/sprite_accessory/hair/head/halfbang, 
						/datum/sprite_accessory/hair/head/long, 
						/datum/sprite_accessory/hair/head/pixie))
	var/hairm = pick(list(/datum/sprite_accessory/hair/head/shorthaireighties, 
						/datum/sprite_accessory/hair/head/business4, 
						/datum/sprite_accessory/hair/head/emo, 
						/datum/sprite_accessory/hair/head/ponytail4))

	var/datum/bodypart_feature/hair/head/new_hair = new()

	if(gender == FEMALE)
		new_hair.set_accessory_type(hairf, null, src)
	else
		new_hair.set_accessory_type(hairm, null, src)

	new_hair.accessory_colors = "#a37126"
	new_hair.hair_color = "#a37126"
	hair_color = "#a37126"

	head.add_bodypart_feature(new_hair)

	dna.update_ui_block(DNA_HAIR_COLOR_BLOCK)
	dna.species.handle_body(src)

	if(organ_eyes)
		organ_eyes.eye_color = "#C01414"
		organ_eyes.accessory_colors = "#C01414#C01414"
	
	if(organ_ears)
		organ_ears.accessory_colors = "#A18047"
	
	skin_tone = "A18047"

	real_name = pick(world.file2list("strings/rt/names/other/toyjester.txt"))

	update_hair()
	update_body()

/mob/living/carbon/human/species/construct/metal/toyjester/npc_idle()
	if(m_intent == MOVE_INTENT_SNEAK)
		return
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc,pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src,pick(GLOB.cardinals)))
	if(!wander && prob(10))
		face_atom(get_step(src,pick(GLOB.cardinals)))

/mob/living/carbon/human/species/construct/metal/toyjester/handle_combat()
	if(mode == NPC_AI_HUNT)
		if(prob(5))
			emote("laugh")
		if(prob(5))
			emote("chuckle")
		if(prob(5))
			emote("giggle")
	. = ..()

/datum/outfit/job/roguetown/human/species/construct/metal/toyjester/pre_equip(mob/living/carbon/human/H)
	var/toyclass = rand(1,3)
	switch(toyclass)
		if(1) //Jester
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/jester
			pants = /obj/item/clothing/under/roguetown/tights/jester
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			mask = /obj/item/clothing/mask/rogue/facemask
			if(prob(50))
				mask = /obj/item/clothing/mask/rogue/ragmask/black
			head = /obj/item/clothing/head/roguetown/jester
			if(prob(50))
				head = /obj/item/clothing/head/roguetown/helmet/leather
			neck = /obj/item/clothing/neck/roguetown/leather
			if(prob(50))
				neck = /obj/item/clothing/neck/roguetown/gorget
			gloves = /obj/item/clothing/gloves/roguetown/angle
			shoes = /obj/item/clothing/shoes/roguetown/jester
			H.STASTR = rand(10,12)
			H.STASPD = rand(10,12)
			H.STACON = rand(12,14)
			H.STAEND = rand(12,14)
			H.STAPER = rand(10,12)
			H.STAINT = rand(10,12)
			if(prob(50))
				r_hand = /obj/item/rogueweapon/knuckles/bronzeknuckles
				l_hand = /obj/item/rogueweapon/knuckles/bronzeknuckles
			else
				r_hand = /obj/item/rogueweapon/eaglebeak/lucerne
		if(2) //Toy Arquebusier
			armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
			shirt = /obj/item/clothing/suit/roguetown/shirt/jester
			pants = /obj/item/clothing/under/roguetown/tights/jester
			cloak = /obj/item/clothing/cloak/cape
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			mask = /obj/item/clothing/mask/rogue/facemask
			if(prob(50))
				mask = /obj/item/clothing/mask/rogue/ragmask/black
			head = /obj/item/clothing/head/roguetown/helmet/tricorn
			if(prob(1))
				head = /obj/item/clothing/head/roguetown/helmet/tricorn/lucky
			neck = /obj/item/clothing/neck/roguetown/leather
			if(prob(50))
				neck = /obj/item/clothing/neck/roguetown/gorget
			gloves = /obj/item/clothing/gloves/roguetown/angle
			shoes = /obj/item/clothing/shoes/roguetown/jester
			H.STASTR = rand(10,12)
			H.STASPD = rand(12,14)
			H.STACON = rand(10,12)
			H.STAEND = rand(12,14)
			H.STAPER = rand(10,12)
			H.STAINT = rand(10,12)
			r_hand = /obj/item/rogueweapon/halberd/toyarquebus
			beltl = /obj/item/ammopouch/bullets
		if(3) //Toy Knight
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/jester
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			mask = /obj/item/clothing/mask/rogue/facemask
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
			neck = /obj/item/clothing/neck/roguetown/gorget
			gloves = /obj/item/clothing/gloves/roguetown/chain/iron
			shoes = /obj/item/clothing/shoes/roguetown/jester
			H.STASTR = rand(12,14)
			H.STASPD = rand(10,12)
			H.STACON = rand(12,14)
			H.STAEND = rand(10,12)
			H.STAPER = rand(10,12)
			H.STAINT = rand(10,12)
			if(prob(50))
				r_hand = /obj/item/rogueweapon/sword/iron
				l_hand = /obj/item/rogueweapon/shield/heater
			else
				r_hand = /obj/item/rogueweapon/sword/iron/messer
				l_hand = /obj/item/rogueweapon/shield/heater
	
