/// SOLARIS NOTE: Like pestra, a lot of gameplay still relies on this fucking spell. ough. For that reason it's being left here for now
// T0: Determine the net sunmark value of target

/obj/effect/proc_holder/spell/invoked/appraise
	name = "Appraise"
	overlay_state = "appraise"
	releasedrain = 10
	chargedrain = 0
	chargetime = 0
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 5 SECONDS 
	miracle = TRUE
	devotion_cost = 0 

/obj/effect/proc_holder/spell/invoked/appraise/secular
	name = "Secular Appraise"
	overlay_state = "appraise"
	range = 2
	associated_skill = /datum/skill/misc/reading // idk reading is like Accounting right
	miracle = FALSE
	devotion_cost = 0 //Merchants are not clerics


/obj/effect/proc_holder/spell/invoked/appraise/cast(list/targets, mob/living/user)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/target = targets[1]
		var/sunmarksonperson = get_sunmarks_in_atom(target)
		var/sunmarksinbank = SStreasury.bank_accounts[target]
		var/totalvalue = sunmarksinbank + sunmarksonperson
		to_chat(user, ("<font color='yellow'>[target] has [sunmarksonperson] sunmarks on them, [sunmarksinbank] in their meister, for a total of [totalvalue] sunmarks.</font>"))
