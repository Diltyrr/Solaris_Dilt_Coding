/obj/effect/proc_holder/spell/aoe_turf/conjure/Wolf
	name = "Summon Wolf"
	desc = ""
	school = "conjuration"
	recharge_time = 1200
	clothes_req = FALSE
	invocation = "Vocare Lupum!"
	invocation_type = "shout"
	overlay_state = "wolf_head"
	range = 1
	cost = 1
	xp_gain = TRUE
	spell_tier = 2

	summon_type = list(/mob/living/simple_animal/hostile/retaliate/rogue/wolf/familiar )
	cast_sound = 'sound/blank.ogg'

/mob/living/simple_animal/hostile/retaliate/rogue/wolf/familiar
	name = "Wolf Familiar"
	faction = list("neutral", "Station") //until i find a way to not make it suck.
