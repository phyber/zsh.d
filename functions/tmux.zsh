# Functions related to tmux management.

# Helper functions.
function _zshd_tmux_has_session {
	tmux has-session 2>/dev/null
	return $?
}

function _zshd_tmux_within {
	[ -n "$TMUX" ]
	return $?
}

# tmux attach-session
function ta {
	_zshd_check_cmd "tmux" || return $?

	local -r session_name="$1"

	if [ _zshd_tmux_has_session != 0 ]; then
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
	_zshd_check_cmd "tmux" || return $?

	local -r session_name="$1"

	if [ _zshd_tmux_has_session != 0 ]; then
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
# Creates a new session. If an argument is given, that is used as the session
# name.
function tn {
	_zshd_check_cmd "tmux" || return $?

	local -r session_name="$1"

	if [ -z "${session_name}" ]; then
		tmux new-session
	else
		tmux new-session -s "${session_name}"
	fi
}

# tmux rename-session
# Renames a session.
function trs {
	_zshd_check_cmd "tmux" || return $?

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

# tmux split-window
# Automatically splits the window in an appropriate direction.
function tsw {
	_zshd_check_cmd "tmux" || return $?

	if [ ! _zshd_tmux_within ]; then
		print -u 2 "tsw only works from within tmux."
		return 1
	fi

	# Have to take multiple steps here to prevent "local" interpreting
	# arguments to cmd.
	local cmd
	cmd="${@}"
	readonly cmd

	local -a ps
	ps=($(tmux list-panes -F "#{pane_active} #{pane_width} #{pane_height}" \
		| awk '{ if ($1 == 1) { print int($2/2)" "$3; } }'
		))
	readonly ps

	# Width is halved in the awk command above, height not touched.
	local -r half_width=${ps[1]}
	local -r height=${ps[2]}

	local split_type
	if [ $half_width -gt $height ]; then
		# Horizontal
		split_type="-h"
	else
		# Vertical
		split_type="-v"
	fi
	readonly split_type

	if [ -z "${cmd}" ]; then
		tmux split-window $split_type
	else
		tmux split-window $split_type "${cmd}"
	fi
}
