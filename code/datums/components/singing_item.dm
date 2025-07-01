/datum/controller/configuration/proc/LoadWeaponDialog()
	var/file_path = "strings/singing_weapon_replies.json"
	if(fexists(file_path))
		var/json_text = file2text(file_path)
		GLOB.weapon_personality_dialog = json_decode(json_text)
	else
		log_world("ERROR: Could not load singing_weapon_replies.json")

/datum/component/singing_item
	var/obj/item/rogueweapon/weapon
	var/mob/living/weapon_owner
	var/personality = "zealous"

/datum/component/singing_item/Initialize(mob/living/carbon/human/human_owner, patronchoice, item)
	if(!isitem(item))
		return COMPONENT_INCOMPATIBLE

	weapon_owner = human_owner.real_name
	personality = get_patron_personality(patronchoice)

	return ..()

/proc/get_patron_personality(patronchoice)
	switch(patronchoice)
		if("The Verdant Court")
			return pick("mischievous", "curious")
		if("The Radiant Ember")
			return pick("hopeful", "zealous")
		if("The Drowned Choir")
			return pick("melancholic", "haunting")
		if("The Ashen Pact")
			return pick("vengeful", "smoldering")
		if("The Bound Whisper")
			return pick("manipulative", "bargaining")
		if("The Hollow Voice")
			return pick("paranoid", "detached")
		if("The Wakened Blade")
			return pick("bloodthirsty", "loyal")
		if("The Pale Crown")
			return pick("cold", "commanding")
		else
			return pick("zealous") //Fallback


/datum/component/singing_item/RegisterWithParent()
	if(istype(parent, /obj/item/rogueweapon))
		RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(equipped))
		RegisterSignal(parent, COMSIG_ITEM_DROPPED_TURF, PROC_REF(dropped))
		RegisterSignal(parent, COMSIG_ITEM_PRE_ATTACK, PROC_REF(onattack))

/datum/component/singing_item/proc/equipped(obj/item/source, mob/user, slot)
	if(slot == ITEM_SLOT_HANDS)
		item_equipped_hands(source, user)

/datum/component/singing_item/proc/dropped(obj/item/source, mob/user)
	item_dropped(source, user)

/datum/component/singing_item/proc/item_equipped_hands(obj/item/source, mob/user)
	if(prob(20))
		say_weapon_line("equipped", user, source)

/datum/component/singing_item/proc/item_dropped(obj/item/source, mob/user)
	if(prob(20))
		say_weapon_line("dropped", user, source)

/datum/component/singing_item/proc/onattack(obj/item/source, atom/target, mob/user)
	if(prob(20))
		say_weapon_line("attack", user, source)

/datum/component/singing_item/proc/say_weapon_line(action, mob/user, obj/item/source)
	if(!personality || !GLOB.weapon_personality_dialog[personality])
		return

	var/list/dialogue_pool = list()

	if(user.real_name == weapon_owner)
		dialogue_pool = GLOB.weapon_personality_dialog[personality][action]
	else
		dialogue_pool = GLOB.weapon_personality_dialog[personality]["[action]_other"]

	if(dialogue_pool && length(dialogue_pool))
		var/message = pick(dialogue_pool)
		source.say(message)
	else if(action == "equipped_other" && !dialogue_pool)
		user.emote("- [source.name] glows faintly, resisting your touch.")
