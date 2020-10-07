/obj/
	name = "OBJ ERROR"
	icon = 'icons/debug/objs.dmi'
	icon_state = ""
	desc = "null"
	layer = OBJ_LAYER

	var/list/additional_blends

	var/should_save = TRUE

	var/under_tile = FALSE

	var/has_quick_function = FALSE
	var/quick_function_type =  FLAG_QUICK_INSTANT
	//FLAG_QUICK_INSTANT
	//FLAG_QUICK_TOGGLE

/obj/Destroy()

	if(additional_blends)
		for(var/blend_id in additional_blends)
			var/icon_blend/IB = additional_blends[blend_id]
			qdel(IB)
		additional_blends.Cut()

	loc = null
	return ..()


/obj/on_crush() //What happens when this object is crushed by a larger object.
	. = ..()
	qdel(src)
	return .