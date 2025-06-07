/obj/effect/proc_holder/spell/invoked/projectile/firebolt
	name = "Fire Bolt"
	desc = "A blazing bolt of fire leaps from your hand to scorch a target."
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/firebolt
	overlay_state = "fireball_multi"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	recharge_time = 3 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 1
	invocation = "Sear!"
	invocation_type = "shout"
	xp_gain = TRUE
	spell_tier = 2

/obj/projectile/magic/aoe/fireball/firebolt
	name = "Fireball"
	exp_heavy = 0
	exp_light = 0
	exp_flash = 1
	exp_fire = -1
	damage = 20
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'
	aoe_range = 0
