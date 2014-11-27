# Python related doodads.

# pip zsh completion start
function _pip_completion {
	local words cword
	read -Ac words
	read -cn cword
	reply=( $( COMP_WORDS="$words[*]" \
		COMP_CWORD=$(( cword-1 )) \
		PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip

# This makes pip install in usermode outside of virtualenvs but doesn't touch
# the options inside a virtualenv.
# Implemented because: Why would pip try to install things globally when
# running as a normal user?!
function {
	# Finds valid pip commands and adds them to pipcmds array.
	local -a pipcmds
	local cmd
	for cmd ("pip" "pip2" "pip3") {
		if (( $+commands[$cmd] )); then
			pipcmds+="$cmd"
		fi
	}
	readonly pipcmds

	# Don't bother continuing if there are no pip commands.
	if (( ! ${#pipcmds} )); then
		return
	fi

	function $pipcmds {
		if [[ -n "${VIRTUAL_ENV}" ]]; then
			# If inside a virtual env, execute pip normally.
			command $0 $@
		else
			# Install things to user location by default.
			PIP_USER=1 command $0 $@
		fi
	}
}

if (( $+commands[bpython] )); then
	alias bpython='bpython -q'
fi
