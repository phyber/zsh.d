autoload -Uz add-zsh-hook

# Prevent commands in HISTIGNORE from appearing in the history.
# HISTIGNORE is set in 000-environment.zsh
function _zshaddhistory_ignore_command {
	emulate -L zsh
	local -r line=${1%%$'\n'}
	local -r cmd=${line%% *}

	if (( $+histignore[(r)${cmd}] )); then
		return 1
	fi
}

# Hook above function into 'zshaddhistory'
add-zsh-hook zshaddhistory _zshaddhistory_ignore_command
