# Environment variables.
#
HISTIGNORE='man:run-help'
typeset -gT HISTIGNORE histignore # Tied array for easily checking HISTIGNORE

# Handle some Linux/BSD differences here.
case "$OSTYPE" in
	linux*)
		LS_OPTIONS='-F --group-directories-first'
		;;
	freebsd*|darwin*)
		export CLICOLOR=1
		export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
		export TOP="-a -j"
		LS_OPTIONS='-F'

		# Fix help.
		unalias run-help
		autoload run-help

		# Executes a local install of ZSH if there is one, otherwise
		# continues to use system zsh
		_zshd_exec_usr_local_bin_zsh
		;;
	*)
		;;
esac

if (( $+commands[rlwrap] )); then
	RLWRAP_BINS=(bc)
fi

DREPORT_DIR="${HOME}/Docs/Reports"

# Setting this to 'vi' enables vi keybinds, anything else results in emacs.
ZSHD_KEYMAP="emacs"

# Directory where syntax highlight plugin is installed/to be installed.
ZSHD_SYNTAX_HIGHLIGHT_DIR="${HOME}/.zshsh"

# Sometimes we might not have vim installed. Redirect error output.
if (( $+commands[vim] )); then
	export EDITOR==vim
fi
export GREP_OPTIONS='--color'
export LC_COLLATE='C'
export LESS='-R'

# Hide disclaimers in whois where possible.
export WHOIS_OPTIONS='-H'

# Enable lesspipe if it is present.
if (( $+commands[lesspipe] )); then
	eval $(lesspipe)
fi
if (( $+commands[lesspipe.sh] )); then
	eval $(lesspipe.sh)
fi

if (( $+commands[manpath] )); then
	export MANPATH=$(manpath 2>/dev/null)
fi
