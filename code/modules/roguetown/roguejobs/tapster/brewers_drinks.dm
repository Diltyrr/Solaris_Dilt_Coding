// Juices and what core drinks I could take from SS13 remain in their original files. See drink_reagents.dm for example. 
/** Made in cooperation with @flowergirltulip. Shout out to her for the entire concept vertical!*/
//     - Antarion

//     - This file is for Solaris Ridge drinks only, and is not used by the core game.


/datum/reagent/consumable/ethanol/ale
	name = "Table Porter"
	description = "A dark alcoholic beverage made with malted barley and yeast."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 65
	taste_description = "hearty barley ale"
	glass_icon_state = "aleglass"
	glass_name = "glass of ale"
	glass_desc = ""
	hydration_factor = 10

/datum/reagent/consumable/ethanol/beer
	name = "Tapsters' Beer"
	description = ""
	color = "#a17c10" // rgb: 102, 67, 0
	nutriment_factor = 0.1
	boozepwr = 25
	taste_description = "ale"
	glass_name = "glass of beer"
	glass_desc = ""
	hydration_factor = 10

/datum/reagent/consumable/ethanol/beer/cider
	name = "Soilkin's Cider"
	boozepwr = 40
	taste_description = "cider"
	glass_name = "glass of cider"
	color = "#c7ce6d"

/datum/reagent/consumable/ethanol/sake
	name = "Simple Sake"
	description = "A sweet rice wine of questionable legality and extreme potency."
	color = "#DDDDDD"
	boozepwr = 70
	taste_description = "sweet rice wine"
	glass_icon_state = "sakecup"
	glass_name = "cup of sake"
	glass_desc = ""

/datum/reagent/consumable/ethanol/beer/wine
	name = "Laborer's Wine"
	boozepwr = 30
	taste_description = "wine"
	glass_name = "glass of wine"
	color = "#8a0b0b"

/datum/reagent/consumable/ethanol/beer/rum
	name = "Grog"
	boozepwr = 40
	taste_description = "rum"
	glass_name = "glass of rum"
	color = "#ef7f16"

/datum/reagent/consumable/ethanol/mead
	name = "Beespider Mead"
	description = "A sweet and smooth mead made from the simplest of ingredients"
	boozepwr = 30
	taste_description = "simple mead"
	glass_name = "glass of mead"
	color = "#e0c133"
	hydration_factor = 10


// Tier Two drinks, made from the finest ingredients and brewed with care.
/datum/chemical_reaction/fine_ale
	name = "Rantegarde Lager"
	id = /datum/reagent/consumable/ethanol/fine_ale
	results = list(/datum/reagent/consumable/ethanol/fine_ale = 66)
	required_reagents = list(/datum/reagent/water = 33, /datum/reagent/consumable/maltwheat = 33, /datum/reagent/consumable/sugar = 1)
	mix_message = "The mix swirls and turns a deep amber that reminds you of a fine ale."

/datum/reagent/consumable/ethanol/fine_ale
	name = "Rantegarde Lager"
	description = "A fine ale made from the freshest malted wheat, with a hint of hops."
	taste_description = "fresh malted wheat, hops"
	boozepwr = 50
	color = "#d4a373"
	hydration_factor = 10

/datum/chemical_reaction/fine_beer
	name = "Solarian Stout"
	id = /datum/reagent/consumable/ethanol/fine_beer
	results = list(/datum/reagent/consumable/ethanol/fine_beer = 66)
	required_reagents = list(/datum/reagent/water = 33, /datum/reagent/consumable/malted_oats = 33, /datum/reagent/consumable/sugar = 1)
	mix_message = "The mix swirls and turns a dark brown that reminds you of a fine stout."

/datum/reagent/consumable/ethanol/fine_beer
	name = "Solarian Stout"
	description = "A fine stout made from the freshest malted oats"
	taste_description = "fresh malted oats"
	boozepwr = 45
	color = "#3b2f2f"
	hydration_factor = 10

/datum/chemical_reaction/fine_cider
	name = "Amberpress Cider"
	id = /datum/reagent/consumable/ethanol/fine_cider
	results = list(/datum/reagent/consumable/ethanol/fine_cider = 66)
	required_reagents = list(/datum/reagent/water = 33, /datum/reagent/consumable/applejuice = 33, /datum/reagent/consumable/sugar = 1)
	mix_message = "The mix swirls and turns a bright red that reminds you of an apple's skin."

/datum/reagent/consumable/ethanol/fine_cider
	name = "Amberpress Cider"
	description = "A fine cider made from the freshest apples, with a hint of spice."
	taste_description = "fresh apple, spice"
	boozepwr = 35
	color = "#eaec63"
	hydration_factor = 10
	

/datum/chemical_reaction/fine_wine
	name = "Solarian Blue"
	id = /datum/reagent/consumable/ethanol/fine_wine
	results = list(/datum/reagent/consumable/ethanol/fine_wine = 66)
	required_reagents = list(/datum/reagent/water = 33, /datum/reagent/consumable/berryjuice = 33, /datum/reagent/consumable/sugar = 1)
	mix_message = "The mix swirls and turns a deep blue that reminds you of a fine wine."

/datum/reagent/consumable/ethanol/fine_wine
	name = "Solarian Blue"
	description = "A fine wine made from the freshest berries, with a hint of sweetness."
	taste_description = "fresh berry, sweetness"
	boozepwr = 15
	color = "#19008b"
	hydration_factor = 10

/datum/chemical_reaction/fine_sake
	name = "Silkensong Sake"
	id = /datum/reagent/consumable/ethanol/fine_sake
	results = list(/datum/reagent/consumable/ethanol/fine_sake = 66)
	required_reagents = list(/datum/reagent/water = 33, /datum/reagent/consumable/rice_milk = 33, /datum/reagent/consumable/sugar = 1)
	mix_message = "The mix swirls and turns a pale yellow that reminds you of a fine sake."

/datum/reagent/consumable/ethanol/fine_sake
	name = "Silkensong Sake"
	description = "A fine sake made from the freshest rice milk, with a hint of sweetness."
	taste_description = "fresh rice milk, sweetness"
	boozepwr = 60
	color = "#f0e68c"
	glass_icon_state = "sakecup"
	glass_name = "cup of sake"
	glass_desc = ""
	hydration_factor = 10

/datum/chemical_reaction/fine_vodka
	name = "Silent Storm Vodka"
	id = /datum/reagent/consumable/ethanol/fine_vodka
	results = list(/datum/reagent/consumable/ethanol/fine_vodka = 66)
	required_reagents = list(/datum/reagent/water = 33, /datum/reagent/consumable/potato_juice = 33, /datum/reagent/consumable/sugar = 1)
	mix_message = "The mix swirls and turns a clear liquid that reminds you of fine vodka."

/datum/reagent/consumable/ethanol/fine_vodka
	name = "Silent Storm Vodka"
	description = "A fine vodka made from the freshest potatoes, with a hint of spice."
	taste_description = "White Vodka, a hint of vanilla, and assorted spice"
	boozepwr = 40
	color = "#d8e1e2"
	hydration_factor = 10

/datum/chemical_reaction/pumpkinale
	name = "Drunken Pumpkin Porter"
	id = /datum/reagent/consumable/ethanol/pumpkinale
	results = list(/datum/reagent/consumable/ethanol/pumpkinale = 66)
	required_reagents = list(/datum/reagent/water = 33, /datum/reagent/consumable/pumpkinjuice = 33, /datum/reagent/consumable/sugar = 1)
	mix_message = "The mix swirls and turns a bright orange that reminds you of a pumpkin."

/datum/reagent/consumable/ethanol/pumpkinale
	name = "Drunken Pumpkin Porter"
	description = "A pumpkin ale made from the freshest pumpkins, with a hint of spice."
	taste_description = "fresh pumpkin, spice"
	boozepwr = 25
	color = "#ff8c00"
	hydration_factor = 10

/datum/chemical_reaction/carrotale
	name = "Golden Rabbit Hops"
	id = /datum/reagent/consumable/ethanol/carrotale
	results = list(/datum/reagent/consumable/ethanol/carrotale = 66)
	required_reagents = list(/datum/reagent/water = 33, /datum/reagent/consumable/carrotjuice = 33, /datum/reagent/consumable/sugar = 1)
	mix_message = "The mix swirls and turns a bright orange that reminds you of a carrot."

/datum/reagent/consumable/ethanol/carrotale
	name = "Golden Rabbit Hops"
	description = "A carrot ale made from the freshest carrots, with a hint of spice."
	taste_description = "fresh carrot, hops"
	boozepwr = 20
	color = "#ffa500"
	hydration_factor = 10

/datum/chemical_reaction/fine_rum
	name = "Sailor's Choice Rum"
	id = /datum/reagent/consumable/ethanol/fine_rum
	results = list(/datum/reagent/consumable/ethanol/fine_rum = 66)
	required_reagents = list(/datum/reagent/water = 33, /datum/reagent/consumable/sugarcanejuice = 33, /datum/reagent/consumable/sugar = 1)
	mix_message = "The mix swirls and turns a golden brown that reminds you of fine rum."

/datum/reagent/consumable/ethanol/fine_rum
	name = "Sailor's Choice Rum"
	description = "A fine rum made from the freshest sugarcane, with a hint of spice."
	taste_description = "fresh sugarcane, spice"
	boozepwr = 50
	color = "#d2b48c"
	hydration_factor = 10

/datum/chemical_reaction/fine_mead
    name = "Honey Grove Mead"
    id = /datum/reagent/consumable/ethanol/fine_mead
    results = list(/datum/reagent/consumable/ethanol/fine_mead = 66)
    required_reagents = list(/datum/reagent/water = 33, /datum/reagent/consumable/meadbase = 33, /datum/reagent/consumable/sugar = 1)
    mix_message = "The mix swirls and turns into a smooth golden liquid that reminds you of fine mead"

/datum/reagent/consumable/ethanol/fine_mead
    name = "Honey Grove Mead"
    description = "A fine mead maded from the collected honey of distant apiaries, with a hint of sweetness."
    taste_description = "Smooth honey, sweetness"
    boozepwr = 50
    color = "#e0c133"
    hydration_factor = 10
