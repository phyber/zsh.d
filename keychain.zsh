# Load SSH keychain with all keys found in ~/.ssh if keychain command exists.

if (( ! $+commands[keychain] )); then
	return
fi

function {
	local -r keychain_file="${HOME}/.keychain/${HOST}-sh"
	local timeout=$KEYCHAIN_TIMEOUT_MINS
	if [[ -z "$timeout" ]]; then
		timeout=()	# 0 = cache forever.
	else
		timeout=("--timeout" "$timeout")
	fi
	readonly timeout

	keychain --quiet \
		--nogui \
		$timeout \
		--host "${HOST}" \
		${HOME}/.ssh/*.pub(:r)

	if [[ -f ${keychain_file} ]]; then
		source ${keychain_file}
	fi
}
