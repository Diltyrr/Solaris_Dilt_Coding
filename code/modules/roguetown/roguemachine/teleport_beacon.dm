/obj/structure/roguemachine/teleport_beacon
	name = "\improper Kasmidian beacon"
	desc = "A five meter tall spire with a glowing, floating prism in the middle, rotating clock-wise in irregular, slow intervals. <br>\
	Their existence and origins are speculated upon; yet, the followers of Kasmidian are evident to be capable of procuring more of them."
	icon = 'icons/obj/machines/teleport_beacon.dmi'
	icon_state = "aetheryte_town"
	anchored = TRUE
	density = TRUE
	pixel_x = -19
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	var/list/granted_list = list()
	var/custom_name

/obj/structure/roguemachine/teleport_beacon/Initialize()
	. = ..()
	name = custom_name ? "[custom_name] Kasmidian beacon" : "[get_area(get_turf(src))] Kasmidian beacon"
	SSroguemachine.teleport_beacons += src

/obj/structure/roguemachine/teleport_beacon/attack_hand(mob/living/user)
	. = ..()
	var/list/permitted_beacons = list()

	if(!ishuman(user))
		return

	if(!(user.real_name in src.granted_list))
		to_chat(user, span_notice("Your hand touches the beacon - ripples spreading underneath its smooth surface."))
		to_chat(user, span_boldnotice("You can now use it for fast travel!"))
		src.granted_list += user.real_name
		return

	for(var/obj/structure/roguemachine/teleport_beacon/beacon_choice in SSroguemachine.teleport_beacons)
		if(user.real_name in beacon_choice.granted_list)
			permitted_beacons += beacon_choice

	var/teleport_choice = input(user, "Which imprinted beacon would you travel to?", "Teleport Beacon Choice") as null|anything in permitted_beacons

	if(!teleport_choice || teleport_choice == src)
		return

	if(!do_after(user, 10 SECONDS, target = src))
		to_chat(user, span_notice("You decide against going through [src]."))
		return

	to_chat(user, span_notice("Your vision shifts and brightens - and suddenly, you're standing by [teleport_choice]!"))
	user.forceMove(get_teleport_turf(get_turf(teleport_choice), 3))
	do_sparks(3, TRUE, get_turf(user))
	user.flash_act(1, 1, 1, 1)
	playsound(user, 'sound/misc/portalactivate.ogg', 100, FALSE, 9)

/obj/structure/roguemachine/teleport_beacon/Destroy(force)
	SSroguemachine.teleport_beacons -= src
	return ..()

/obj/structure/roguemachine/teleport_beacon/wilderness
	icon_state = "aetheryte_outside"

/obj/structure/roguemachine/teleport_beacon/lava
	icon_state = "aetheryte_lava"

/obj/structure/roguemachine/teleport_beacon/underdark
	icon_state = "aetheryte_underdark"

/obj/structure/roguemachine/teleport_beacon/bandit
	icon_state = "aetheryte_bandit"
