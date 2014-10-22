# Environment variables.
#
HISTIGNORE='man:run-help'
typeset -T HISTIGNORE histignore # Tied array for easily checking HISTIGNORE

# BSD ls is different.
if [[ $OSTYPE == linux* ]]; then
	LS_OPTIONS='-F --group-directories-first'
fi
RLWRAP_BINS=(bc)

export PATH="${HOME}/.local/bin:${PATH}"

DREPORT_DIR="${HOME}/Docs/Reports"
export EDITOR==vim
export GREP_OPTIONS='--color'
export LC_COLLATE='C'

# Hide disclaimers in whois where possible.
export WHOIS_OPTIONS='-H'

if (( $+commands[lesspipe] )); then
	eval $(lesspipe)
fi
