/datum/patron/three_sisters
	name = null
	associated_faith = /datum/faith/three_sisters
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/three_sisters/tamari
	name = "Tamari"
	domain = "Nature, Growth, Evolution, Earth"
	desc = "Fickle and stubborn, the Earthmother Tamari has long been worshipped by druids, farmers, and those who find their home far away from metropolitan civilization. \
			It is said that she stole light from the sun and created life, and it is under her guiding hand that life was free to change, to adapt, to grow, to alter the world around \
			it and permit itself be altered. There are ancient and wild places of the earth still yet untouched by civilization, and it is in these places that Tamari's primal song of creation may yet still be heard."
	worshippers = "Druids, Nomads, Naturalists, Outsiders, and Wanderers."
	mob_traits = list(TRAIT_KNEESTINGER_IMMUNITY, TRAIT_LEECHIMMUNE, TRAIT_BEASTKIN)
	t1 = /obj/effect/proc_holder/spell/self/tamari_shapeshift
	t2 = /obj/effect/proc_holder/spell/targeted/conjure_glowshroom
	t3 = /obj/effect/proc_holder/spell/self/howl/call_of_the_moon
	t4 = /obj/effect/proc_holder/spell/self/invoke_shelter

/datum/patron/three_sisters/nunos
	name = "Nunos"
	domain = "Fire, Technology, Labour, the Forge, Metal"
	desc = "The most contested of the Three Sisters, it is unknown if Nunos is even still considered divinely 'female' - let alone if they prefer the human name Nunos. \
			The goddess who the elves know as the Sister of Flame Nuvelle and who the dwarves know as the Forge-Lady Nardám is most broadly known for one thing: their refusal to speak. \
			It is actions that speak louder than words, and it is this principle that guides the voiceless, nameless Sister of Technology as she guides her craftsfolk to divine inspiration \
			and gifts dreams of great workings to those who most diligently follow her."
	worshippers = "Craftsfolk, Smiths, Masons, Carpenters, Scientists, and Engineers."
	mob_traits = list(TRAIT_FORGEBLESSED, TRAIT_BETTER_SLEEP)
	t1 = /obj/effect/proc_holder/spell/invoked/vigorousexchange
	t2 = /obj/effect/proc_holder/spell/invoked/heatmetal
	t3 = /obj/effect/proc_holder/spell/invoked/hammerfall
	t4 = /obj/effect/proc_holder/spell/invoked/craftercovenant
	extra_spell = /obj/effect/proc_holder/spell/invoked/nunos_flame_rogue

/datum/patron/three_sisters/kasmidian
	name = "Kasmidian"
	domain = "Enchanting Goddess of the Arcane"
	desc = "Magic is just as much an art as it is a science, and Kasmidian fancies herself an artist; unchained, untamed, unbound. It is she that whispers deep secrets of magic to scholars that \
			toil in her libraries; it is her that hides secrets of magic among the stars for astronomers to find; it is her that embodies the ideal that change will come, and it is one's duty to \
			understand that change so that they may act with it. It is unknown if she first gifted magic to mortalkind, but many faiths of other churches contest that her gifts are well-intentioned, \
			or may end well at all - though most wizards, divorced from the church, care not, and worship the Astral Muse as they see fit."
	worshippers = "Wizards, Astrologers, Scholars, Artists, and Eccentrists."
	mob_traits = list(TRAIT_KASMIDIAN)
	t1 = /obj/effect/proc_holder/spell/invoked/wheel
	t2 = /obj/effect/proc_holder/spell/invoked/mockery
