/**
 * Multitool -- A multitool is used for hacking electronic devices.
 * TO-DO -- Using it as a power measurement tool for cables etc. Nannek.
 *
 */

/obj/item/device/multitool
	name = "multitool"
	desc = "Used for pulsing wires to test which to cut. Not recommended by doctors."
	icon_state = "multitool"
	flags = CONDUCT
	force = 5.0
	w_class = ITEMSIZE_SMALL
	throwforce = 5.0
	throw_range = 15
	throw_speed = 3
	desc = "You can use this on airlocks or APCs to try to hack them without cutting wires."

	matter = list(DEFAULT_WALL_MATERIAL = 50,"glass" = 20)

	var/mode_index = 1
	var/toolmode = MULTITOOL_MODE_STANDARD
	var/list/modes = list(MULTITOOL_MODE_STANDARD, MULTITOOL_MODE_INTCIRCUITS)

	origin_tech = list(TECH_MAGNET = 1, TECH_ENGINEERING = 1)
	var/obj/machinery/telecomms/buffer // simple machine buffer for device linkage
	var/obj/machinery/clonepod/connecting //same for cryopod linkage
	var/obj/machinery/connectable	//Used to connect machinery.
	var/weakref_wiring //Used to store weak references for integrated circuitry. This is now the Omnitool.
	toolspeed = 1

/obj/item/device/multitool/attack_self(mob/living/user)
	var/choice = alert("What do you want to do with \the [src]?","Multitool Menu", "Switch Mode", "Clear Buffers", "Cancel")
	switch(choice)
		if("Cancel")
			to_chat(user,"<span class='notice'>You lower \the [src].</span>")
			return
		if("Clear Buffers")
			to_chat(user,"<span class='notice'>You clear \the [src]'s memory.</span>")
			buffer = null
			connecting = null
			connectable = null
			weakref_wiring = null
			accepting_refs = 0
			if(toolmode == MULTITOOL_MODE_INTCIRCUITS)
				accepting_refs = 1
		if("Switch Mode")
			mode_switch(user)

	update_icon()

	return ..()

/obj/item/device/multitool/proc/mode_switch(mob/living/user)
	if(mode_index >= modes.len)
		mode_index = 1
	else
		mode_index++

	toolmode = modes[mode_index]
	to_chat(user,"<span class='notice'>\The [src] is now set to [toolmode].</span>")

	if(toolmode != MULTITOOL_MODE_INTCIRCUITS)
		accepting_refs = 0
	else
		accepting_refs = 1

	return

/obj/item/device/multitool/cyborg
	name = "multitool"
	desc = "Optimised and stripped-down version of a regular multitool."
	toolspeed = 0.5

/obj/item/device/multitool/alien
	name = "alien multitool"
	desc = "An omni-technological interface."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "multitool"
	toolspeed = 0.1
	origin_tech = list(TECH_MAGNET = 5, TECH_ENGINEERING = 5)
