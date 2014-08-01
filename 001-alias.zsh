# Colours for ls command
if [[ "${TERM}" != "dumb" ]]; then
	if (( $+commands[dircolors] )); then
		eval $(dircolors -b)
		alias ls="ls $LS_OPTIONS --color=auto"
	else
		alias ls="ls $LS_OPTIONS"
	fi
fi

# Force aptitude to the width of $COLUMNS.
# Useful when piping to a pager
if (( $+commands[aptitude] )); then
	alias aptitude='aptitude -w $COLUMNS'
fi

# Use colordiff instead of diff if present
if (( $+commands[colordiff] )); then
	alias diff='colordiff'
fi

# Use pinfo instead of info if present
if (( $+commands[pinfo] )); then
	alias info='pinfo'
fi

if (( $+commands[bpython] )); then
	alias bpython='bpython -q'
fi

# Docker is docker.io on Debian, alias it back to docker.
if (( $+commands[docker.io] )); then
	alias docker='docker.io'
fi

# Aliases that are readline wrapped.
function {
	if (( $+commands[rlwrap] )); then
		local bin
		for bin in $RLWRAP_BINS; do
			alias ${bin}="rlwrap -H ${HOME}/.${bin}_history ${bin}"
		done
	fi
}

# Sane history alias.
# Prints index, date, time, command.
alias history='fc -dil 1'
