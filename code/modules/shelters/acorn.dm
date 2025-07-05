/obj/item/acorn
	name = "acorn"
	desc = "Squirrels and druids both love these nearly as much!"
	icon = 'icons/obj/hydroponics/seeds.dmi'
	icon_state = "acorn_medium"
	w_class = WEIGHT_CLASS_TINY
	/// Which type of shelter acorn does this acorn turn into?
	var/shelter_acorn_type = /obj/item/shelter_pod

/// This proc converts this acorn into a magical shelter acorn, if possible, and
/// puts it in the user's hands (if possible). Returns the new acorn on success, null otherwise.
/obj/item/acorn/proc/convert_to_shelter_acorn(mob/user)
	if(!shelter_acorn_type)
		return null
	
	forceMove(get_turf(src))
	var/obj/item/shelter_pod/shelter_acorn = new shelter_acorn_type()
	user.put_in_hands(shelter_acorn)
	qdel(src)
	return shelter_acorn

/obj/item/acorn/small
	name = "small acorn"
	icon_state = "acorn_small"
	shelter_acorn_type = /obj/item/shelter_pod/small

/obj/item/acorn/large
	name = "large acorn"
	icon_state = "acorn_large"
	shelter_acorn_type = /obj/item/shelter_pod/large

/obj/item/acorn/tall
	name = "tall acorn"
	icon_state = "acorn_tall"
	shelter_acorn_type = /obj/item/shelter_pod/tall
