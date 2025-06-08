/obj/effect/proc_holder/spell/self/findfamiliar
	name = "Find Familiar"
	desc = "Summon a loyal magical companion to aid you in your adventures."
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	recharge_time = 1 HOURS

	warnie = "spellwarning"

	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy

	xp_gain = FALSE
	miracle = FALSE
	spell_tier = 1
	cost = 1

	invocation = "Appare, spiritus fidus."
	invocation_type = "whisper"

	var/mob/living/simple_animal/pet/familiar/fam
	var/familiars = list(
		"Pondstone Toad (+1 Strength)" = /mob/living/simple_animal/pet/familiar/pondstone_toad,
		"Mist Lynx (+1 Perception)" = /mob/living/simple_animal/pet/familiar/mist_lynx,
		"Rune Rat (+1 Intelligence)" = /mob/living/simple_animal/pet/familiar/rune_rat,
		"Vaporroot Wisp (+1 Constitution)" = /mob/living/simple_animal/pet/familiar/vaporroot_wisp,
		"Ashcoiler (+1 Endurance)" = /mob/living/simple_animal/pet/familiar/ashcoiler,
		"Glimmer Hare (+1 Speed)" = /mob/living/simple_animal/pet/familiar/glimmer_hare,
		"Hollow Antlerling (+1 Luck)" = /mob/living/simple_animal/pet/familiar/hollow_antlerling,
	)

/obj/effect/proc_holder/spell/self/findfamiliar/warlock/
	name = "Find Familiar (Warlock)"
	invocation = "Tegos, nemetos trēwos."

/obj/effect/proc_holder/spell/self/findfamiliar/warlock/Initialize()
	. = ..()
	// Extend the familiar list with warlock-only ones
	familiars += list(
		"Gravemoss Serpent (+1 Strength, +1 Endurance)" = /mob/living/simple_animal/pet/familiar/gravemoss_serpent,
		"Starfield Crow (+1 Perception, +1 Luck)" = /mob/living/simple_animal/pet/familiar/starfield_crow,
		"Emberdrake (+1 Intelligence, +1 Constitution)" = /mob/living/simple_animal/pet/familiar/emberdrake,
		"Ripplefox (+1 Speed, +1 Luck)" = /mob/living/simple_animal/pet/familiar/ripplefox,
		"Whisper Stoat (+1 Perception, +1 Intelligence)" = /mob/living/simple_animal/pet/familiar/whisper_stoat,
		"Thornback Turtle (+1 Strength, +1 Constitution)" = /mob/living/simple_animal/pet/familiar/thornback_turtle,
	)

/obj/effect/proc_holder/spell/self/findfamiliar/cast(mob/user = usr)
	..()
	for(var/mob/living/simple_animal/pet/familiar/familiar_check in GLOB.player_list)
		if(familiar_check.familiar_summoner == user)
			to_chat(user, span_notice("You alread have a familiar."))
			revert_cast()

	var/familiarchoice = input("Choose your familiar", "Available familiars") as anything in familiars
	var/mob/living/simple_animal/pet/familiar/familiar_type = familiars[familiarchoice]
	to_chat(user, span_notice("Trying to find familiar..."))
	var/list/L = pollGhostCandidates("Do you want to play as [span_notice("[span_danger("[user.real_name]'s")] [familiarchoice]")]?", ROLE_SENTIENCE, null, FALSE, 100, POLL_IGNORE_SENTIENCE_POTION)

	if(LAZYLEN(L))
		var/mob/chosen_one =  pick(L)
		fam = new familiar_type(user.loc)
		fam.key = chosen_one.key
		fam.familiar_summoner = user
		user.visible_message(span_notice("[fam.summoning_emote]"))
		chosen_one.mind.transfer_to(fam)
		fam.fully_replace_character_name(null, "[user]'s familiar")
		fam.grant_all_languages(omnitongue=TRUE)
	else
		to_chat(user, span_notice("You could not find a familiar..."))
		
/*
	Familiar list and buffs below. 
	They probably need dedicated sprites at some point.
	Quick AI pictures idea for each of them : https://imgbox.com/g/MvanomKazA
*/

/mob/living/simple_animal/pet/familiar
	name = "Generic Wizard familiar"
	desc = "You shouldn't be seeing this."
	var/mob/living/carbon/familiar_summoner = null
	var/summoning_emote = null
	var/buff_given = null
	speak_chance = 1
	turns_per_move = 5
	ventcrawler = VENTCRAWLER_ALWAYS
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	density = FALSE
	see_in_dark = 6
	pass_flags = PASSMOB
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	minbodytemp = 200
	maxbodytemp = 400
	unsuitable_atmos_damage = 1
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1)

/datum/status_effect/buff/familiar
	duration = -1

/mob/living/simple_animal/pet/familiar/Initialize(mapload, mob/living/carbon/familiar_summoner)
	. = ..()
	familiar_summoner.apply_status_effect(buff_given)

/mob/living/simple_animal/pet/familiar/death()
	. = ..()
	familiar_summoner.remove_status_effect(buff_given)


/mob/living/simple_animal/pet/familiar/pondstone_toad
	name = "Pondstone Toad"
	desc = "This damp, heavy toad pulses with unseen strength. Its skin is cool and lined with mineral veins."
	summoning_emote = "A deep thrum echoes beneath your feet, and a mossy toad pushes itself free from the earth, humming low."
	buff_given = /datum/status_effect/buff/familiar/settled_weight

	speak = list("Hrrrm.", "Grrup.", "Blorp.")
	speak_emote = list("croaks low", "grumbles")
	emote_hear = list("croaks lowly.", "lets out a bubbling sound.")
	emote_see = list("shudders like stone.", "thumps softly in place.")

	icon = 'icons/mob/pets.dmi'
	icon_state = "cat2"
	icon_living = "cat2"
	icon_dead = "cat2_dead"
	
/datum/status_effect/buff/familiar/settled_weight
	id = "settled_weight"
	effectedstats = list("strength" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/settled_weight

/atom/movable/screen/alert/status_effect/buff/familiar/settled_weight
	name = "Settled Weight"
	desc = "You feel just a touch more grounded. Pushing back has become a little easier."

/mob/living/simple_animal/pet/familiar/mist_lynx
	name = "Mist Lynx"
	desc = "A ghostlike lynx, its eyes gleaming like twin moons. It never seems to blink, even when you're not looking."
	summoning_emote = "Mist coils into feline shape, resolving into a lynx with pale fur and unblinking silver eyes."
	buff_given = /datum/status_effect/buff/familiar/silver_glance

	speak = list("...") // mostly silent
	speak_emote = list("purrs softly", "whispers")
	emote_hear = list("lets out a soft yowl.", "whispers almost silently.")
	emote_see = list("pads in a circle.", "vanishes briefly, then reappears.")

/datum/status_effect/buff/familiar/silver_glance
	id = "silver_glance"
	effectedstats = list("perception" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/silver_glance

/atom/movable/screen/alert/status_effect/buff/familiar/silver_glance
	name = "Silver Glance"
	desc = "There's a flicker at the edge of your vision. You notice what others pass by."

/mob/living/simple_animal/pet/familiar/rune_rat
	name = "Rune Rat"
	desc = "This rat leaves fading runes in the air as it twitches. The smell of old paper clings to its fur."
	summoning_emote = "A faint spark dances through the air. A rat with a softly glowing tail scampers into existence."
	buff_given = /datum/status_effect/buff/familiar/threaded_thoughts

	speak = list("Skrii!", "Tik-tik.", "Chrr.")
	speak_emote = list("squeaks", "chatters")
	emote_hear = list("squeaks thoughtfully.", "sniffs the air.")
	emote_see = list("twitches its tail in patterns.", "skitters in a loop.")

/datum/status_effect/buff/familiar/threaded_thoughts
	id = "threaded_thoughts"
	effectedstats = list("intelligence" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/threaded_thoughts

/atom/movable/screen/alert/status_effect/buff/familiar/threaded_thoughts
	name = "Threaded Thoughts"
	desc = "Your thoughts gather more easily, like threads pulled into a tidy weave."

/mob/living/simple_animal/pet/familiar/vaporroot_wisp
	name = "Vaporroot_wisp"
	desc = "This vaporroot wisp shimmers and shifts like smoke but feels solid enough to lean on."
	summoning_emote = "A swirl of silvery mist gathers, coalescing into a small wisp of vaporroot."
	buff_given = /datum/status_effect/buff/familiar/quiet_resilience

	speak = list("Fffff...", "Whuuuh.")
	speak_emote = list("whispers", "murmurs")
	emote_hear = list("hums softly.", "emits a calming mist.")
	emote_see = list("swirls in place.", "dissolves briefly.")

/datum/status_effect/buff/familiar/quiet_resilience
	id = "quiet_resilience"
	effectedstats = list("endurance" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/quiet_resilience

/atom/movable/screen/alert/status_effect/buff/familiar/quiet_resilience
	name = "Quiet Resilience"
	desc = "A calm strength hums beneath your skin. You breathe a little deeper."

/mob/living/simple_animal/pet/familiar/ashcoiler
	name = "Ashcoiler"
	desc = "This long-bodied snake coils slowly, like a heated rope. Its breath carries a faint scent of burnt herbs."
	summoning_emote = "Dust rises and circles before coiling into a gray-scaled creature that radiates dry, residual warmth."
	buff_given = /datum/status_effect/buff/familiar/desert_bred_tenacity

	speak = list("Ssshh...", "Hhsss.", "Ffff.")
	speak_emote = list("hisses", "rasps")
	emote_hear = list("hisses faintly.", "breathes a puff of ash.")
	emote_see = list("slowly coils and uncoils.", "shifts weight in rhythm.")

/datum/status_effect/buff/familiar/desert_bred_tenacity
	id = "desert_bred_tenacity"
	effectedstats = list("endurance" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/desert_bred_tenacity

/atom/movable/screen/alert/status_effect/buff/familiar/desert_bred_tenacity
	name = "Desert-Bred Tenacity"
	desc = "You feel steady and patient, like something that has survived years without rain."

/mob/living/simple_animal/pet/familiar/glimmer_hare
	name = "Glimmer Hare"
	desc = "A quick, nervy creature. Light bends strangely around its translucent body."
	summoning_emote = "The air glints, and a translucent hare twitches into existence."
	buff_given = /datum/status_effect/buff/familiar/lightstep
	
	speak = list("Tik!", "Tch!", "Hah!")
	speak_emote = list("chatters quickly", "chirps")
	emote_hear = list("thumps the ground.", "scatters some dust.")
	emote_see = list("dashes suddenly, then stops.", "vibrates subtly.")

/datum/status_effect/buff/familiar/lightstep
	id = "lightstep"
	effectedstats = list("speed" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/lightstep

/atom/movable/screen/alert/status_effect/buff/familiar/lightstep
	name = "Lightstep"
	desc = "You move with just a touch more ease."

/mob/living/simple_animal/pet/familiar/hollow_antlerling
	name = "Hollow Antlerling"
	desc = "A dog-sized deer with gleaming hollow antlers. It seems unaware of danger, yet avoids it perfectly."
	summoning_emote = "A musical chime sounds. A tiny deer with antlers like bone flutes steps gently into view."
	buff_given = /datum/status_effect/buff/familiar/soft_favor

	speak = list("Hrrn.", "Mnnn.", "Chuff.")
	speak_emote = list("chimes softly", "calls out")
	emote_hear = list("lets out a musical chime.")
	emote_see = list("flickers like a mirage.", "steps just out of reach of falling dust.")

/datum/status_effect/buff/familiar/soft_favor
	id = "soft_favor"
	effectedstats = list("luck" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/soft_favor

/atom/movable/screen/alert/status_effect/buff/familiar/soft_favor
	name = "Soft Favor"
	desc = "Fortune seems to tilt in your direction."

/mob/living/simple_animal/pet/familiar/gravemoss_serpent
	name = "Gravemoss Serpent"
	desc = "Its scales are flecked with lichen and grave-dust. Wherever it passes, roots twitch faintly in the soil."
	summoning_emote = "The ground heaves faintly as a long, moss-veiled serpent uncoils from it."
	buff_given = /datum/status_effect/buff/familiar/burdened_coil

	speak = list("Grhh...", "Sssrrrh.", "Urrh.")
	speak_emote = list("hisses low", "mutters")
	emote_hear = list("rumbles from deep within.", "hisses like wind in roots.")
	emote_see = list("sinks halfway into the earth.", "gazes steadily.")

/datum/status_effect/buff/familiar/burdened_coil
	id = "burdened_coil"
	effectedstats = list("strength" = 1, "endurance" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/burdened_coil

/atom/movable/screen/alert/status_effect/buff/familiar/burdened_coil
	name = "Burdened Coil"
	desc = "You feel grounded and steady, as if strength coils beneath your skin."

/mob/living/simple_animal/pet/familiar/starfield_crow
	name = "Starfield Crow"
	desc = "Its glossy feathers shimmer with shifting constellations, eyes gleaming with uncanny awareness even in the darkest shadows."
	summoning_emote = "A rift in the air reveals a fragment of the starry void, from which a sleek crow with feathers like the night sky takes flight."
	buff_given = /datum/status_effect/buff/familiar/starseam

	icon = 'icons/roguetown/mob/monster/crow.dmi'
	icon_state = "crow_flying"
	icon_living = "crow_flying"
	icon_dead = "crow1"

	base_intents = list(/datum/intent/unarmed/help)
	harm_intent_damage = 0
	melee_damage_lower = 0
	melee_damage_upper = 0
	remains_type = /obj/effect/decal/remains/crow

	speak = list("Kraa.", "Caw.", "Krrrk.")
	speak_emote = list("caws quietly", "croaks")
	emote_hear = list("lets out a knowing caw.", "chirps like stars ticking.")
	emote_see = list("flickers through constellations.", "tilts its head and vanishes.")

/datum/status_effect/buff/familiar/starseam
	id = "starseam"
	effectedstats = list("perception" = 1, "luck" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/starseam

/atom/movable/screen/alert/status_effect/buff/familiar/starseam
	name = "Starseam"
	desc = "You feel nudged by distant patterns. The world flows more legibly."

/mob/living/simple_animal/pet/familiar/emberdrake
	name = "Emberdrake"
	desc = "Tiny and warm to the touch, this drake's wingbeats stir old memories. Runes flicker behind it like afterimages."
	summoning_emote = "A hush falls as glowing ash collects into a fluttering emberdrake."
	buff_given = /datum/status_effect/buff/familiar/steady_spark

	speak = list("Ffff.", "Rrrhh.", "Chhhh.")
	speak_emote = list("crackles", "speaks warmly")
	emote_hear = list("rumbles like a hearth.", "flickers with flame.")
	emote_see = list("glows briefly brighter.", "leaves a brief heat haze.")

/datum/status_effect/buff/familiar/steady_spark
	id = "steady_spark"
	effectedstats = list("intelligence" = 1, "constitution" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/steady_spark

/atom/movable/screen/alert/status_effect/buff/familiar/steady_spark
	name = "Steady Spark"
	desc = "Your thoughts don't burn, they smolder. Clear, slow, and lasting."

/mob/living/simple_animal/pet/familiar/ripplefox
	name = "Ripplefox"
	desc = "It flickers when not directly observed. Leaves no tracks. You're not always sure it's still nearby."
	summoning_emote = "A ripple in the air becomes a sleek fox, its fur twitching between shades of color as it pads forth."
	buff_given = /datum/status_effect/buff/familiar/subtle_slip

	speak = list("Yip!", "Hrrnk.", "Tchk-tchk.")
	speak_emote = list("whispers fast", "speaks quickly")
	emote_hear = list("lets out a playful yip.", "laughs like water in motion.")
	emote_see = list("blurs like a ripple.", "isn't where it was a second ago.")

/datum/status_effect/buff/familiar/subtle_slip
	id = "subtle_slip"
	effectedstats = list("speed" = 1, "luck" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/subtle_slip

/atom/movable/screen/alert/status_effect/buff/familiar/subtle_slip
	name = "Subtle Slip"
	desc = "Things seem a bit looser around you, a gap, a chance, a beat ahead."

/mob/living/simple_animal/pet/familiar/whisper_stoat
	name = "Whisper Stoat"
	desc = "Its gaze is too knowing. It tilts its head as if listening to something inside your skull."
	summoning_emote = "A thought twists into form, a tiny stoat slinks into view."
	buff_given = /datum/status_effect/buff/familiar/noticed_thought

	speak = list("Tchhh.", "Hmm.", "Skkk.")
	speak_emote = list("mutters", "speaks softly")
	emote_hear = list("murmurs in your direction.", "makes a sound you forget instantly.")
	emote_see = list("wraps around a shadow.", "slips behind a thought.")

/datum/status_effect/buff/familiar/noticed_thought
	id = "noticed_thought"
	effectedstats = list("perception" = 1, "intelligence" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/noticed_thought

/atom/movable/screen/alert/status_effect/buff/familiar/noticed_thought
	name = "Noticed Thought"
	desc = "Everything makes just a bit more sense. You catch patterns more quickly."

/mob/living/simple_animal/pet/familiar/thornback_turtle
	name = "Thornback Turtle"
	desc = "It barely moves, but seems unshakable. Vines twist gently around its limbs."
	summoning_emote = "The ground gives a slow rumble. A turtle with a bark-like shell emerges from the soil."
	buff_given = /datum/status_effect/buff/familiar/worn_stone
	
	speak = list("Hrmm.", "Grunk.", "Mmm.")
	speak_emote = list("rumbles", "speaks slowly")
	emote_hear = list("grunts like shifting boulders.", "sighs like old wood.")
	emote_see = list("retracts slightly into its shell.", "blinks slowly.")


/datum/status_effect/buff/familiar/worn_stone
	id = "worn_stone"
	effectedstats = list("strength" = 1, "constitution" = 1)
	alert_type = /atom/movable/screen/alert/status_effect/buff/familiar/worn_stone

/atom/movable/screen/alert/status_effect/buff/familiar/worn_stone
	name = "Worn Stone"
	desc = "Nothing feels urgent. You can take your time... and take a hit."
