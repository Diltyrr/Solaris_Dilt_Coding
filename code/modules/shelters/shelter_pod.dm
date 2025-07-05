// Shelter pods
/obj/item/shelter_pod
	name = "shelter acorn"
	desc = "A magical acorn said to provide shelter to those that know how to cater to it."
	icon = 'icons/obj/hydroponics/seeds.dmi'
	icon_state = "shelter_acorn_medium"
	w_class = WEIGHT_CLASS_TINY
	/// The id we use to fetch the template datum
	var/template_id = "shelter_tree_medium"
	/// The template datum we use to load the shelter
	var/datum/map_template/shelter/template
	/// If true, this pod is active and will deploy the area if conditions are met.
	var/used = FALSE
	/// Will this pod yeet mobs back once the area is deployed?
	var/yeet_back = TRUE
	/// The deployment action displayed as part of the warning message shown when the pod is about to grow.
	var/deployment_action = "takes root and quickly starts to grow"
	/// The icon file to use when the acorn is planted.
	var/icon/planted_icon = 'icons/roguetown/misc/crops.dmi'
	/// The icon_state to use when the acorn is planted.
	var/planted_icon_state = "shelter"
	/// Time it takes for the pod to grow into a shelter, once it's been planted/shaken.
	var/growth_duration = 5 SECONDS
	/// Turfs this acorn can be planted into. If empty, can be planted everywhere and has to be used in-hand
	/// and thrown, just like SS13 bluespace capsules. Turns into a typecache on Initialize().
	var/list/plantable_turfs = list(
		/turf/open/floor/rogue/dirt,
		/turf/open/floor/rogue/grass,
		/turf/open/floor/rogue/grasscold,
		/turf/open/floor/rogue/grassyel,
		/turf/open/floor/rogue/grassred,
	)

/obj/item/shelter_pod/Initialize()
	. = ..()
	if(!LAZYLEN(plantable_turfs))
		return

	plantable_turfs = typecacheof(plantable_turfs)

/obj/item/shelter_pod/Destroy()
	template = null // without this, capsules would be one use. per round.
	. = ..()

/obj/item/shelter_pod/proc/get_template()
	if(template)
		return
	template = SSmapping.map_templates[template_id]
	if(!template)
		WARNING("Shelter template ([template_id]) not found!")
		qdel(src)

/obj/item/shelter_pod/examine(mob/user)
	. = ..()
	get_template()
	. += "[src] should turn into \an [template.name]."
	. += template.description
	. += span_info("It needs to be <b>[LAZYLEN(plantable_turfs) ? "planted" : "shaken, then thrown"]</b> before it can expand.")

/obj/item/shelter_pod/interact(mob/living/user)
	. = ..()
	if(.)
		return .

	//Can't grab when pod is in New() or Initialize() because templates aren't loaded then
	get_template()
	if(used)
		return FALSE

	if(plantable_turfs)
		return plant(user, get_turf(user))

	loc.visible_message(span_warning("[src] [deployment_action]. Stand back!"))
	used = TRUE
	addtimer(CALLBACK(src, PROC_REF(expand), user), growth_duration)

	if(iscarbon(user))
		var/mob/living/carbon/carbon = user
		carbon.throw_mode_on()

	return TRUE

/obj/item/shelter_pod/attack_turf(turf/target_turf, mob/living/user, multiplier)
	if(!plantable_turfs)
		return FALSE
	
	get_template()
	return plant(target_turf, user)

/// Plants the pod into the ground, allowing it to start growing and expand into a full-blown shelter!
/obj/item/shelter_pod/proc/plant(turf/target_turf, mob/planter)
	if(!plantable_turfs[target_turf.type])
		planter?.visible_message(span_warning("[src] cannot be planted on [target_turf], it needs soil to grow!"))
		return FALSE

	forceMove(target_turf)
	loc.visible_message(span_warning("[src] [deployment_action]. Stand back!"))
	used = TRUE
	anchored = TRUE
	icon = planted_icon
	icon_state = planted_icon_state
	update_icon()
	addtimer(CALLBACK(src, PROC_REF(expand), planter), growth_duration)
	return TRUE

/// Uproots the pod, allowing it to be planted once more.
/obj/item/shelter_pod/proc/uproot()
	icon = initial(icon)
	icon_state = initial(icon_state)
	update_icon()
	anchored = FALSE
	used = FALSE

/// Expands the pod into a full shelter, placing the template at the item's location (NOT triggerer's location)
/obj/item/shelter_pod/proc/expand(mob/triggerer)
	if(QDELETED(src))
		return

	if(!used)
		return

	var/turf/deploy_location = get_turf(src)
	var/status = template.check_deploy(deploy_location, src, get_ignore_flags())
	if(status != SHELTER_DEPLOY_ALLOWED)
		fail_feedback(status)
		uproot()
		return

	if(yeet_back)
		yote_nearby(deploy_location)

	template.load(deploy_location, centered = TRUE)
	playsound(src, 'sound/magic/charged.ogg', 100, TRUE)
	new /obj/effect/particle_effect/smoke/transparent/quick(get_turf(src))
	qdel(src)

/// Returns a bitfield used to ignore some checks in template.check_deploy()
/obj/item/shelter_pod/proc/get_ignore_flags()
	return NONE

///Returns a message including the reason why it couldn't be deployed
/obj/item/shelter_pod/proc/fail_feedback(status)
	switch(status)
		if(SHELTER_DEPLOY_BAD_AREA)
			loc.visible_message(span_warning("[src] will not function in this area."))
		if(SHELTER_DEPLOY_BAD_TURFS, SHELTER_DEPLOY_ANCHORED_OBJECTS, SHELTER_DEPLOY_OUTSIDE_MAP, SHELTER_DEPLOY_BANNED_OBJECTS)
			loc.visible_message(span_warning("[src] doesn't have room to deploy! You need to clear a [template.width]x[template.height]x[template.z_level_count] area!"))

/// Throws any mobs near the deployed location away from the item / shelter
/// Does some math to make closer mobs get thrown further
/obj/item/shelter_pod/proc/yote_nearby(turf/deploy_location)
	var/width = template.width
	var/height = template.height
	var/base_x_throw_distance = ceil(width / 2)
	var/base_y_throw_distance = ceil(height / 2)
	for(var/mob/living/did_not_stand_back in range(loc, "[width]x[height]"))
		var/dir_to_center = get_dir(deploy_location, did_not_stand_back) || pick(GLOB.alldirs)
		// Aiming to throw the target just enough to get them out of the range of the shelter
		// IE: Stronger if they're closer, weaker if they're further away
		var/throw_dist = 0
		var/x_component = abs(did_not_stand_back.x - deploy_location.x)
		var/y_component = abs(did_not_stand_back.y - deploy_location.y)
		if(ISDIAGONALDIR(dir_to_center))
			throw_dist = ceil(sqrt(base_x_throw_distance ** 2 + base_y_throw_distance ** 2) - (sqrt(x_component ** 2 + y_component ** 2)))
		else if(dir_to_center & (NORTH|SOUTH))
			throw_dist = base_y_throw_distance - y_component + 1
		else if(dir_to_center & (EAST|WEST))
			throw_dist = base_x_throw_distance - x_component + 1

		did_not_stand_back.Paralyze(3 SECONDS)
		did_not_stand_back.Knockdown(6 SECONDS)
		did_not_stand_back.throw_at(
			target = get_edge_target_turf(did_not_stand_back, dir_to_center),
			range = throw_dist,
			speed = 3,
			force = MOVE_FORCE_VERY_STRONG,
		)


/obj/item/shelter_pod/small
	name = "small shelter acorn"
	icon_state = "shelter_acorn_small"
	template_id = "shelter_tree_small"

/obj/item/shelter_pod/large
	name = "large shelter acorn"
	icon_state = "shelter_acorn_large"
	template_id = "shelter_tree_large"

/obj/item/shelter_pod/tall
	name = "tall shelter acorn"
	icon_state = "shelter_acorn_tall"
	template_id = "shelter_tree_tall"
