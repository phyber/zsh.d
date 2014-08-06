# Environment variables.
#
HISTIGNORE='man:run-help'
typeset -T HISTIGNORE histignore # Tied array for easily checking HISTIGNORE

LS_OPTIONS='-F --group-directories-first'
RLWRAP_BINS=(bc)

export PATH="${HOME}/.local/bin:${PATH}"

export EDITOR==vim
export GREP_OPTIONS='--color'
export KEYCHAIN_TIMEOUT_MINS=$((8 * 60))	# 8 hour timeout for keychain.
export LC_COLLATE='C'

# Hide disclaimers in whois where possible.
export WHOIS_OPTIONS='-H'

if (( $+commands[lesspipe] )); then
	eval $(lesspipe)
fi
