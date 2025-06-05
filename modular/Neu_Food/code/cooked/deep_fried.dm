// Split this file into folder and individual food type
/obj/item/reagent_containers/food/snacks/rogue/foodbase/nitzel
	name = "unfinished nitzel"
	desc = "Tenderized meat, awaiting a coating of toastcrumbs and a hot oil bath."
	icon = 'modular/Neu_Food/icons/deep_fried.dmi'
	icon_state = "nitzel_step1"
	process_step = 1

/obj/item/reagent_containers/food/snacks/rogue/foodbase/nitzel/attackby(obj/item/I, mob/living/user, params)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/egg))
		if(process_step != 1)
			return
		to_chat(user, span_notice("Cracking an egg over the nitzel."))
		if(do_after(user, short_cooktime, target = src))
			playsound(get_turf(user), 'modular/Neu_Food/sound/eggbreak.ogg', 100, TRUE, -1)
			name = "nitzel with egg"
			desc = "A nitzel with an egg cracked over it. It awaits toastcrumbs and a hot oil bath."
			icon_state = "nitzel_step2"
			process_step = 2
			update_icon()
			qdel(I)
			return
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/toastcrumbs))
		if(process_step != 2)
			return
		to_chat(user, span_notice("Coating the nitzel with toastcrumbs."))
		if(do_after(user, short_cooktime, target = src))
			name = "nitzel with toastcrumbs"
			desc = "A nitzel coated in toastcrumbs. It awaits a hot oil bath."
			icon_state = "nitzel_step3"
			process_step = 3
			deep_fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/nitzel
			update_icon()
			qdel(I)
			return
	return ..()

/obj/item/reagent_containers/food/snacks/rogue/foodbase/schnitzel
	name = "schnitzel"
	desc = "Tenderized spider meat, awaiting a coating of toastcrumbs and a hot oil bath."
	icon = 'modular/Neu_Food/icons/deep_fried.dmi'
	icon_state = "schnitzel_step1"
	process_step = 1

// copy paste code to shame my ancestors (some1 refactor this)
/obj/item/reagent_containers/food/snacks/rogue/foodbase/schnitzel/attackby(obj/item/I, mob/living/user, params)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/egg))
		if(process_step != 1)
			return
		to_chat(user, span_notice("Cracking an egg over the schnitzel."))
		if(do_after(user, short_cooktime, target = src))
			playsound(get_turf(user), 'modular/Neu_Food/sound/eggbreak.ogg', 100, TRUE, -1)
			name = "schnitzel with egg"
			desc = "A schnitzel with an egg cracked over it. It awaits toastcrumbs and a hot oil bath."
			icon_state = "schnitzel_step2"
			process_step = 2
			update_icon()
			qdel(I)
			return
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/toastcrumbs))
		if(process_step != 2)
			return
		to_chat(user, span_notice("Coating the schnitzel with toastcrumbs."))
		if(do_after(user, short_cooktime, target = src))
			name = "schnitzel with toastcrumbs"
			desc = "A schnitzel coated in toastcrumbs. It awaits a hot oil bath."
			icon_state = "schnitzel_step3"
			process_step = 3
			deep_fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/nitzel/schnitzel
			update_icon()
			qdel(I)
			return
	return ..()

// Squire's delight (deep fried butter)
/obj/item/reagent_containers/food/snacks/rogue/foodbase/squires_delight
	name = "unfinished squire's delight"
	desc = "A butter stick with an egg cracked over it. It awaits toastcrumbs and a hot oil bath."
	icon = 'modular/Neu_Food/icons/deep_fried.dmi'
	icon_state = "squiresdelight_step1"
	process_step = 1

/obj/item/reagent_containers/food/snacks/rogue/foodbase/squires_delight/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/toastcrumbs))
		if(process_step != 1)
			return
		to_chat(user, span_notice("Coating the butter with toastcrumbs."))
		if(do_after(user, short_cooktime, target = src))
			name = "squire's delight with toastcrumbs"
			desc = "A butter stick coated in toastcrumbs. It awaits a hot oil bath."
			icon_state = "squiresdelight_step2"
			process_step = 2
			deep_fried_type = /obj/item/reagent_containers/food/snacks/squiresdelight
			update_icon()
			qdel(I)
			return

/obj/item/reagent_containers/food/snacks/squiresdelight
	name = "squire's delight"
	desc = "A deep-fried butter stick. Beloved by squires, often stolen by knights."
	icon = 'modular/Neu_Food/icons/deep_fried.dmi'
	icon_state = "squiresdelight"
	list_reagents = list(/datum/reagent/consumable/nutriment = BUTTER_NUTRITION * 2)
	foodtype = DAIRY | GRAIN
	bitesize = 6 // Consistent with butter
	faretype = FARE_FINE // Now you can eat butter as a knight...
	tastes = list("crunchy toastcrumbs" = 1, "molten butter" = 1)
	eat_effect = /datum/status_effect/buff/foodbuff
	rotprocess = SHELFLIFE_DECENT

// Cooked results
/obj/item/reagent_containers/food/snacks/rogue/meat/nitzel
	name = "nitzel"
	desc = "A deep-fried nitzel, coated in toastcrumbs and ready to eat."
	icon = 'modular/Neu_Food/icons/deep_fried.dmi'
	icon_state = "nitzel"
	faretype = FARE_LAVISH
	foodtype = MEAT | GRAIN
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_CHUNKY * 2)
	bitesize = 5 // If you go through all of the efforts to make this it should have big portion
	tastes = list("crunchy toastcrumbs" = 1, "tender pork" = 1)
	cooked_type = null
	eat_effect = /datum/status_effect/buff/foodbuff
	rotprocess = SHELFLIFE_DECENT

// Doesn't matter it was spider meat if you go through the effort it should be as good
/obj/item/reagent_containers/food/snacks/rogue/meat/nitzel/schnitzel
	name = "schnitzel"
	desc = "A deep-fried schnitzel, coated in toastcrumbs and ready to eat."
	icon_state = "schnitzel"
	tastes = list("crunchy toastcrumbs" = 1, "tender spidermeat" = 1)
