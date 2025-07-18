GLOBAL_DATUM_INIT(openspace_backdrop_one_for_all, /atom/movable/openspace_backdrop, new)

/atom/movable/openspace_backdrop
	name			= "openspace_backdrop"

	anchored		= TRUE

	icon            = 'icons/turf/floors.dmi'
	icon_state      = "grey"
	plane           = OPENSPACE_BACKDROP_PLANE
	mouse_opacity 	= MOUSE_OPACITY_TRANSPARENT
	layer           = SPLASHSCREEN_LAYER
	//I don't know why the others are aligned but I shall do the same.
	vis_flags		= VIS_INHERIT_ID

/atom/movable/openspace_backdrop/Initialize()
	. = ..()
//	filters += filter(type = "blur", size = 3)

/turf/open/transparent/openspace
	name = "open space"
	desc = "My eyes can see far down below."
	icon_state = "openspace"
	baseturfs = /turf/open/transparent/openspace
	CanAtmosPassVertical = ATMOS_PASS_YES
//	appearance_flags = KEEP_TOGETHER
	//mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/can_cover_up = TRUE
	var/can_build_on = TRUE
	dynamic_lighting = 1
	canSmoothWith = list(/turf/closed/mineral,/turf/closed/wall/mineral/rogue, /turf/open/floor/rogue)
	smooth = SMOOTH_MORE
	neighborlay_override = "staticedge"

/turf/open/transparent/openspace/cardinal_smooth(adjacencies)
	roguesmooth(adjacencies)

/turf/open/transparent/openspace/roguesmooth(adjacencies)
	var/list/Yeah = ..()
	for(var/O in Yeah)
		var/mutable_appearance/M = mutable_appearance(icon, O)
		M.layer = SPLASHSCREEN_LAYER + 0.01
		M.plane = OPENSPACE_BACKDROP_PLANE + 0.01
		add_overlay(M)

/turf/open/transparent/openspace/airless

/// This is here just for some map_template stuff, so that ceilings don't generate inside.
/turf/open/transparent/openspace/inside

/turf/open/transparent/openspace/debug/update_multiz()
	..()
	return TRUE

///No bottom level for openspace.
/turf/open/transparent/openspace/show_bottom_level()
	return FALSE

/turf/open/transparent/openspace/Initialize() // handle plane and layer here so that they don't cover other obs/turfs in Dream Maker
	. = ..()
	dynamic_lighting = 1
	vis_contents += GLOB.openspace_backdrop_one_for_all //Special grey square for projecting backdrop darkness filter on it.
	RegisterSignal(src, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON, PROC_REF(on_atom_created))

/turf/open/transparent/openspace/ChangeTurf(path, list/new_baseturfs, flags)
	UnregisterSignal(src, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON)
	return ..()

/**
 * Drops movables spawned on this turf after they are successfully initialized.
 * so that spawned movables that should fall to gravity, will fall.
 */
/turf/open/transparent/openspace/proc/on_atom_created(datum/source, atom/created_atom)
	SIGNAL_HANDLER
	if(ismovable(created_atom))
		zfall_if_on_turf(created_atom)

/turf/open/transparent/openspace/proc/zfall_if_on_turf(atom/movable/movable)
	if(QDELETED(movable) || movable.loc != src)
		return
	zFall(movable)


/turf/open/transparent/openspace/zAirIn()
	return TRUE

/turf/open/transparent/openspace/zAirOut()
	return TRUE

/turf/open/transparent/openspace/zPassIn(atom/movable/A, direction, turf/source)
	if(direction == DOWN)
		for(var/obj/O in contents)
			if(O.obj_flags & BLOCK_Z_IN_DOWN)
				return FALSE
		return TRUE
	if(direction == UP)
		for(var/obj/O in contents)
			if(O.obj_flags & BLOCK_Z_IN_UP)
				return FALSE
		return TRUE
	return FALSE

/turf/open/transparent/openspace/zPassOut(atom/movable/A, direction, turf/destination)
	if(A.anchored)
		return FALSE
	if(HAS_TRAIT(A, TRAIT_I_AM_INVISIBLE_ON_A_BOAT))
		return FALSE
	if(direction == DOWN)
		testing("dir=down")
		for(var/obj/O in contents)
			if(O.obj_flags & BLOCK_Z_OUT_DOWN)
				testing("noout")
				return FALSE
		return TRUE
	if(direction == UP)
		for(var/obj/O in contents)
			if(O.obj_flags & BLOCK_Z_OUT_UP)
				return FALSE
		return TRUE
	return FALSE

/turf/open/transparent/openspace/can_traverse_safely(atom/movable/traveler)
	var/turf/destination = GET_TURF_BELOW(src)
	if(!destination)
		return TRUE // this shouldn't happen, but if it does we can't fall
	if(!traveler.can_zTravel(destination, DOWN, src)) // something is blocking their fall!
		return TRUE
	if(!traveler.can_zFall(src, DOWN, destination)) // they can't fall!
		return TRUE
	return FALSE

/turf/open/transparent/openspace/proc/CanCoverUp()
	return can_cover_up

/turf/open/transparent/openspace/proc/CanBuildHere()
	return can_build_on

/turf/open/transparent/openspace/attack_paw(mob/user)
	return attack_hand(user)

/turf/open/transparent/openspace/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(L.stat != CONSCIOUS)
			return
		var/turf/target = get_step_multiz(src, DOWN)
		if(!target)
			to_chat(user, span_warning("I can't climb there."))
			return
		if(!user.can_zTravel(target, DOWN, src))
			to_chat(user, span_warning("I can't climb here."))
			return
		if(user.m_intent != MOVE_INTENT_SNEAK)
			playsound(user, 'sound/foley/climb.ogg', 100, TRUE)
		user.visible_message(span_warning("[user] starts to climb down."), span_warning("I start to climb down."))
		if(do_after(L, (HAS_TRAIT(L, TRAIT_WOODWALKER) ? 15 : 30), target = src))
			if(user.m_intent != MOVE_INTENT_SNEAK)
				playsound(user, 'sound/foley/climb.ogg', 100, TRUE)
			var/pulling = user.pulling
			if(ismob(pulling))
				user.pulling.forceMove(target)
			user.forceMove(target)
			user.start_pulling(pulling,supress_message = TRUE)

/turf/open/transparent/openspace/attack_ghost(mob/dead/observer/user)
	var/turf/target = get_step_multiz(src, DOWN)
	if(!user.Adjacent(src))
		return
	if(!target)
		to_chat(user, span_warning("I can't go there."))
		return
	user.forceMove(target)
	to_chat(user, span_warning("I glide down."))
	. = ..()

/turf/open/transparent/openspace/attackby(obj/item/C, mob/user, params)
	..()
	if(!CanBuildHere())
		return

/turf/open/transparent/openspace/bullet_act(obj/projectile/P)
	if(!P.arcshot)
		return ..()
	var/turf/target = get_step_multiz(src, DOWN)
	if(target)
		testing("canztrav")
//		if(can_zFall(P, 2, target))
//			testing("canztrue")
//			P.zfalling = TRUE
		P.forceMove(target)
//			P.zfalling = FALSE
		P.original = target
		P.process_hit(target, P.select_target(target))
		//bump
		return BULLET_ACT_TURF
