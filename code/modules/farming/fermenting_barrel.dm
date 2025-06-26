/obj/structure/fermenting_barrel
	name = "barrel"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "barrel1"
	density = TRUE
	opacity = FALSE
	anchored = FALSE
	max_integrity = 300
	drag_slowdown = 2
	var/open = FALSE
	var/speed_multiplier = 1 //How fast it distills. Defaults to 100% (1.0). Lower is better.

/obj/structure/fermenting_barrel/Initialize()
	// Bluespace beakers, but without the portability or efficiency in circuits.
	create_reagents(900, DRAINABLE | AMOUNT_VISIBLE | REFILLABLE)
	icon_state = "barrel[rand(1,3)]"
	. = ..()

/obj/structure/fermenting_barrel/Destroy()
	chem_splash(loc, 2, list(reagents))
	qdel(reagents)
	..()

/obj/structure/fermenting_barrel/examine(mob/user)
	. = ..()
//	. += span_notice("It is currently [open?"open, letting you pour liquids in.":"closed, letting you draw liquids."]")

/obj/structure/fermenting_barrel/proc/makeWine(obj/item/reagent_containers/food/snacks/fruit)
	if(fruit.reagents)
		fruit.reagents.remove_reagent(/datum/reagent/consumable/nutriment, fruit.reagents.total_volume)
		fruit.reagents.trans_to(src, fruit.reagents.total_volume)
	if(fruit.distill_reagent)
		reagents.add_reagent(fruit.distill_reagent, fruit.distill_amt)
	qdel(fruit)
	playsound(src, "bubbles", 100, TRUE)
	return TRUE

/obj/structure/fermenting_barrel/attackby(obj/item/I, mob/user, params)
	if(istype(I,/obj/item/reagent_containers/food/snacks/))
		if(try_ferment(I, user))
			return TRUE
	if(istype(I,/obj/item/reagent_containers/powder))
		var/obj/item/reagent_containers/powder/P = I
		P.reagents.trans_to(src, P.reagents.total_volume)
		qdel(P)
		playsound(src, "bubbles", 100, TRUE)
		return TRUE
	if(istype(I,/obj/item/storage/roguebag) && I.contents.len)
		var/obj/item/storage/roguebag/baggie = I
		var/success = try_ferment_roguebag(baggie, user)
		return success
	..()

/obj/structure/fermenting_barrel/proc/try_ferment(obj/item/reagent_containers/food/snacks/grown/fruit, mob/user)
	if(!fruit.can_distill)
		to_chat(user, span_warning("I can't ferment this into anything."))
		return FALSE
	else if(!user.transferItemToLoc(fruit,src))
		to_chat(user, span_warning("[fruit] is stuck to my hand!"))
		return FALSE
	to_chat(user, span_info("I place [fruit] into [src]."))
	addtimer(CALLBACK(src, PROC_REF(makeWine), fruit), rand(1 MINUTES, 3 MINUTES))
	return TRUE

/obj/structure/fermenting_barrel/proc/try_ferment_roguebag(obj/item/storage/roguebag/baggie, mob/user)
	var/success = FALSE
	var/datum/component/storage/STR = baggie.GetComponent(/datum/component/storage)
	if(!STR)
		return FALSE
	for(var/obj/item/reagent_containers/food/snacks/grown/bagged_fruit in baggie.contents)
		if(bagged_fruit.can_distill)
			success = TRUE
			STR.remove_from_storage(bagged_fruit, src)
			addtimer(CALLBACK(src, PROC_REF(makeWine), bagged_fruit), rand(1 MINUTES, 3 MINUTES))
	if(success)
		to_chat(user, span_info("I dump the fermentable contents of [baggie] into [src]."))
		return TRUE
	else
		to_chat(user, span_warning("There's nothing in [baggie] that I can ferment."))
		return FALSE

//obj/structure/fermenting_barrel/attack_hand(mob/user)
//	open = !open
//	if(open)
//		ENABLE_BITFIELD(reagents.flags, DRAINABLE)
//		ENABLE_BITFIELD(reagents.flags, REFILLABLE)
//		to_chat(user, span_notice("I open [src]."))
//	else
//		DISABLE_BITFIELD(reagents.flags, DRAINABLE)
//		DISABLE_BITFIELD(reagents.flags, REFILLABLE)
//		to_chat(user, span_notice("I close [src]."))
//	update_icon()

/obj/structure/fermenting_barrel/update_icon()
	if(open)
		icon_state = "barrel_open"
	else
		icon_state = "barrel"
	if(broken)
		icon_state = "barrel_destroyed"

/obj/structure/fermenting_barrel/random/water
	name = "water barrel"
	icon_state = "pbarrel1"

/obj/structure/fermenting_barrel/random/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water, rand(0,900))

/obj/structure/fermenting_barrel/random/beer/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer, rand(0,900))

/obj/structure/fermenting_barrel/water
	name = "water barrel"
	icon_state = "pbarrel1"

/obj/structure/fermenting_barrel/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water,900)

/obj/structure/fermenting_barrel/beer
	desc = "A barrel containing a generic housebrewed small-beer."

/obj/structure/fermenting_barrel/beer/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer,900)

/obj/item/roguebin/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water,500)
	update_icon()

/obj/item/roguebin/water/gross/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water/gross,500)
	update_icon()

/obj/structure/fermenting_barrel/zagul
	desc = "A barrel marked with a coastal zagul. An extremely cheap lager hailing from a local brewery."

/obj/structure/fermenting_barrel/zagul/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/zagul,900)

/obj/structure/fermenting_barrel/blackgoat
	desc = "A barrel marked with the Black Goat Kriek emblem. A fruit-sour beer brewed with jackberries for a tangy taste."

/obj/structure/fermenting_barrel/blackgoat/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/blackgoat,900)

/obj/structure/fermenting_barrel/hagwoodbitter
	desc = "A barrel marked with the Hagwood Bitters emblem."

/obj/structure/fermenting_barrel/hagwoodbitter/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/hagwoodbitter,900)



/obj/structure/fermenting_barrel/jagt
	desc = "A barrel with a Saigabuck mark. A herbal schnapps, sure to burn out any disease."

/obj/structure/fermenting_barrel/jagt/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/jagdtrunk,900)

/obj/structure/fermenting_barrel/sourwine
	desc = "A barrel that contains an extremely sour wine that is watered down with mineral water."

/obj/structure/fermenting_barrel/sourwine/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/sourwine,900)


/obj/structure/fermenting_barrel/onion
	desc = "A barrel with surprisingly no maker's mark. On the wood is carved the word \"ONI-N\", the 'O' seems to have been scratched out completely. Dubious. On the barrel is a paper glued to it showing an illustration of rats guarding a cellar filled with bottles against a hoard of beggars."

/obj/structure/fermenting_barrel/onion/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/onion,900)

/obj/structure/fermenting_barrel/saigamilk
	desc = "A barrel with a Running Saiga mark. A form of alcohol brewed from the milk of a saiga and salt. Common drink of the nomads living in the steppe."

/obj/structure/fermenting_barrel/saigamilk/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/saigamilk,900)

/obj/structure/fermenting_barrel/kgsunsake
	desc = "A barrel with a Golden Swan mark. A translucient, pale-blue liquid made from rice."

/obj/structure/fermenting_barrel/kgsunsake/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/kgunsake,900)


/obj/structure/fermenting_barrel/whitericewine
	desc = "A barrel with a simple mark. A murky, white wine made from rice."

/obj/structure/fermenting_barrel/whitericewine/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/makkolir,900)


/obj/structure/fermenting_barrel/gronmead
	desc = "A barrel with a Shieldmaiden Brewery mark. A deep red honey-wine, refined with the red berries."

/obj/structure/fermenting_barrel/gronmead/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/gronnmead,900)


/obj/structure/fermenting_barrel/murkwine
	desc = "A barrel with a Possumtail Brewery mark. Two Volk tails interlace with eachother upon the seal in a dance."

/obj/structure/fermenting_barrel/murkwine/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/murkwine,900)

/obj/structure/fermenting_barrel/moonshine
	desc = "A barrel with a blue, Crescent moon mark. Not the wisest choice of drinks, but certainly the strongest."

/obj/structure/fermenting_barrel/moonshine/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/moonshine,900)
