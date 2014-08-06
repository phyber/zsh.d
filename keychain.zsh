# Load SSH keychain with all keys found in ~/.ssh
if (( $+commands[keychain] )); then
	function {
		local -r keychain_file="${HOME}/.keychain/${HOST}-sh"
		local timeout=$KEYCHAIN_TIMEOUT_MINS
		if [[ -z "$timeout" ]]; then
			timeout=0	# 0 = cache forever.
		fi
		readonly timeout

		keychain --quiet \
			--nogui \
			--timeout $timeout \
			--host "${HOST}" ${HOME}/.ssh/*.pub(:r)

		if [[ -f ${keychain_file} ]]; then
			source ${keychain_file}
		fi
	}
fi
