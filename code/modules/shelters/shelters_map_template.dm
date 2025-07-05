/// Map templates used for summoning shelters.
/datum/map_template/shelter
	has_ceiling = TRUE
	ceiling_turf = /turf/open/floor/rogue/rooftop
	ceiling_baseturfs = list(/turf/open/transparent/openspace)
	/// The description of the shelter, shown when examining the shelter pod.
	var/description
	/// If turf in the affected turfs is in this list, the shelter cannot be deployed.
	/// This list gets automatically converted into a typecache when this datum is initialized.
	var/list/blacklisted_turfs = list(
		/turf/closed,
		/turf/open/floor/rogue/cobblerock,
		/turf/open/floor/rogue/dirt/road,
		/turf/open/water/swamp/deep,
	)
	/// Areas where the pod cannot be deployed.
	/// This list gets automatically converted into a typecache when this datum is initialized.
	var/list/banned_areas = list(/area/provincial/indoors)
	/// Areas where the pod CAN be deployed, so if this is populated, it will require the area to NOT
	/// be in `banned_areas` AND to be in `whitelisted_areas` in order for the pod to grow.
	/// This list gets automatically converted into a typecache when this datum is initialized.
	var/list/whitelisted_areas = list(/area/provincial/outdoors/forest, /area/provincial/outdoors/bog)
	/// If any object in this list is found in the affected turfs, the shelter cannot deploy.
	/// This list gets automatically converted into a typecache when this datum is initialized.
	var/list/banned_objects = list(
		/obj/structure/flora/newtree,
		/obj/structure/flora/newbranch,
		/obj/structure/flora/newleaf,
		/obj/structure/flora/roguetree,
	)
	/// If any objects in this list is found in the affected turfs, they will get deleted when
	/// the shelter deploys. Contents of banned_objects get removed from this list automatically.
	/// This list gets automatically converted into a typecache when this datum is initialized.
	var/list/replaceable_objects = list(
		/obj/structure/flora/roguegrass,
		/obj/structure/flora/rogueflora,
		/obj/item/natural/rock,
		/obj/structure/glowshroom,
	)


/datum/map_template/shelter/New()
	. = ..()
	LAZYINITLIST(blacklisted_turfs)
	blacklisted_turfs = typecacheof(blacklisted_turfs)
	LAZYINITLIST(banned_areas)
	banned_areas = typecacheof(banned_areas)
	LAZYINITLIST(whitelisted_areas)
	whitelisted_areas = typecacheof(whitelisted_areas)
	LAZYINITLIST(banned_objects)
	banned_objects = typecacheof(banned_objects)
	LAZYINITLIST(replaceable_objects)
	replaceable_objects = typecacheof(replaceable_objects)
	replaceable_objects -= banned_objects

/**
 * This proc checks to see if the shelter can deploy at the desired location or not. It will also 
 */
/datum/map_template/shelter/proc/check_deploy(turf/deploy_location, obj/item/shelter_pod/pod, ignore_flags = NONE)
	var/affected = get_affected_turfs(deploy_location, centered=TRUE)
	var/use_area_whitelist = LAZYLEN(whitelisted_areas)
	var/list/replaceables = list()
	for(var/turf/turf in affected)
		var/area/area = get_area(turf)
		if(is_type_in_typecache(area, banned_areas) && !(use_area_whitelist && !is_type_in_typecache(area, whitelisted_areas)))
			return SHELTER_DEPLOY_BAD_AREA

		if(is_type_in_typecache(turf, blacklisted_turfs))
			return SHELTER_DEPLOY_BAD_TURFS

		for(var/obj/object in turf)
			if(!(ignore_flags & CAPSULE_IGNORE_ANCHORED_OBJECTS) && object.density && object.anchored)
				return SHELTER_DEPLOY_ANCHORED_OBJECTS
			if(!(ignore_flags & CAPSULE_IGNORE_BANNED_OBJECTS) && is_type_in_typecache(object, banned_objects))
				return SHELTER_DEPLOY_BANNED_OBJECTS
			if(is_type_in_typecache(object, replaceable_objects))
				replaceables += object

	// Check if the shelter sticks out of map borders
	var/shelter_origin_x = deploy_location.x - round(width/2)
	if(shelter_origin_x <= 1 || shelter_origin_x+width > world.maxx)
		return SHELTER_DEPLOY_OUTSIDE_MAP

	var/shelter_origin_y = deploy_location.y - round(height/2)
	if(shelter_origin_y <= 1 || shelter_origin_y+height > world.maxy)
		return SHELTER_DEPLOY_OUTSIDE_MAP
	
	var/shelter_origin_z = deploy_location.z
	if(shelter_origin_z < 1 || (shelter_origin_z + z_level_count - 1) > world.maxz)
		return SHELTER_DEPLOY_OUTSIDE_MAP

	// Handle removing all of the replaceables. This should be doable here because the only thing that
	// should come after this proc once it gets here is that the shelter gets spawned in.
	for(var/obj/to_destroy as anything in replaceables)
		qdel(to_destroy)

	return SHELTER_DEPLOY_ALLOWED


/datum/map_template/shelter/tree
	name = "shelter tree"
	id = "shelter_tree_medium"
	description = "A magical yet homely shelter, with a distinct natural feel."
	ceiling_turf = /turf/open/floor/rogue/leaves
	mappath = "_maps/templates/shelter_tree_medium.dmm"

/datum/map_template/shelter/tree/small
	name = "small shelter tree"
	id = "shelter_tree_small"
	description = "A magical yet homely shelter, with a distinct natural feel. You got a feeling this one won't be so big."
	mappath = "_maps/templates/shelter_tree_small.dmm"

/datum/map_template/shelter/tree/large
	name = "large shelter tree"
	id = "shelter_tree_large"
	description = "A magical yet homely shelter, with a distinct natural feel. You got a feeling this one will be rather large."
	mappath = "_maps/templates/shelter_tree_large.dmm"
	z_level_count = 2

/datum/map_template/shelter/tree/tall
	name = "tall shelter tree"
	id = "shelter_tree_tall"
	description = "A magical yet homely shelter, with a distinct natural feel. You got a feeling this one will be rather big and tall."
	mappath = "_maps/templates/shelter_tree_tall.dmm"
	z_level_count = 2
