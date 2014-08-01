# Load SSH keychain with all keys found in ~/.ssh
if (( $+commands[keychain] )); then
	function {
		local -r keychain_file="${HOME}/.keychain/${HOST}-sh"
		keychain --quiet \
			--nogui \
			--host "${HOST}" ${HOME}/.ssh/*.pub(:r)
		if [[ -f ${keychain_file} ]]; then
			source ${keychain_file}
		fi
	}
fi
