autoload -Uz add-zsh-hook

# Sets the title while sitting at the command prompt.
function _settermtitle_precmd {
	settermtitle "${HOST%%.*}"
}

# Set the terminal title before executing a command
function _settermtitle_preexec {
	local -r user_cmd="$1"
	local -r expanded_truncated_cmd="$2"
	local -r expanded_full_cmd="$3"
	local -r user_cmd_only="${user_cmd%% *}"
	#echo "1: $1, 2: $2, 3: $3\n"
	settermtitle "${user_cmd}"
}

# Set terminal title
function settermtitle {
	# FIXME: Shouldn't do this if term doesn't support it.
	local -r title="$1"
	case $TERM in
	linux)
		;;
	*)
		print -u 2 -n -f '\033]2;%s\033\\' "${title}"
		;;
	esac
}

# Hook above functions into 'precmd' and 'preexec'
add-zsh-hook precmd _settermtitle_precmd
add-zsh-hook preexec _settermtitle_preexec
