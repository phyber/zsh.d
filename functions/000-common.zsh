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
