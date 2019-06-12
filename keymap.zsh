# ZLE keymap

if [ "$ZSHD_KEYMAP" = "vi" ]; then
    bindkey -v	# vi key mode
else
    bindkey -e	# EMACS key mode
fi

# Bind home/end on a Mac.
case "$OSTYPE" in
    darwin*|freebsd*)
        bindkey '^[[H' beginning-of-line
        bindkey '^[[F' end-of-line
        bindkey '^[[1~' beginning-of-line
        bindkey '^[[4~' end-of-line
        ;;
    *)
        bindkey "${terminfo[khome]}" beginning-of-line
        bindkey "${terminfo[kend]}" end-of-line
        bindkey "${terminfo[kdch1]}" delete-char
        ;;
esac

bindkey '^[[Z' reverse-menu-complete

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
    bindkey -M viins '^[[A' up-line-or-history
    bindkey -M viins '^[[B' down-line-or-history
    bindkey -M viins '^[OA' up-line-or-history
    bindkey -M viins '^[OB' down-line-or-history
fi

# Adds a space after the command line when browsing up/down in history.
#function space-after-up-line-or-history {
#	# Call original
#	zle _zshrc_original_up-line-or-history
#	#zle .up-line-or-history
#	if [[ "${BUFFER[-1]}" != ' ' ]]; then
#		RBUFFER+=" "
#		zle end-of-line
#	fi
#}
#zle -A up-line-or-history _zshrc_original_up-line-or-history
#zle -N up-line-or-history space-after-up-line-or-history
