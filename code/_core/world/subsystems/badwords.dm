#define BADWORDS "data/server/badwords.txt"

SUBSYSTEM_DEF(badwords)
	name = "Badwords Subsystem"
	desc = "Stores all the badwords for use in LIBERAL CENSORSHIP."
	priority = SS_ORDER_PRELOAD
	var/list/regex/bad_word_regex = list()

/subsystem/badwords/Initialize()

	if(fexists(BADWORDS))
		var/r_file = trim(file2text(BADWORDS))
		if(r_file)
			for(var/r_text in splittext(r_file,"\n"))
				bad_word_regex += regex(r_text,"i")
			log_subsystem(name,"Found bad words file and created a regex list of [length(bad_word_regex)] bad words.")
		else
			log_subsystem(name,"Found bad words file, but it was empty.")
	else
		log_subsystem(name,"Could not find a bad words file.")


	return ..()

/subsystem/badwords/proc/has_badword(var/text_to_check)

	if(!text_to_check || !length(bad_word_regex))
		return FALSE

	. = null

	for(var/regex/R in bad_word_regex)
		var/result = R.Find(text_to_check)
		if(result)
			. = result
			break

	return .