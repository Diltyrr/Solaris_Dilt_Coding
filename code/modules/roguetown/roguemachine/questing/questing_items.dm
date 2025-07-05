/obj/item/paper/scroll/quest
	name = "enchanted quest scroll"
	desc = "A weathered scroll enchanted to list the active quests from the Adventurers' Guild."
	icon = 'code/modules/roguetown/roguemachine/questing/questing.dmi'
	icon_state = "scroll_quest"
	var/base_icon_state = "scroll_quest"
	var/datum/quest/assigned_quest

/obj/item/paper/scroll/quest/Initialize()
	. = ..()
	if(assigned_quest)
		assigned_quest.quest_scroll = src 
	update_quest_text()

/obj/item/paper/scroll/quest/update_icon_state()
	if(open)
		icon_state = info ? "[base_icon_state]_info" : "[base_icon_state]"
	else
		icon_state = "[base_icon_state]_closed"

/obj/item/paper/scroll/quest/examine(mob/user)
	. = ..()
	if(!assigned_quest)
		return
	if(!assigned_quest.quest_receiver_reference)
		. += span_notice("This quest hasn't been claimed yet. Open it to claim it for yourself!")
	else if(assigned_quest.complete)
		. += span_notice("\nThis quest is complete! Return it to the Quest Book to claim your reward.")
		. += span_info("\nPlace it on the marked area next to the book.")
	else
		. += span_notice("\nThis quest is still in progress.")

/obj/item/paper/scroll/quest/attack_self(mob/user)
	. = ..()
	if(.)
		return

	if(!assigned_quest || assigned_quest.quest_receiver_reference)
		return

	assigned_quest.quest_receiver_reference = WEAKREF(user)
	assigned_quest.quest_receiver_name = user.real_name

	if(assigned_quest.quest_type == "Beacon" && assigned_quest.beacon_connection && length(assigned_quest.possible_beacons))
		var/list/valid_beacons = list()
		for(var/obj/structure/roguemachine/teleport_beacon/beacon in assigned_quest.possible_beacons)
			if(!(user.real_name in beacon.granted_list) && beacon != src)
				valid_beacons += beacon

		if(length(valid_beacons))
			var/list/difficulty_beacons = list()
			for(var/obj/structure/roguemachine/teleport_beacon/beacon in valid_beacons)
				if(beacon.quest_difficulty == assigned_quest.quest_difficulty)
					difficulty_beacons += beacon

			assigned_quest.possible_beacons = length(difficulty_beacons) ? difficulty_beacons : valid_beacons
			assigned_quest.target_beacon = pick(assigned_quest.possible_beacons)
		else
			to_chat(user, span_warning("There are no unconnected beacons available for this quest!"))
			return

	to_chat(user, span_notice("You claim this quest for yourself!"))
	update_quest_text()
	return TRUE

/obj/item/paper/scroll/quest/proc/update_quest_text()
	if(!assigned_quest)
		return

	var/scroll_text = "<center>HELP NEEDED</center><br>"
	scroll_text += "<center><b>[assigned_quest.title]</b></center><br><br>"
	scroll_text += "<b>Issued by:</b> [assigned_quest.quest_giver_name ? "Guild Handler [assigned_quest.quest_giver_name]" : "The Adventurer's Guild"].<br>"
	scroll_text += "<b>Issued to:</b> [assigned_quest.quest_receiver_name ? assigned_quest.quest_receiver_name : "whoever it may concern"].<br>"
	scroll_text += "<b>Type:</b> [assigned_quest.quest_type] quest.<br>"
	scroll_text += "<b>Difficulty:</b> [assigned_quest.quest_difficulty].<br><br>"

	switch(assigned_quest.quest_type)
		if("Fetch")
			scroll_text += "<b>Objective:</b> Retrieve [assigned_quest.target_amount] [initial(assigned_quest.target_item_type.name)].<br>"
			scroll_text += "<b>Last Seen Location:</b> Reported sighting in [assigned_quest.target_spawn_area] region.<br>"
		if("Kill", "Miniboss")
			scroll_text += "<b>Objective:</b> Slay [assigned_quest.target_amount] [initial(assigned_quest.target_mob_type.name)].<br>"
			scroll_text += "<b>Last Seen Location:</b> [assigned_quest.target_spawn_area ? "Reported sighting in [assigned_quest.target_spawn_area] region." : "Reported sighting in Sunmarch region."]<br>"
		if("Clear Out")
			scroll_text += "<b>Objective:</b> Eliminate [assigned_quest.target_amount] [initial(assigned_quest.target_mob_type.name)].<br>"
			scroll_text += "<b>Infestation Location:</b> [assigned_quest.target_spawn_area ? "Reported sighting in [assigned_quest.target_spawn_area] region." : "Reported infestations in Sunmarch region."]<br>"
		if("Courier")
			scroll_text += "<b>Objective:</b> Deliver [initial(assigned_quest.target_delivery_item.name)] to [initial(assigned_quest.target_delivery_location.name)].<br>"
			scroll_text += "<b>Delivery Instructions:</b> Package must remain intact and be delivered directly to the recipient.<br>"
			scroll_text += "<b>Destination Description:</b> [initial(assigned_quest.target_delivery_location.brief_descriptor)].<br>"
		if("Beacon")
			if(assigned_quest.target_beacon)
				var/area/beacon_area = get_area(assigned_quest.target_beacon)
				scroll_text += "<b>Objective:</b> Activate the Kasmidian beacon in [beacon_area.name]<br>"
				scroll_text += "<b>Beacon Name:</b> [assigned_quest.target_beacon.name]<br>"
				scroll_text += "<b>Location Description:</b> [beacon_area.desc]<br>"
				scroll_text += "<b>Activation Method:</b> Simply interact with the beacon once found<br>"
	
	scroll_text += "<br><b>Reward:</b> [assigned_quest.reward_amount] marks upon completion<br>"
	
	if(assigned_quest.complete)
		scroll_text += "<br><center><b>QUEST COMPLETE</b></center>"
		scroll_text += "<br><b>Return this scroll to the Quest Book to claim your reward!</b>"
		scroll_text += "<br><i>Place it on the marked area next to the book.</i>"
	else
		scroll_text += "<br><i>The magic in this scroll will update as you progress.</i>"
	
	info = scroll_text

/obj/item/parcel
	name = "parcel wrapping paper"
	desc = "A sturdy piece of paper used to wrap items for secure delivery. The final size of the parcel depends on the size of the original item."
	icon = 'modular/Neu_food/icons/ration.dmi'
	icon_state = "ration_wrapper"
	w_class = WEIGHT_CLASS_TINY
	grid_height = 32
	grid_width = 32
	dropshrink = 0.6
	var/obj/item/contained_item = null
	var/list/allowed_jobs = list()
	var/delivery_area_type

/obj/item/parcel/Initialize(mapload)
	. = ..()
	var/datum/component/quest_object/courier_quest = GetComponent(/datum/component/quest_object)
	if(courier_quest)
		var/datum/quest/quest = courier_quest.quest_ref?.resolve()
		if(quest && quest.quest_type == "Courier" && quest.target_delivery_location)
			delivery_area_type = quest.target_delivery_location
			allowed_jobs = get_area_jobs(delivery_area_type)
			RegisterSignal(courier_quest, COMSIG_PARENT_QDELETING, PROC_REF(on_quest_component_deleted))

/obj/item/parcel/proc/get_area_jobs(area_type)
	var/static/list/area_jobs = list(
		/area/provincial/indoors/town/tavern = list("Guild Handler", "Innkeeper", "Tapster"),
		/area/provincial/indoors/town/church = list("Guild Handler", "Priest", "Acolyte", "Templar", "Churchling"),
		/area/provincial/indoors/town/farm = list("Guild Handler", "Soilson"),
		/area/provincial/indoors/town/blacksmith = list("Guild Handler", "Blacksmith"),
		/area/provincial/indoors/town/shop = list("Guild Handler", "Merchant", "Shophand"),
		/area/provincial/indoors/town/province_keep = list("Guild Handler", "Nobleman", "Hand", "Knight Captain", "Marshal", "Steward", "Clerk", "Head Mage", "Marquis"),
		/area/provincial/indoors/town/mages_university = list("Guild Handler", "Head Mage", "Archivist", "Artificer", "Apothicant Apprentice", "Apprentice Magician"),
		/area/provincial/indoors/town/mages_university/alchemy_lab = list("Guild Handler", "Head Mage", "Archivist", "Artificer", "Apothicant Apprentice", "Apprentice Magician"),
		/area/provincial/indoors/town/steward = list("Guild Handler", "Steward"),
		/area/provincial/indoors/town = list("Guild Handler")
	)
	return area_jobs[area_type] || list("Guild Handler")

/obj/item/parcel/proc/on_quest_component_deleted(datum/source)
	SIGNAL_HANDLER
	return

/obj/item/parcel/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/parcel) || I.w_class > WEIGHT_CLASS_BULKY || contained_item)
		to_chat(user, span_warning("You can't wrap this in [src]."))
		return

	if(do_after(user, 2 SECONDS, target = src))
		user.transferItemToLoc(I, src)
		contained_item = I
		name = "parcel ([I.name])"
		desc = "A securely wrapped parcel containing [I.name]."
		icon_state = I.w_class >= WEIGHT_CLASS_NORMAL ? "ration_large" : "ration_small"
		dropshrink = 1
		update_icon()
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		to_chat(user, span_notice("You wrap [I] in the parcel wrapper."))

/obj/item/parcel/attack_self(mob/user)
	if(!contained_item)
		return

	if(delivery_area_type)
		var/area/quest_area = delivery_area_type
		if(ispath(quest_area, /area) && !(user.job in allowed_jobs))
			to_chat(user, span_warning("This parcel is sealed for delivery to [initial(quest_area.name)] and can only be opened by: [english_list(allowed_jobs)]!"))
			return FALSE

	if(do_after(user, 2 SECONDS, target = src))
		to_chat(user, span_notice("You unwrap [contained_item] from the parcel."))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		user.put_in_hands(contained_item)
		contained_item.update_icon()
		contained_item = null
		qdel(src)

/obj/item/parcel/examine(mob/user)
	. = ..()
	if(!delivery_area_type)
		return

	var/area/delivery_area = delivery_area_type
	if(!ispath(delivery_area, /area))
		return

	. += span_info("This parcel is addressed to [initial(delivery_area.name)].")
	. += (user.job in allowed_jobs) ? \
		span_notice("As [user.job], you're authorized to open this.") : \
		span_warning("It's sealed with an official guild mark - only authorized personnel should open this!")
