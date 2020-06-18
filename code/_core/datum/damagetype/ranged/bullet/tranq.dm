/damagetype/ranged/bullet/tranq
	name = "tranq bullet"

	stealthy = TRUE

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 40
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 50
	)

	falloff = VIEW_RANGE

	crit_multiplier = 3

/damagetype/ranged/bullet/tranq/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	. = ..()

	if(total_damage_dealt && victim.health && is_living(victim))
		var/mob/living/L = victim
		if(L.health.stamina_current <= total_damage_dealt)
			if(L.ckey_last)
				L.add_status_effect(SLEEP,300,300) //30 seconds of sleep
			else
				L.add_status_effect(SLEEP,600,600) //1 minute of sleep

	return .

/damagetype/ranged/bullet/tranq/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return istype(hit_object,/obj/item/organ/head)