autoload -Uz add-zsh-hook

# Prevent commands in HISTIGNORE from appearing in the history.
# HISTIGNORE is set in 000-environment.zsh
function ignore_command_history {
	emulate -L zsh
	local line=${1%%$'\n'}
	local cmd=${line%% *}

	if (( $+histignore[(r)${cmd}] )); then
		return 1
	fi
}

# Hook above function into 'zshaddhistory'
add-zsh-hook zshaddhistory ignore_command_history
