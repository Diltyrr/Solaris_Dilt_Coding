/area/provincial/underground/beach
	name = "\proper Hallowed Coast's Caverns"
	icon_state = "beach"
	first_time_text = /area/provincial/outdoors/beach::first_time_text

/area/provincial/underground/beach/forest
	name = "\proper Emerald Coast's Caverns"
	icon_state = "woods"
	first_time_text = /area/provincial/outdoors/beach/forest::first_time_text

/area/provincial/underground/bog
	name = "\proper Synod Of Willows' Caverns"
	icon_state = "bog"

/area/provincial/underground/field
	name = "\proper Solara Vie Caverns"
	icon_state = "rtfield"

/area/provincial/underground/forest
	name = "\proper Emerald Glade Caverns"
	icon_state = "woods"

/area/provincial/underground/forest/brightway
	name = "\proper Brightway Woods Caverns"

/area/provincial/underground/river
	name = "\proper Veshin River Caverns"
	icon_state = "river"

/area/provincial/underground/spider_cave
	name = "Araignée" // lit. "Spider". this is dumb
	icon_state = "spider"
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/spider = 100)
	droning_sound = 'sound/music/area/spidercave.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	brief_descriptor = "where web and rock weave together"
