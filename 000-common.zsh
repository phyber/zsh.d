# vim:ft=zsh:

# Common commands used by other functions.

# If one of the commands given as an argument is missing, returns 1, else 0.
function _zshd_check_cmd {
	local cmd
	for cmd in $@; do
		if (( ! $+commands[$cmd] )); then
			print -u 2 "Error: $cmd not found."
			return 1
		fi
	done
	return 0
}

# Checks if there is an executable local zsh, and execs it if there is and it's
# not the current shell. Relies upon $SHELL being accurate.
function _zshd_exec_usr_local_bin_zsh {
	local -r local_zsh="/usr/local/bin/zsh"
	if [ ! -x $local_zsh ]; then
		return
	fi

	if [ $SHELL != $local_zsh ]; then
		export SHELL="$local_zsh"
		exec $SHELL
	fi
}

# Checks if we currently have root privileges. Returns 0 if so, !0 otherwise.
function _zshd_is_root {
	[[ $UID == 0 || $EUID == 0 ]]
	return $?
}
