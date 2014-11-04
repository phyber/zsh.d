# Searches for given text in man pages and outputs nicely like apropos
# Requires the 'man' and 'whatis' commands.
if (( $+commands[man] && $+commands[whatis] )); then
	function manhunt {
		emulate -L zsh
		local -r search_term="$1"
		local -a seenpages
		local manpage
		while read manpage; do
			# Searching man pages can result in duplicates, so we
			# check if we've already shown this manpage.
			if (( $+seenpages[(r)${manpage}] )); then
				continue
			fi

			# :t -> basename
			# :r -> remove extension
			# :e -> remove parts before extension.
			local section="${manpage:t:r:e}"
			local pagename="${manpage:t:r:r}"
			whatis -s "${section}" "${pagename}"

			# Add this manpage to our list of already seen
			# manpages.
			seenpages+=("${manpage}")
		done < <(man -w -K "${search_term}")
	}
fi
