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

	var/mob/living/fam
	var/mob/master

/obj/effect/proc_holder/spell/self/findfamiliar/cast(mob/user = usr)
	..()
	var/familiars = list(
		"Bat" = /mob/living/simple_animal/hostile/retaliate/bat/familiar,
		"Cat" = /mob/living/simple_animal/pet/cat,
		"Chicken" = /mob/living/simple_animal/hostile/retaliate/rogue/chicken,
		"Crow" = /mob/living/simple_animal/hostile/retaliate/bat/crow,
		"Dog" = /mob/living/simple_animal/pet/dog,
		"Frog" = /mob/living/simple_animal/hostile/retaliate/frog,
		"Fox" = /mob/living/simple_animal/pet/fox,
		"Lizard" = /mob/living/simple_animal/hostile/lizard,
		"Mouse" = /mob/living/simple_animal/mouse,
		"Mudcrab" = /mob/living/simple_animal/hostile/retaliate/rogue/mudcrab,
		"Rat" = /obj/item/reagent_containers/food/snacks/smallrat,
		"Snake" = /mob/living/simple_animal/hostile/retaliate/poison/snake,
	)
	var/familiarchoice = input("Choose your familiar", "Available familiars") as anything in familiars
	var/familiar_type = familiars[familiarchoice]
	to_chat(user, span_notice("Trying to find familiar..."))
	var/list/L = pollGhostCandidates("Do you want to play as [span_notice("[span_danger("[user.real_name]'s")] [familiarchoice]")]?", ROLE_SENTIENCE, null, FALSE, 100, POLL_IGNORE_SENTIENCE_POTION)

	if(LAZYLEN(L))
		master = user
		var/mob/chosen_one =  pick(L)
		fam = new familiar_type(user.loc)
		fam.key = chosen_one.key
		to_chat(user, span_notice("Your familiar appears..."))
		chosen_one.mind.transfer_to(fam)
		fam.fully_replace_character_name(null, "[user]'s familiar")
		fam.grant_all_languages(omnitongue=TRUE)
		//user.mind.RemoveSpell(/obj/effect/proc_holder/spell/self/findfamiliar)  Until we find a way to bring the spell back, there'll be a cooldown of 1 hour instead
	else
		to_chat(user, span_notice("You could not find a familiar..."))
		revert_cast()
