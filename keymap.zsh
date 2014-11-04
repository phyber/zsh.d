# ZLE keymap

if [ "$ZSHD_KEYMAP" != "vi" ]; then
	bindkey -e			# EMACS key mode
	return
fi

bindkey -v			# vi key mode

# If we're started with the vi keymap, enable some extra things.
if [[ ${$(bindkey -lL main):2:1} == 'viins' ]]; then
	vi_key_mode=' -- INSERT --'
	function zle-line-init zle-line-finish zle-keymap-select {
		case "$0" in
			zle-line-init|zle-line-finish)
				vi_key_mode=' -- INSERT --'
				;;
			zle-keymap-select)
				case "$KEYMAP" in
					vicmd)
						vi_key_mode=' -- NORMAL --'
						;;
					viins|main)
						vi_key_mode=' -- INSERT --'
						;;
				esac
				zle reset-prompt
				;;
		esac
	}
	zle -N zle-line-init
	zle -N zle-line-finish
	zle -N zle-keymap-select
	# Default Debian zshrc sets these to silly mode.
	bindkey -M viins "\e[A" up-line-or-history
	bindkey -M viins "\e[B" down-line-or-history
	bindkey -M viins "\eOA" up-line-or-history
	bindkey -M viins "\eOB" down-line-or-history
fi
