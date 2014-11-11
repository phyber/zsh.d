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
function pip {
	if [[ -n "${VIRTUAL_ENV}" ]]; then
		# If inside a virtual env, execute pip normally.
		command pip $@
	else
		# Install things to user location by default.
		PIP_USER=1 command pip $@
	fi
}
