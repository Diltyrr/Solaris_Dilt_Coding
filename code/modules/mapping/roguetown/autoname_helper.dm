/obj/effect/mapping_helpers/autoname
	layer = WALL_OBJ_LAYER
	icon_state = "autoname_helper"

/obj/effect/mapping_helpers/autoname/Initialize()
	. = ..()
	var/obj/structure/mineral_door/our_door = locate(/obj/structure/mineral_door) in loc
	if(!our_door)
		log_mapping("[src] at [AREACOORD(src)] tried to name a door, but no door is present!")
		return
	if(our_door.name != initial(our_door.name)) // Mapper fucked up
		log_mapping("[src] at [AREACOORD(src)] tried to name a door, but the door was already named!")
		return
	our_door.name = get_area_name(src, TRUE)
