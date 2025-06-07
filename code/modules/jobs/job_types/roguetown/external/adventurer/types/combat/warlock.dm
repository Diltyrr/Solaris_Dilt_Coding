/datum/advclass/warlock
	name = "Warlock"
	tutorial = "Warlocks are individuals who have formed a pact with an otherworldly entity, \
	gaining supernatural powers in exchange for their faith or other significant sacrifice. \
	Their powers are derived from sources beyond mortal understanding and are often associated with dark magic and forbidden knowledge."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/warlock
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/combat_bandit_mage.ogg'

/datum/outfit/job/roguetown/adventurer/warlock


/datum/outfit/job/roguetown/adventurer/warlock/pre_equip(mob/living/carbon/human/H)
	..()

	H.adjust_blindness(-3)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/eldritchblast)
		H.mind.adjust_spellpoints(1) // all warlocks get at least 3 points to spend
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/alchemy, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/magic/arcane, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 3 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/tracking, 1, TRUE)
		ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
	backr = /obj/item/storage/backpack/rogue/satchel
	neck = null
	var/patrons = list(
		"The Verdant Court",        // Formerly "archfey"
		"The Radiant Ember",        // Formerly "celestial"
		"The Drowned Choir",        // Formerly "fathomless"
		"The Ashen Pact",           // Formerly "fiend" 
		"The Bound Whisper",        // Formerly "genie"
		"The Hollow Voice",         // Formerly "great old one"
		"The Wakened Blade",        // Formerly "hexblade"
		"The Pale Crown",           // Formerly "undead"
	)

	var/patronchoice = input("Choose your otherworldly patron", "Available patrons") as anything in patrons

	switch(patronchoice)
		if("The Verdant Court")
			archfeypatron(H, patronchoice)
		if("The Radiant Ember")
			celestialpatron(H, patronchoice)
		if("The Drowned Choir")
			fathomlesspatron(H, patronchoice)
		if("The Ashen Pact")
			fiendpatron(H, patronchoice)
		if("The Bound Whisper")
			geniepatron(H, patronchoice)
		if("The Hollow Voice")
			goopatron(H, patronchoice)
		if("The Wakened Blade")
			hexbladepatron(H, patronchoice)
		if("The Pale Crown")
			undeadpatron(H, patronchoice)

	var/boons = list( //what did you trade away a piece of yourself for?
		"A sharper edge",        // strength / blade pact
		"Secrets best left buried", // knowledge / tome pact
		"A body that won't break",  // health
		"Gold that never feels warm", // wealth / talisman
		"A love that clings",        // soulbinding
		"A voice that answers",      // friendship / chain pact
		"A name the world must fear",// power
		"A reason to keep breathing",// purpose / star chain
		"A wound that must be answered" // revenge / curse
	)

	var/boonchoice = input("What did you trade away a piece of yourself for?", "The Boon") as anything in boons

	switch(boonchoice)
		if("A sharper edge") //Pact of the Blade
			H.put_in_hands(giveweapon(H,patronchoice), FALSE)
			H.change_stat("strength", 1)
			H.set_blindness(0)
		if("A voice that answers") //Pact of the Chain
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/findfamiliar)
			H.change_stat("perception", 1)
			H.set_blindness(0)
		if("Secrets best left buried") //Pact of the Tome
			H.put_in_hands(givebook(patronchoice), FALSE)
			H.change_stat("intelligence", 1)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/guidance)
		if("A name the world must fear") //empowered eldritch blast
			H.mind.RemoveSpell(/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/eldritchblast/empowered)
			H.change_stat("intelligence", 1)
			H.mind.adjust_spellpoints(1)
		if("A love that clings") //ring of soulbinding
			H.put_in_hands(givering(H))
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
			H.change_stat("endurance", 1)
			H.set_blindness(0)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/variellecurse)
		if("A body that won't break") //make healthier
			givehealing(H, patronchoice)
			H.change_stat("constitution", 1)
			H.set_blindness(0)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		if("Gold that never feels warm") //Pact of the Talisman
			H.put_in_hands(giveamulet(patronchoice), FALSE)
			beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
			ADD_TRAIT(H,TRAIT_SEEPRICES, TRAIT_GENERIC)
			H.set_blindness(0)
		if("A reason to keep breathing") //Pact of the Star Chain
			wrists = /obj/item/rope/chain/constellation
			H.set_blindness(0)
		if("A wound that must be answered") //give curse
			givecurse(H, patronchoice)
			H.change_stat("speed", 1)
			H.set_blindness(0)

/datum/outfit/job/roguetown/adventurer/warlock/proc/archfeypatron(mob/living/carbon/human/H, patronchoice)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)

	head = /obj/item/clothing/head/roguetown/helmet/foresterhelmet
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
	shoes = /obj/item/clothing/shoes/roguetown/sandals
	r_hand = /obj/item/rogueweapon/woodstaff
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/rogueweapon/huntingknife

	//caster stats (must be 5 stat point total)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 2)
	H.change_stat("constitution", 1)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/seelie_dust)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/archfey_warlock_strip)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/archfey_warlock_seelie_kiss)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/summon_rat)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/roustame)

	ADD_TRAIT(H, TRAIT_WILDMAGIC, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCANE_T3, TRAIT_GENERIC)

	H.visible_message(span_info("I brushed against the glimmering court beneath leaf and moon, and it whispered secrets into my soul."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/celestialpatron(mob/living/carbon/human/H, patronchoice)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2,   TRUE)

	// armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	belt = /obj/item/storage/belt/rogue/leather
	r_hand = /obj/item/rogueweapon/spear
	backpack_contents = list(/obj/item/rogueweapon/huntingknife)

	//caster stats (must be 5 stat point total)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 2)
	H.change_stat("constitution", 1)

	H.mind.adjust_spellpoints(2) // general arcane power, less total gain than other trees, 4 points total (it's hard to give "celestial" a real spell theme)

	givehealing(H, patronchoice, TRUE)
	ADD_TRAIT(H, TRAIT_ARCANE_T3, TRAIT_GENERIC)

	H.visible_message(span_info("Something bright found me in the dark. It left a spark that hasn't gone out."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/fathomlesspatron(mob/living/carbon/human/H, patronchoice) // a watery creature
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/fishing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	backl = /obj/item/fishingrod
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/carapacecap
	else
		head = /obj/item/clothing/head/roguetown/fisherhat
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
	cloak = /obj/item/clothing/cloak/raincloak/yellow
	wrists = /obj/item/rope
	r_hand = /obj/item/rogueweapon/pitchfork
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	belt =/obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/huntingknife
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes

	backpack_contents = list(/obj/item/rope)

	//melee stats (must be 5 stat point total)
	H.change_stat("perception", 1)
	H.change_stat("strength", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 1)
	H.change_stat("speed", -1)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/acidsplash)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/frostbite) // "water" and ice magic, less arcane power because armor and dodge training

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_WATERBREATHING, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCANE_T2, TRAIT_GENERIC)

	H.visible_message(span_info("The sea sang to me once. I haven't been able to stop hearing it since."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/fiendpatron(mob/living/carbon/human/H, patronchoice) //hellish fiend
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)

	head = /obj/item/clothing/head/roguetown/roguehood/red
	mask = /obj/item/clothing/mask/rogue/facemask/goldmask
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/magered
	back = /obj/item/clothing/cloak/raincloak/red
	r_hand = /obj/item/rogueweapon/woodstaff
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/rogueweapon/huntingknife
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes

	//caster stats (must be 5 stat point total)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 2)
	H.change_stat("constitution", 1)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball) // fireball is a very strong spell, fiendkiss makes it even stronger
	ADD_TRAIT(H, TRAIT_NOFIRE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_FIENDKISS, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCANE_T3, TRAIT_GENERIC)

	H.visible_message(span_info("I reached into a cold fire that never dies. It remembers me now."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/geniepatron(mob/living/carbon/human/H, patronchoice) //a desert entity
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 2, TRUE)

	head = /obj/item/clothing/head/roguetown/roguehood/shalal
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	gloves = /obj/item/clothing/gloves/roguetown/angle
	beltr = /obj/item/wisp_lantern
	beltl = /obj/item/rogueweapon/sword/sabre
	belt = /obj/item/storage/belt/rogue/leather/shalal
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	id = /obj/item/clothing/ring/gold/signet
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/rich)

	//lucky stats (must be 5 stat point total)
	H.change_stat("endurance", 1) //
	H.change_stat("speed", 2)
	H.change_stat("fortune", 2)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/haste)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/repulse) // going with wind theme, speed and airblast, possibly eventual picker for "which type of genie did you make a deal with"

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCANE_T2, TRAIT_GENERIC)


	H.visible_message(span_info("There was a voice in a jar, a bottle, a name. I let it out. Or it let me in."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/goopatron(mob/living/carbon/human/H, patronchoice)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)

	head = /obj/item/clothing/head/roguetown/roguehood/mage
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/tsoridys
	beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/rogueweapon/huntingknife
	r_hand = /obj/item/rogueweapon/woodstaff

	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor)

	//caster stats (must be 5 stat point total)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 2)
	H.change_stat("constitution", 1)

	ADD_TRAIT(H, TRAIT_ARCANE_T3, TRAIT_GENERIC)

	H.mind.adjust_spellpoints(3) // 6 total spell points after arcane adjust; forbidden eldritch knowledge to build your own spellbook, but you get nothing else

	H.visible_message(span_info("I heard a silence too loud to bear. Now it's inside me, humming."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/hexbladepatron(mob/living/carbon/human/H, patronchoice)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/axes, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 1, TRUE)
	// H.mind.adjust_skillrank_up_to(/datum/skill/magic/arcane, 1, TRUE) // This gets overwritten by the 3 arcane given by the giveweapon proc
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	shoes = /obj/item/clothing/shoes/roguetown/boots
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	beltl = /obj/item/rogueweapon/huntingknife
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor

	H.put_in_hands(giveweapon(H,patronchoice), FALSE)

	//melee stats (must be 5 stat point total)
	H.change_stat("perception", 1)
	H.change_stat("strength", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 1)
	H.change_stat("speed", -1)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/greenflameblade) // put that new weapon to work! martial focus means less magic
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mending)

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCANE_T2, TRAIT_GENERIC)

	H.visible_message(span_info("The weapon spoke first. I only answered. Now it never leaves."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/undeadpatron(mob/living/carbon/human/H, patronchoice)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/shields, 2, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	cloak = /obj/item/clothing/cloak/raincloak/brown
	gloves = /obj/item/clothing/gloves/roguetown/angle
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	wrists = /obj/item/clothing/wrists/roguetown/vambraces
	neck = /obj/item/clothing/neck/roguetown/gorget
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/iron
	head = /obj/item/clothing/head/roguetown/helmet/skullcap
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/sword/iron/short
	backl = /obj/item/rogueweapon/shield/tower
	// They're the tank subclass, so I'm keeping their armor in. If it's a problem, it's pretty easy to comment it out and give them hauberks instead
	//tank stats (must be 5 stat point total)
	H.change_stat("strength", 1)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/cloakofflies)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/infestation)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/chilltouch) // decay-themed magic and a skeletal hand to attack people with

	// ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) // Unnecessary with the heavy armor trait
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCANE_T2, TRAIT_GENERIC)

	H.visible_message(span_info("I stepped into a place no longer remembered, and something followed me out."))

///////////////////////////////
//	Faithless Healing
///////////////////////////////

/datum/outfit/job/roguetown/adventurer/warlock/proc/givehealing(mob/living/carbon/human/H, patronname = "", ignore_faithless = FALSE)
	var/obj/effect/proc_holder/spell/invoked/eldritchhealing/eldritchhealing = new /obj/effect/proc_holder/spell/invoked/eldritchhealing
	if(ignore_faithless)
		eldritchhealing.ignore_faithless = TRUE
	eldritchhealing.patronname = patronname
	switch(patronname) //god damn put this in a datum or something....
		if("The Verdant Court")
			eldritchhealing.targetnotification = "I am surrounded in a puff of seelie dust."
			eldritchhealing.othernotification = "is surrounded in a puff of seelie dust."
		if("The Radiant Ember")
			eldritchhealing.targetnotification = "I am encircled in a tapestry of glittering starlight."
			eldritchhealing.othernotification = "is encircled in a tapestry of glittering starlight."
		if("The Drowned Choir")
			eldritchhealing.targetnotification = "My pain is siphoned away by an inky tendril!"
			eldritchhealing.othernotification = "'s injuries are siphoned away by an inky tendril!"
		if("The Bound Whisper")
			eldritchhealing.targetnotification = "I just feel better all of a sudden."
			eldritchhealing.othernotification = "looks better."
		if("The Hollow Voice")
			eldritchhealing.targetnotification = "My wounds distort and fade away."
			eldritchhealing.othernotification = "'s injuries distort and fade away."
		if("The Wakened Blade")
			eldritchhealing.targetnotification = "My wounds close leaving scars."
			eldritchhealing.othernotification = "'s wounds close leaving scars."
		if("The Pale Crown")
			eldritchhealing.targetnotification = "Maggots eat away my dead flesh!"
			eldritchhealing.othernotification = "'s wounds are healed by... Maggots?"
	H.mind.AddSpell(eldritchhealing)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular) // If you get healing, you get diagnose

///////////////////////////////
//	Curse
///////////////////////////////

/datum/outfit/job/roguetown/adventurer/warlock/proc/givecurse(mob/living/carbon/human/H, patronname = "")
	var/obj/effect/proc_holder/spell/invoked/eldritchcurse/curse = new /obj/effect/proc_holder/spell/invoked/eldritchcurse

	switch(patronname) //god damn put this in a datum or something....
		if("The Verdant Court")
			curse.curse = /datum/status_effect/buff/eldritchcurse/archfey
		if("The Radiant Ember")
			curse.curse = /datum/status_effect/buff/eldritchcurse/celestial
		if("The Drowned Choir")
			curse.curse = /datum/status_effect/buff/eldritchcurse/fathomless
		if("The Bound Whisper")
			curse.curse = /datum/status_effect/buff/eldritchcurse/genie
		if("The Hollow Voice")
			curse.curse = /datum/status_effect/buff/eldritchcurse/goo
		if("The Wakened Blade")
			curse.curse = /datum/status_effect/buff/eldritchcurse/hexblade
		if("The Pale Crown")
			curse.curse = /datum/status_effect/buff/eldritchcurse/undead
	curse.name += patronname
	curse.patronname = patronname
	H.mind.AddSpell(curse)

///////////////////////////////
//	Pact Book
///////////////////////////////

/datum/outfit/job/roguetown/adventurer/warlock/proc/givebook(patronchoice)
	var/obj/item/item
	var/item_type = /obj/item/book/rogue/eldritch
	item = new item_type
	item.name = "grimoire of the "+patronchoice
	return item

/obj/item/book/rogue/eldritch
	desc = "An earie book containing hidden knowledge."
	icon_state = "ledger_0"
	force = 20
	throwforce = 10
	breakouttime = 2 MINUTES
	var/active_item
	var/spell1
	var/spell2
	var/spell3

/obj/item/book/rogue/eldritch/Initialize()
	. = ..()
	// TODO: GLOBAL LISTS OF SPELLS, THIS IS PAINFUL
	spell1 = pick(
		/obj/effect/proc_holder/spell/invoked/projectile/fireball,
		/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt,
		/obj/effect/proc_holder/spell/invoked/projectile/fetch,
		/obj/effect/proc_holder/spell/invoked/projectile/spitfire,
		/obj/effect/proc_holder/spell/invoked/projectile/firebolt,
		/obj/effect/proc_holder/spell/invoked/projectile/frostbolt,
		/obj/effect/proc_holder/spell/invoked/projectile/acidsplash,
		/obj/effect/proc_holder/spell/invoked/blade_burst,
		/obj/effect/proc_holder/spell/invoked/frostbite,
		/obj/effect/proc_holder/spell/invoked/arcane_storm,
		/obj/effect/proc_holder/spell/invoked/chilltouch,
		/obj/effect/proc_holder/spell/invoked/mindsliver,
		/obj/effect/proc_holder/spell/invoked/lightninglure,
		/obj/effect/proc_holder/spell/invoked/greenflameblade,
	)
	spell2 = pick(
		/obj/effect/proc_holder/spell/invoked/forcewall/greater,
		/obj/effect/proc_holder/spell/self/bladeward,
	)
	spell3 = pick(
		/obj/effect/proc_holder/spell/invoked/snap_freeze,
		/obj/effect/proc_holder/spell/self/message,
		/obj/effect/proc_holder/spell/invoked/repulse,
		/obj/effect/proc_holder/spell/invoked/leap,
		/obj/effect/proc_holder/spell/aoe_turf/conjure/Wolf,
		/obj/effect/proc_holder/spell/invoked/guidance,
		/obj/effect/proc_holder/spell/targeted/encodethoughts,
		/obj/effect/proc_holder/spell/invoked/magicstone,
		/obj/effect/proc_holder/spell/invoked/mending,
		/obj/effect/proc_holder/spell/self/light,
		/obj/effect/proc_holder/spell/invoked/create_campfire,
		/obj/effect/proc_holder/spell/targeted/touch/prestidigitation,
	)


/obj/item/book/rogue/eldritch/equipped(mob/living/user)
	. = ..()
	if(active_item)
		return
	else
		active_item = TRUE
		to_chat(user, span_notice("Your mind swells with knowledge"))
		user.change_stat("intelligence", 1)
		user.mind.AddSpell(new spell1)
		user.mind.AddSpell(new spell2)
		user.mind.AddSpell(new spell3)
		user.mind.AddSpell(new /obj/effect/proc_holder/spell/self/message)
		return

/obj/item/book/rogue/eldritch/dropped(mob/living/user)
	. = ..()
	if(active_item)
		to_chat(user, span_notice("Your intellect shrinks away"))
		user.change_stat("intelligence", -1)
		user.mind.RemoveSpell(spell1)
		user.mind.RemoveSpell(spell2)
		user.mind.RemoveSpell(spell3)
		user.mind.RemoveSpell(/obj/effect/proc_holder/spell/self/message)
		active_item = FALSE
		return

///////////////////////////////
//	Weapon of X
///////////////////////////////

/datum/outfit/job/roguetown/adventurer/warlock/proc/giveweapon(mob/living/carbon/human/H, patronchoice)
	H.mind.adjust_skillrank_up_to(/datum/skill/magic/arcane, 3, TRUE)
	
	var/weapons_choice = list(
		"Axe",
		"Battleaxe",
		"Cleaver",
		"Dagger",
		"Eagle's Beak",
		"Flail",
		"Goden",
		"Greatsword",
		"Halberd",
		"Longsword",
		"Mace",
		"Peasant war flail",
		"Rapier",
		"Scythe",
		"Spear",
		"Whip",
	)

	var/weapon_chosen = input("Choose your sentient weapon", "Available weapons") as anything in weapons_choice
	var/item_type

	switch(weapon_chosen)
		if("Axe")
			item_type = /obj/item/rogueweapon/stoneaxe/woodcut/steel
		if("Battleaxe")
			item_type = /obj/item/rogueweapon/stoneaxe/battle
		if("Cleaver")
			item_type = /obj/item/rogueweapon/huntingknife/cleaver
		if("Dagger")
			item_type = /obj/item/rogueweapon/huntingknife/idagger/steel
		if("Eagle's Beak")
			item_type = /obj/item/rogueweapon/eaglebeak
		if("Flail")
			item_type = /obj/item/rogueweapon/flail/sflail
		if("Goden")
			item_type = /obj/item/rogueweapon/mace/goden/steel
		if("Greatsword")
			item_type = /obj/item/rogueweapon/greatsword
		if("Halberd")
			item_type = /obj/item/rogueweapon/halberd
		if("Longsword")
			item_type = /obj/item/rogueweapon/sword/long
		if("Mace")
			item_type = /obj/item/rogueweapon/mace/steel
		if("Peasant war flail")
			item_type = /obj/item/rogueweapon/flail/peasantwarflail
		if("Rapier")
			item_type = /obj/item/rogueweapon/sword/rapier
		if("Scythe")
			item_type = /obj/item/rogueweapon/sickle/scythe
		if("Spear")
			item_type = /obj/item/rogueweapon/spear
		if("Whip")
			item_type = /obj/item/rogueweapon/whip

	var/obj/item/item
	item = new item_type
	item.AddComponent(/datum/component/pact_weapon, H, patronchoice)
	item.AddComponent(/datum/component/singing_item, H)
	item.AddComponent(/datum/component/spirit_holding, null, null)
	return item

///////////////////////////////
//	Signet Ring
///////////////////////////////

/obj/item/clothing/ring/gold/signet
	name = "signet ring"
	desc = "A ring that denotes nobility."
	var/active_item

/obj/item/clothing/ring/gold/signet/equipped(mob/living/user)
	. = ..()
	if(active_item)
		return
	else
		active_item = TRUE
		to_chat(user, span_notice("You feel noble."))
		ADD_TRAIT(user, TRAIT_NOBLE, TRAIT_GENERIC)
		return

/obj/item/clothing/ring/gold/signet/dropped(mob/living/user)
	. = ..()
	if(active_item)
		to_chat(user, span_notice("You feel like a peasant."))
		REMOVE_TRAIT(user, TRAIT_NOBLE, TRAIT_GENERIC)
		active_item = FALSE
		return

///////////////////////////////
//	TALISMAN OF X
///////////////////////////////

/datum/outfit/job/roguetown/adventurer/warlock/proc/giveamulet(patronchoice)
	var/obj/item/item
	var/item_type = /obj/item/clothing/neck/roguetown/psicross/eldritch
	item = new item_type
	item.name += patronchoice
	return item

/obj/item/clothing/neck/roguetown/psicross/eldritch
	name = "talisman of the "
	desc = "An earie glowing talisman."
	icon_state = "eldritch"
	var/active_item

/obj/item/clothing/neck/roguetown/psicross/eldritch/equipped(mob/living/user)
	. = ..()
	if(active_item)
		return
	else
		active_item = TRUE
		to_chat(user, span_notice("You feel lucky."))
		user.change_stat("fortune", 3)
		return

/obj/item/clothing/neck/roguetown/psicross/eldritch/dropped(mob/living/user)
	. = ..()
	if(active_item)
		to_chat(user, span_notice("Your stroke of luck has ended."))
		user.change_stat("fortune", -3)
		active_item = FALSE
		return

///////////////////////////////
//	CONSTELLATION CHAIN
///////////////////////////////

/obj/item/rope/chain/constellation
	desc = "A strange chain resembling a constellation."
	icon_state = "starchain"
	force = 20
	throwforce = 10
	breakouttime = 2 MINUTES
	var/active_item

/obj/item/rope/chain/constellation/equipped(mob/living/user)
	. = ..()
	if(active_item)
		return
	else
		active_item = TRUE

		var/obj/item/organ/eyes/eyes = user.getorganslot(ORGAN_SLOT_EYES)
		eyes.see_in_dark = 8
		eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
		eyes.sight_flags = initial(eyes.sight_flags)
		eyes.sight_flags &= ~SEE_BLACKNESS
		eyes.owner.update_sight()

		to_chat(user, span_notice("Your purpose seems clearer now"))
		user.change_stat("intelligence", 1)
		user.change_stat("fortune", 1)
		return

/obj/item/rope/chain/constellation/dropped(mob/living/user)
	. = ..()
	if(active_item)
		to_chat(user, span_notice("Your purpose is scattered to the wind"))

		var/obj/item/organ/eyes/eyes = user.getorganslot(ORGAN_SLOT_EYES)
		eyes.see_in_dark = 2
		eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_VISIBLE
		eyes.sight_flags = 0
		eyes.owner.update_sight()

		user.change_stat("intelligence", -1)
		user.change_stat("fortune", -1)
		active_item = FALSE
		return

///////////////////////////////
//	Soulbond Ring
///////////////////////////////
/datum/outfit/job/roguetown/adventurer/warlock/proc/givering(mob/living/carbon/human/H)
	var/item_type = /obj/item/clothing/ring/diamond/soulbond
	var/obj/item/item
	item = new item_type
	item.item_owner = H
	return item

/obj/item/clothing/ring/diamond/soulbond
	name = "Soulbond Ring"
	desc = "A ring that bonds two together eternally."

/obj/item/clothing/ring/diamond/soulbond/equipped(mob/living/user, slot)
	. = ..()
	if(slot == SLOT_RING)
		if(user == item_owner)
			to_chat(user, span_warning("You feel lonely. This is meant to go on someone else."))
		else
			ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
			to_chat(item_owner, span_warning("[user]'s life force is tied directly to yours."))
			to_chat(user, span_warning("Your lifeforce is linked to [item_owner]'s."))
			soullink(/datum/soullink/oneway/delay, item_owner, user)

/obj/item/clothing/ring/diamond/soulbond/dropped(mob/living/user)
	. = ..()
	qdel(user.GetComponent(/datum/soullink/oneway))
	REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
