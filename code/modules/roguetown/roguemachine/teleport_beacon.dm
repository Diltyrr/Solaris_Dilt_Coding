/obj/structure/roguemachine/teleport_beacon
	name = "\improper Kasmidian beacon"
	desc = "A five meter tall spire with a glowing, floating prism in the middle, rotating clock-wise in irregular, slow intervals. <br>\
	Their existence and origins are speculated upon; yet, the followers of Kasmidian are evident to be capable of procuring more of them."
	icon = 'icons/obj/machines/teleport_beacon.dmi'
	anchored = TRUE
	density = TRUE
	pixel_x = -19
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	///List of people connected to this particular beacon.
	var/list/granted_list = list()
	///Determines the amount of time you have to whimsically stay still by this beacon to teleport.
	var/spool_time = 5 SECONDS
	///Custom name for this particular beacon.
	var/custom_name
	///The amount of coins it takes to teleport from this beacon.
	var/departure_price = 0
	///The amount of coins it take to teleport to this beacon.
	var/arrival_price = 0
	///Boolean to identify outlaw-permitted beacons. FALSE disallows outlaw use.
	var/fringe = TRUE
	/// Difficulty for beacon connection quests.
	var/quest_difficulty = "Unset"
	///List of lines to spout when an outlaw's spotted.
	var/criminal_lines = list(
	"Criminal! Criminal!",
	"What are you? A mugger? Go mug someone else!",
	"Shoo away, bandit scum!",
	"Get back, vile creature!",
	"I'll call the guards on you!",
	)

/obj/structure/roguemachine/teleport_beacon/Initialize()
	. = ..()
	name = custom_name ? "[custom_name] Kasmidian beacon" : "[get_area(get_turf(src))] Kasmidian beacon"
	SSroguemachine.teleport_beacons += src

/obj/structure/roguemachine/teleport_beacon/examine(mob/user)
	. = ..()
	if(fringe)
		. += span_notice("This beacon is old and ailing - perhaps some <b>unsavory elements</b> would have an easier time of getting through it.")
	. += span_notice("It costs <b>[departure_price]</b> marks to depart from, and <b>[arrival_price]</b> marks to arrive to this beacon.")

/obj/structure/roguemachine/teleport_beacon/attack_hand(mob/living/user)
	. = ..()
	var/list/permitted_beacons = list()
	var/teleport_turf
	var/final_price

	if(!ishuman(user))
		return
	
	// Check for beacon connection quest completion using recursive search
	if(!(user.real_name in src.granted_list))
		var/list/user_scrolls = find_quest_scrolls(user)
		for(var/obj/item/paper/scroll/quest/scroll in user_scrolls)
			var/datum/quest/Q = scroll.assigned_quest
			if(Q && Q.quest_type == "Beacon" && Q.beacon_connection && !Q.complete)
				if(Q.target_beacon == src || (length(Q.possible_beacons) && (src in Q.possible_beacons)))
					Q.complete = TRUE
					Q.target_beacon = src
					to_chat(user, span_notice("You feel the beacon's energy resonate with your quest scroll!"))
					scroll.update_quest_text()
					playsound(src, 'sound/magic/charged.ogg', 50, TRUE)
					do_sparks(3, TRUE, src)
					break
		
		to_chat(user, span_notice("Your hand touches the beacon - ripples spreading underneath its smooth surface."))
		to_chat(user, span_boldnotice("You can now use it for fast travel!"))
		src.granted_list += user.real_name
		return

	for(var/obj/structure/roguemachine/teleport_beacon/beacon_choice in SSroguemachine.teleport_beacons)
		if(user.real_name in beacon_choice.granted_list)
			permitted_beacons += beacon_choice

	var/obj/structure/roguemachine/teleport_beacon/teleport_choice = input(user, "Which imprinted beacon would you like to travel to?", "Teleport Beacon Choice") as null|anything in permitted_beacons

	if(!teleport_choice || teleport_choice == src)
		return

	if(!HAS_TRAIT(user, TRAIT_OUTLAW))
		final_price = src.departure_price + teleport_choice.arrival_price

		if(HAS_TRAIT(user, TRAIT_NOBLE))
			final_price = round(final_price*0.8)

		var/price_confirmation = input(user, "Going further will cost you a fee of [final_price] marks: [src.departure_price] to depart and [teleport_choice.arrival_price] to arrive[HAS_TRAIT(user, TRAIT_NOBLE) ? ", with a 20% nobility discount included" : ""]. Do you wish to proceed?", "Teleport Beacon Choice") as null|anything in list("Yes", "No")

		if(!price_confirmation || price_confirmation == "No")
			to_chat(user, span_notice("You decide against paying for [src]."))
			return

		if(!(user in SStreasury.bank_accounts))
			say("You have no record or word to your name.")
			return

		if(SStreasury.bank_accounts[user] < final_price)
			say("You are too poor to pay the fee.")
			return

	to_chat(user, span_notice("Spooling the beacon."))
	playsound(src, 'sound/misc/portal_loop.ogg', 100, FALSE, 1)

	if(!do_after(user, spool_time, target = src))
		to_chat(user, span_notice("You decide against going through [src]."))
		return

	if(final_price > 0)
		SStreasury.bank_accounts[user] -= final_price
		SStreasury.treasury_value += final_price
		SStreasury.log_entries += "+[final_price] to treasury (teleportation fees)"
		to_chat(user, span_notice("You have been billed [final_price] marks to teleport."))

	to_chat(user, span_notice("Your vision shifts and brightens - and suddenly, you're standing by [teleport_choice]!"))
	teleport_turf = get_teleport_turf(get_turf(teleport_choice), 3)
	user.forceMove(teleport_turf)
	do_sparks(3, TRUE, get_turf(user))
	do_sparks(3, TRUE, teleport_turf)
	user.flash_act(1, 1, 1, 1)
	playsound(user, 'sound/misc/portalactivate.ogg', 100, FALSE, 9)
	playsound(teleport_turf, 'sound/misc/portalenter.ogg', 100, FALSE, 9)

/obj/structure/roguemachine/teleport_beacon/proc/find_quest_scrolls(atom/container)
	var/list/scrolls = list()
	for(var/obj/item/paper/scroll/quest/Q in container)
		scrolls += Q
	
	// Recursively check contents of containers
	for(var/obj/item/storage/S in container)
		scrolls += find_quest_scrolls(S)
	
	return scrolls

/obj/structure/roguemachine/teleport_beacon/Destroy(force)
	SSroguemachine.teleport_beacons -= src
	return ..()

/obj/structure/roguemachine/teleport_beacon/main //'Main' town beacon, needed to synch every towner role to one.
	icon_state = "aetheryte_town"
	fringe = FALSE

/obj/structure/roguemachine/teleport_beacon/wilderness
	icon_state = "aetheryte_outside"

/obj/structure/roguemachine/teleport_beacon/lava
	icon_state = "aetheryte_lava"

/obj/structure/roguemachine/teleport_beacon/underdark
	icon_state = "aetheryte_underdark"

/obj/structure/roguemachine/teleport_beacon/bandit
	icon_state = "aetheryte_bandit"
