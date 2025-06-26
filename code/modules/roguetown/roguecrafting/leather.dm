/datum/crafting_recipe/roguetown/leather
	tools = list(/obj/item/needle)
	structurecraft = /obj/machinery/tanningrack
	skillcraft = /datum/skill/craft/tanning

/datum/crafting_recipe/roguetown/leather/bedroll
	name = "bedroll (2 leather, 1 rope)"
	result = /obj/item/bedroll
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/rope = 1)
	tools = list(/obj/item/needle)
	verbage_simple = "construct"
	verbage = "constructs"
	craftdiff = 2

/datum/crafting_recipe/roguetown/leather/corset
	name = "corset (1 fibers, 1 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/corset
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	tools = list(/obj/item/needle)
	sellprice = 15
	craftdiff = 2

/datum/crafting_recipe/roguetown/leather/pouch
	name = "leather pouch (1 fibers, 1 leather)"
	result = list(/obj/item/storage/belt/rogue/pouch,
				/obj/item/storage/belt/rogue/pouch)
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	sellprice = 6
	craftdiff = 0

/datum/crafting_recipe/roguetown/leather/satchel
	name = "leather satchel (1 fibers, 2 leather)"
	result = /obj/item/storage/backpack/rogue/satchel
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	sellprice = 15

/datum/crafting_recipe/roguetown/leather/backpack
	name = "leather backpack (1 fibers, 2 leather)"
	result = /obj/item/storage/backpack/rogue/backpack
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	sellprice = 15

/datum/crafting_recipe/roguetown/leather/waterskin
	name = "waterskin (2 fibers, 1 leather)"
	result = /obj/item/reagent_containers/glass/bottle/waterskin
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 2)
	sellprice = 12

/datum/crafting_recipe/roguetown/leather/quiver
	name = "quiver (2 fibers, 2 leather)"
	result = /obj/item/quiver
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 30


/datum/crafting_recipe/roguetown/leather/ammopouch
	name = "shot pouch (4 leather, 3 fiber)"
	result = /obj/item/ammopouch
	reqs = list (/obj/item/natural/hide/cured = 4,
				/obj/item/natural/fibers = 3)

/datum/crafting_recipe/roguetown/leather/javelinbag
	name = "javelin bag (1 tallow, 1 rope)"
	result = /obj/item/quiver/javelin
	reqs = list(/obj/item/reagent_containers/food/snacks/tallow = 1,
				/obj/item/rope = 1)
	sellprice = 30

/datum/crafting_recipe/roguetown/leather/gwstrap
	name = "greatweapon strap (2 leather, 1 rope)"
	result = /obj/item/gwstrap
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/rope = 1)
	sellprice = 30

/datum/crafting_recipe/roguetown/leather/twstrap
	name = "bandolier (2 leather, 1 rope)"
	result = /obj/item/twstrap
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/rope = 1)
	sellprice = 30

/datum/crafting_recipe/roguetown/leather/belt
	name = "leather belt (2 fibers, 2 leather)"
	result = /obj/item/storage/belt/rogue/leather
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 30

/datum/crafting_recipe/roguetown/leather/belt/knifebelt
	name = "leather knifebelt (2 fibers, 2 leather)"
	result = /obj/item/storage/belt/rogue/leather/knifebelt
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 30

/datum/crafting_recipe/roguetown/leather/gloves
	name = "leather gloves (1 leather)"
	result = list(/obj/item/clothing/gloves/roguetown/leather,
	/obj/item/clothing/gloves/roguetown/leather)
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/heavygloves
	name = "heavy leather gloves (1 fur)"
	result = /obj/item/clothing/gloves/roguetown/angle
	reqs = list(/obj/item/natural/fur = 1)
	sellprice = 20

/datum/crafting_recipe/roguetown/leather/fingerless_leather_gloves
	name = "fingerless leather gloves (1 fibers, 1 leather, 1 tallow)"
	result = /obj/item/clothing/gloves/roguetown/fingerless_leather
	reqs = list(
		/obj/item/natural/hide/cured = 1,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 1,
		)
	sellprice = 20

/datum/crafting_recipe/roguetown/leather/lgorget
	name = "hardened leather gorget (1 fibers, 1 leather)"
	result = /obj/item/clothing/neck/roguetown/leather
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/leather/heavybracers
	name = "hardened leather bracers (1 fibers, 2 leather)"
	result = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/leather/bracers
	name = "leather bracers (1 leather)"
	result = list(/obj/item/clothing/wrists/roguetown/bracers/leather,
			/obj/item/clothing/wrists/roguetown/bracers/leather)
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/pants
	name = "leather pants (2 leather)"
	result = list(/obj/item/clothing/under/roguetown/trou/leather)
	reqs = list(/obj/item/natural/hide/cured = 2)
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/wolfhelm
	name = "wolf helm (1 leather, 1 fur, 1 wolf head)"
	result = list(/obj/item/clothing/head/roguetown/helmet/leather/wolfhelm)
	reqs = list(/obj/item/natural/hide/cured = 1, /obj/item/natural/fur = 2, /obj/item/natural/head/wolf = 1)
	sellprice = 20

/datum/crafting_recipe/roguetown/leather/wolfmantle
	name = "wolf mantle (2 leather, 1 wolf head)"
	result = /obj/item/clothing/cloak/wolfmantle
	reqs = list(
		/obj/item/natural/hide/cured = 2,
		/obj/item/natural/head/wolf = 1,
	)
	craftdiff = 2

/datum/crafting_recipe/roguetown/leather/heavy_leather_pants
	name = "hardened leather pants (1 fibers, 3 leather, 1 tallow)"
	result = list(/obj/item/clothing/under/roguetown/heavy_leather_pants)
	reqs = list(
		/obj/item/natural/hide/cured = 3,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 1,
		)
	sellprice = 20
	craftdiff = 3

/datum/crafting_recipe/roguetown/leather/heavy_leather_pants/shorts
	name = "hardened leather shorts (1 fibers, 2 leather, 1 tallow)"
	result = list(/obj/item/clothing/under/roguetown/heavy_leather_pants/shorts)
	reqs = list(
		/obj/item/natural/hide/cured = 1, //they cover less, you see
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 1,
		)
	sellprice = 20

/datum/crafting_recipe/roguetown/leather/shoes
	name = "leather shoes (1 leather)"
	result = list(/obj/item/clothing/shoes/roguetown/simpleshoes,
				/obj/item/clothing/shoes/roguetown/simpleshoes,
				/obj/item/clothing/shoes/roguetown/simpleshoes)
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/boots
	name = "leather boots (1 leather)"
	result = /obj/item/clothing/shoes/roguetown/boots/leather
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 27

/datum/crafting_recipe/roguetown/leather/boots/furlinedboots
	name = "fur-lined boots (1 leather, 1 fur)"
	result = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fur = 1)

/datum/crafting_recipe/roguetown/leather/boots/short
	name = "shortboots (1 leather)"
	result = /obj/item/clothing/shoes/roguetown/shortboots
	reqs = list(/obj/item/natural/hide/cured = 1)

/datum/crafting_recipe/roguetown/leather/boots/dark
	name = "dark boots (1 leather)"
	result = /obj/item/clothing/shoes/roguetown/boots
	reqs = list(/obj/item/natural/hide/cured = 1)

/datum/crafting_recipe/roguetown/leather/boots/noble
	name = "noble boots (1 leather, 1 fur)"
	result = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	reqs = list(/obj/item/natural/hide/cured = 3,
				/obj/item/natural/fur = 1)

/datum/crafting_recipe/roguetown/leather/helmet
	name = "leather helmet (1 leather)"
	result = /obj/item/clothing/head/roguetown/helmet/leather
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 27

/datum/crafting_recipe/roguetown/leather/helmet/advanced
	name = "hardened leather helmet (1 fibers, 1 leather, 1 tallow)"
	result = /obj/item/clothing/head/roguetown/helmet/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/reagent_containers/food/snacks/tallow = 1)
	craftdiff = 4
	sellprice = 40

/datum/crafting_recipe/roguetown/leather/bandana
	name = "leather bandana (1 leather)"
	result = /obj/item/clothing/head/roguetown/helmet/bandana
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 27
	craftdiff = 0

/datum/crafting_recipe/roguetown/leather/tricorn
	name = "leather tricorn (1 leather)"
	result = /obj/item/clothing/head/roguetown/helmet/tricorn
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 27

/datum/crafting_recipe/roguetown/leather/hood
	name = "leather hood (1 leather)"
	result = /obj/item/clothing/head/roguetown/roguehood
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/vest
	name = "leather vest (2 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/vest
	reqs = list(/obj/item/natural/hide/cured = 2)

/datum/crafting_recipe/roguetown/leather/armor
	name = "leather armor (2 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/leather
	reqs = list(/obj/item/natural/hide/cured = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/cuirass
	name = "leather cuirass"
	name = "leather armor (2 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/cuirass
	reqs = list(/obj/item/natural/hide/cured = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/bikini
	name = "leather bikini armor (2 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/bikini
	reqs = list(/obj/item/natural/hide/cured = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/hidearmor
	name = "hide armor (2 leather, 1 fur)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/hide
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1)
	sellprice = 26
	craftdiff = 1

/datum/crafting_recipe/roguetown/leather/heavy_leather_armor
	name = "hardened leather armor (1 fibers, 2 leather, 1 tallow)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/heavy
	reqs = list(
		/obj/item/natural/hide/cured = 2,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 1,
		)
	sellprice = 26
	craftdiff = 3

/datum/crafting_recipe/roguetown/leather/heavy_leather_armor/coat
	name = "hardened leather coat (1 fibers, 3 leather, 1 tallow)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	reqs = list(
		/obj/item/natural/hide/cured = 3,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 1,
		)
	sellprice = 36
	craftdiff = 4

/datum/crafting_recipe/roguetown/leather/heavy_leather_armor/jacket
	name = "hardened leather jacket (1 fibers, 3 leather, 1 tallow)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/heavy/jacket
	reqs = list(
		/obj/item/natural/hide/cured = 3,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 1,
		)
	sellprice = 36
	craftdiff = 4

/datum/crafting_recipe/roguetown/leather/hidebikini
	name = "hide bikini armor (2 leather, 1 tallow)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/hide/bikini
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/cloak
	name = "leather cloak (2 leather)"
	result = /obj/item/clothing/cloak/raincloak/brown
	reqs = list(/obj/item/natural/hide/cured = 2)

/datum/crafting_recipe/roguetown/leather/apron/blacksmith
	name = "leather apron (1 fibers, 2 leather)"
	result = /obj/item/clothing/cloak/apron/blacksmith
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/leather/cloakfur
	name = "fur cloak (2 leather, 1 fur)"
	result = /obj/item/clothing/cloak/raincloak/furcloak/crafted
	reqs = list(/obj/item/natural/hide/cured = 2,/obj/item/natural/fur = 1)

/obj/item/clothing/cloak/raincloak/furcloak/crafted
	sellprice = 55

/datum/crafting_recipe/roguetown/leather/papakha
	name = "papakha hat (2 fibers, 1 fur)"
	result = /obj/item/clothing/head/roguetown/papakha/crafted
	reqs = list(/obj/item/natural/fur = 1, /obj/item/natural/fibers = 2)

/obj/item/clothing/head/roguetown/papakha/crafted
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/saddle
	name = "saddle (2 leather)"
	result = /obj/item/natural/saddle
	reqs = list(/obj/item/natural/hide/cured = 2)

/datum/crafting_recipe/roguetown/leather/whip
	name = "leather whip (2 leather, 1 stone)"
	result = /obj/item/rogueweapon/whip
	reqs = list(/obj/item/natural/hide/cured = 2,/obj/item/natural/stone = 1)
	sellprice = 39

/datum/crafting_recipe/roguetown/leather/drum
	name = "Drum (2 leather, 1 log)"
	result = /obj/item/rogue/instrument/drum
	reqs = list(/obj/item/natural/hide/cured = 1,/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/leather/vest/sailor
	name = "leather sea jacket (2 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
	reqs = list(/obj/item/natural/hide/cured = 2)

/datum/crafting_recipe/roguetown/leather/darkcloak
	name = "dark cloak (4 leather, 2 fur)"
	result = list(/obj/item/clothing/cloak/darkcloak)
	reqs = list(/obj/item/natural/fur = 2,
				/obj/item/natural/hide/cured = 4)
	craftdiff = 5
	sellprice = 80

/datum/crafting_recipe/roguetown/leather/bearcloak
	name = "direbear cloak (4 leather, 2 fur)"
	result = list(/obj/item/clothing/cloak/darkcloak/bear)
	reqs = list(/obj/item/natural/fur = 2,
				/obj/item/natural/hide/cured = 4)
	craftdiff = 3
	sellprice = 80

/datum/crafting_recipe/roguetown/leather/lightbearcloak
	name = "light direbear cloak (4 leather, 2 fur)"
	result = list(/obj/item/clothing/cloak/darkcloak/bear/light)
	reqs = list(/obj/item/natural/fur = 2,
				/obj/item/natural/hide/cured = 4)
	craftdiff = 3
	sellprice = 80

/datum/crafting_recipe/roguetown/leather/leathertights
	name = "leather tights (2 leather)"
	result = list(/obj/item/clothing/under/roguetown/trou/leathertights)
	reqs = list(/obj/item/natural/hide/cured = 2)
	tools = list(/obj/item/needle)
	craftdiff = 3
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/artipants
	name = "thin leather pants (1 cloth, 2 leather)"
	result = list(/obj/item/clothing/under/roguetown/trou/artipants)
	reqs = list(/obj/item/natural/cloth = 1,
	            /obj/item/natural/hide/cured = 2)
	tools = list(/obj/item/needle)
	craftdiff = 3
	sellprice = 11

/datum/crafting_recipe/roguetown/leather/gladsandals
	name = "gladiator sandals (1 fibers, 2 leather)"
	result = list(/obj/item/clothing/shoes/roguetown/gladiator)
	reqs = list(/obj/item/natural/hide/cured = 2,
	            /obj/item/natural/fibers = 1)
	tools = list(/obj/item/needle)
	craftdiff = 3
	sellprice = 12

/datum/crafting_recipe/roguetown/leather/buckleshoes
	name = "buckled shoes (2 fibers, 2 leather)"
	result = list(/obj/item/clothing/shoes/roguetown/simpleshoes/buckle)
	reqs = list(/obj/item/natural/hide/cured = 1,
	            /obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	craftdiff = 6
	sellprice = 25

/datum/crafting_recipe/roguetown/leather/greatcoat
	name = "greatcoat (1 cloth, 3 leather, 1 fur)"
	result = list(/obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/coat)
	reqs = list(/obj/item/natural/hide/cured = 3,
				/obj/item/natural/fur = 1,
	            /obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 24

/datum/crafting_recipe/roguetown/leather/furlinedjacket
	name = "fur-lined jacket (1 cloth, 2 leather, 1 fur)"
	result = list(/obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket)
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1,
	            /obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 21

/datum/crafting_recipe/roguetown/leather/winterjacket
	name = "winter jacket (1 cloth, 2 leather, 2 fur)"
	result = list(/obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket)
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 2,
	            /obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 24

/datum/crafting_recipe/roguetown/hunting/carapacecuirass
	name = "carapace cuirass"
	result = list(/obj/item/clothing/suit/roguetown/armor/carapace/cuirass)
	reqs = list(/obj/item/natural/carapace = 2,
				/obj/item/natural/fibers = 4)
	craftdiff = 3
	sellprice = 22

/datum/crafting_recipe/roguetown/hunting/carapacearmor
	name = "carapace armor"
	result = list(/obj/item/clothing/suit/roguetown/armor/carapace)
	reqs = list(/obj/item/natural/carapace = 4,
				/obj/item/natural/fibers = 6)
	craftdiff = 3
	sellprice = 42

/datum/crafting_recipe/roguetown/hunting/carapacelegs
	name = "carapace chausses"
	result = list(/obj/item/clothing/under/roguetown/carapacelegs)
	reqs = list(/obj/item/natural/carapace = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	sellprice = 10

/datum/crafting_recipe/roguetown/hunting/carapaceskirt
	name = "carapace skirt"
	result = list(/obj/item/clothing/under/roguetown/carapacelegs/skirt)
	reqs = list(/obj/item/natural/carapace = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	sellprice = 10

/datum/crafting_recipe/roguetown/hunting/carapacecap
	name = "carapace cap"
	result = list(/obj/item/clothing/head/roguetown/helmet/carapacecap)
	reqs = list(/obj/item/natural/carapace = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	sellprice = 10

/datum/crafting_recipe/roguetown/hunting/carapacehelm
	name = "carapace helmet"
	result = list(/obj/item/clothing/head/roguetown/helmet/carapacehelm)
	reqs = list(/obj/item/natural/carapace = 2,
				/obj/item/natural/fibers = 4)
	craftdiff = 3
	sellprice = 22

/datum/crafting_recipe/roguetown/hunting/carapaceboots
	name = "carapace boots"
	result = list(/obj/item/clothing/shoes/roguetown/boots/carapace)
	reqs = list(/obj/item/natural/carapace = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	sellprice = 20

/datum/crafting_recipe/roguetown/hunting/carapacegloves
	name = "carapace gauntlets"
	result = list(/obj/item/clothing/gloves/roguetown/carapace)
	reqs = list(/obj/item/natural/carapace = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	sellprice = 20

/datum/crafting_recipe/roguetown/hunting/carapacebracers
	name = "carapace bracers"
	result = list(/obj/item/clothing/wrists/roguetown/bracers/carapace)
	reqs = list(/obj/item/natural/carapace = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	sellprice = 20

/datum/crafting_recipe/roguetown/hunting/carapacecuirass/dragon
	name = "dragon cuirass"
	result = list(/obj/item/clothing/suit/roguetown/armor/carapace/dragon/cuirass)
	reqs = list(/obj/item/natural/carapace/dragon = 2,
				/obj/item/natural/fibers = 4)
	craftdiff = 6
	sellprice = 22

/datum/crafting_recipe/roguetown/hunting/carapacearmor/dragon
	name = "dragon armor"
	result = list(/obj/item/clothing/suit/roguetown/armor/carapace/dragon)
	reqs = list(/obj/item/natural/carapace/dragon = 4,
				/obj/item/natural/fibers = 6)
	craftdiff = 6
	sellprice = 42

/datum/crafting_recipe/roguetown/hunting/carapacelegs/dragon
	name = "dragon chausses"
	result = list(/obj/item/clothing/under/roguetown/carapacelegs/dragon)
	reqs = list(/obj/item/natural/carapace/dragon = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 6
	sellprice = 10

/datum/crafting_recipe/roguetown/hunting/carapaceskirt/dragon
	name = "dragon skirt"
	result = list(/obj/item/clothing/under/roguetown/carapacelegs/dragon/skirt)
	reqs = list(/obj/item/natural/carapace/dragon = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 6
	sellprice = 10

/datum/crafting_recipe/roguetown/hunting/carapacecap/dragon
	name = "dragon cap"
	result = list(/obj/item/clothing/head/roguetown/helmet/carapacecap/dragon)
	reqs = list(/obj/item/natural/carapace/dragon = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 6
	sellprice = 10

/datum/crafting_recipe/roguetown/hunting/carapacehelm/dragon
	name = "dragon helmet"
	result = list(/obj/item/clothing/head/roguetown/helmet/carapacehelm/dragon)
	reqs = list(/obj/item/natural/dragon_head = 1,
				/obj/item/natural/fibers = 4)
	craftdiff = 6
	sellprice = 22

/datum/crafting_recipe/roguetown/hunting/carapaceboots/dragon
	name = "dragon boots"
	result = list(/obj/item/clothing/shoes/roguetown/boots/carapace/dragon)
	reqs = list(/obj/item/natural/carapace/dragon = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 6
	sellprice = 20

/datum/crafting_recipe/roguetown/hunting/carapacegloves/dragon
	name = "dragon gauntlets"
	result = list(/obj/item/clothing/gloves/roguetown/carapace/dragon)
	reqs = list(/obj/item/natural/carapace/dragon = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 6
	sellprice = 20

/datum/crafting_recipe/roguetown/hunting/carapacebracers/dragon
	name = "dragon bracers"
	result = list(/obj/item/clothing/wrists/roguetown/bracers/carapace/dragon)
	reqs = list(/obj/item/natural/carapace/dragon = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 6
	sellprice = 20
