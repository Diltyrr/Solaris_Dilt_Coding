/obj/effect/proc_holder/spell/self/cloakofflies
	name = "cloak of flies"
	desc = "Surrounds you with a buzzing cloud of flies that harms nearby foes."
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	recharge_time = 2 SECONDS

	warnie = "spellwarning"

	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy

	xp_gain = FALSE
	miracle = FALSE

	invocation = "Dún mé le créidim!"
	invocation_type = "shout"
	var/activated = FALSE
	var/rot_type = /datum/component/rot/warlock
	var/static/mutable_appearance/flies = mutable_appearance('icons/roguetown/mob/rotten.dmi', "rotten")

/obj/effect/proc_holder/spell/self/cloakofflies/cast(mob/user = usr)
	..()

	if(activated)
		qdel(user.GetComponent(/datum/component/rot/warlock))
		activated = FALSE
		user.cut_overlay(flies)
		user.update_vision_cone()
		user.visible_message("<span class='info'>The flies surrounding [user] go away.</span>", "<span class='notice'>My cloak of flies dissipates.</span>")
	else
		user.AddComponent(/datum/component/rot/warlock)
		activated = TRUE
		user.add_overlay(flies)
		user.update_vision_cone()
		user.visible_message("<span class='info'>[user] is surrounded in a cloud of flies.</span>", "<span class='notice'>My cloak of flies surrounds me.</span>")

/datum/component/rot/warlock
	soundloop = /datum/looping_sound/fliesloop/quiet

/datum/component/rot/warlock/process()
	. = ..()
	var/mob/living/living_mob = parent
	if(!living_mob) return

	if(soundloop && soundloop.stopped)
		soundloop.start()

	for(var/mob/living/mob_target in view(1, living_mob))
		if(mob_target == living_mob) continue
		if(istype(mob_target, /mob/living/carbon)) // Optional: skip bots or spirits
			if(!mob_target.health <= 0) // Skip dead/unconscious
				mob_target.adjustBruteLoss(2 + rand(0, 2)) // 2–4 brute
				if(prob(25)) mob_target.visible_message(
					span_danger("Flies swarm around [mob_target], biting and stinging!"),
					span_notice("The flies bite and sting at my skin!")
				)

/datum/looping_sound/fliesloop/quiet
	mid_sounds = list('sound/misc/fliesloop.ogg')
	mid_length = 60
	volume = 25
	extra_range = 0
