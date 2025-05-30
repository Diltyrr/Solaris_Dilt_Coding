//Good Moodlets

/datum/stressevent/gold_nap
	timer = 30 MINUTES
	stressadd = -4
	desc = list(
    	span_boldgreen("I slept atop my treasure. All is right."),
    	span_boldgreen("Coins, gems, dreams, mine to rest upon."),
    	span_boldgreen("The clink of wealth lulled me to sleep."),
    	span_boldgreen("No pillow finer than a bed of riches."),
    	span_boldgreen("My hoard embraced me in glimmering warmth.")
	)

/datum/stressevent/good_book
	timer = 10 MINUTES
	stressadd = -2
	desc = span_green("A quiet moment with a good story. My mind drifts far from worry.")

/datum/stressevent/boss_finisher
	timer = 10 MINUTES
	stressadd = -1
	desc = span_boldgreen("They said it couldn't be done. I proved them wrong.")

/datum/stressevent/victory_rush
	timer = 15 MINUTES
	stressadd = -1
	desc = span_boldgreen("I stared death in the eye... and laughed.")

/datum/stressevent/wreathed_in_glory
	timer = 20 MINUTES
	stressadd = -1
	desc = span_boldgreen ("Their doom is my legend.")

/datum/stressevent/champion
	timer = 30 MINUTES
	stressadd = -2
	desc = span_green("The taste of victory is sweeter than wine.")

/datum/stressevent/boss_slayer
	timer = 3 HOURS
	stressadd = -1
	desc = span_green("I feel unbreakable today.")

//Bad Moodlets

/datum/stressevent/watched
	timer = 5 MINUTES
	stressadd = 1
	desc = span_red("Someone's eyes are on me. I can feel it.")

/datum/stressevent/goldless_sleep
	timer = 30 MINUTES
	stressadd = 3
	desc = list(
		span_boldred("I miss the warmth of my treasure."),
		span_boldred("Cold floor, no shine, no comfort."),
		span_boldred("Where is my hoard? Sleep betrayed me."),
		span_boldred("Rest without riches is no rest at all."),
		span_boldred("Once cradled by gold, now cast to dirt.")
	)
