/area/provincial/underground/dungeon/old_university
	name = "Scholar's Folly"
	icon_state = "under"
	first_time_text = "SCHOLAR'S FOLLY"
	droning_sound = 'sound/music/area/dungeon.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/rogue/grassred)
	ambush_mobs = list(
				/mob/living/carbon/human/species/elf/dark/ziraguard/ambush = 60,
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 40)
	brief_descriptor = "in old sunmarch, in the endless halls of academia lost"

/area/provincial/underground/dungeon/old_university_garden
	name = "Entombed Garden"
	icon_state = "caves"
	first_time_text = "ENTOMBED GARDEN"
	droning_sound = 'sound/music/area/dungeon2.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/rogue/grassred)
	ambush_mobs = list(
				/mob/living/carbon/human/species/elf/dark/ziraguard/ambush = 10,
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 20)
	brief_descriptor = "in old sunmarch, admist the gnarled trees that adorned an academy."
