# Functions related to tmux management.

# Don't bother creating functions if tmux isn't installed.
if (( ! $+commands[tmux] )); then
	return
fi

# tmux attach-session
function ta {
	local -r session_name="$1"

	tmux has-session 2>/dev/null
	local -r has_session="$?"

	if [ $has_session != 0 ]; then
		print -u 2  "No sessions to attach to."
		return $has_session
	fi

	if [ -z "${session_name}" ]; then
		tmux attach-session
	else
		tmux attach-session -t "${session_name}"
	fi
}

# tmux detach-client
function td {
	local -r session_name="$1"

	tmux has-session 2>/dev/null
	local -r has_session="$?"

	if [ $has_session != 0 ]; then
		print -u 2 "Nothing to detach."
		return $has_session
	fi

	if [ -z "${session_name}" ]; then
		tmux detach-client
	else
		tmux detach-client -t "${session_name}"
	fi
}

# tmux new-session
function tn {
	local -r session_name="$1"

	if [ -z "${session_name}" ]; then
		tmux new-session
	else
		tmux new-session -s "${session_name}"
	fi
}

# tmux rename-session
function trs {
	local target_session
	local new_name
	local -a arguments
	local -r nargs="${#@}"

	case "${nargs}" in
		1)
			new_name="$1"
			arguments=($new_name)
			;;
		2)
			target_session="$1"
			new_name="$2"
			arguments=("-t" "${target_session}" "${new_name}")
			;;
		*)
			print -u 2 "Usage: $0 [target-session] new-name"
			return 1
			;;
	esac

	readonly new_name
	readonly target_session
	readonly arguments

	tmux rename-session $arguments
}
