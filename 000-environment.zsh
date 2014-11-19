# Environment variables.
#
HISTIGNORE='man:run-help'
typeset -T HISTIGNORE histignore # Tied array for easily checking HISTIGNORE

# Handle some Linux/BSD differences here.
case "$OSTYPE" in
	linux*)
		LS_OPTIONS='-F --group-directories-first'
		;;
	*bsd*)
		export CLICOLOR=1
		LS_OPTIONS='-F'
		;;
	*)
		;;
esac
RLWRAP_BINS=(bc)

DREPORT_DIR="${HOME}/Docs/Reports"

# Setting this to 'vi' enables vi keybinds, anything else results in emacs.
ZSHD_KEYMAP="emacs"

# Sometimes we might not have vim installed. Redirect error output.
if (( $+commands[vim] )); then
	export EDITOR==vim
fi
export GREP_OPTIONS='--color'
export LC_COLLATE='C'

# Hide disclaimers in whois where possible.
export WHOIS_OPTIONS='-H'

# Enable lesspipe if it is present.
if (( $+commands[lesspipe] )); then
	eval $(lesspipe)
fi
