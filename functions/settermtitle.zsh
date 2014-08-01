autoload -Uz add-zsh-hook

# Set terminal title
function settermtitle {
	# FIXME: Shouldn't do this if term doesn't support it.
	if [[ $TERM != "linux" ]]; then
		local -r title="$1"
		printf '\033]2;%s\033\\' "${title}"
	fi
}

# Sets the title while sitting at the command prompt.
function _stt_precmd {
	settermtitle "${HOST%%.*}"
}

# Set the terminal title before executing a command
function _stt_preexec {
	local -r user_cmd="$1"
	local -r expanded_truncated_cmd="$2"
	local -r expanded_full_cmd="$3"
	local -r user_cmd_only="${user_cmd%% *}"
	#echo "1: $1, 2: $2, 3: $3\n"
	settermtitle "${user_cmd}"
}

# Hook above functions into 'precmd' and 'preexec'
add-zsh-hook precmd _stt_precmd
add-zsh-hook preexec _stt_preexec
