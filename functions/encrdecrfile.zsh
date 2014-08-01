if (( $+commands[openssl] )); then
	# Encrypt/decrypt files with openssl
	# Shouldn't be used at all and was just for testing various bits of
	# ZSH scripting.
	function encrfile decrfile {
		local -r fnamein="$1"
		local fnameout="$2"
		local inplace=false

		if [[ -z "${fnameout}" ]]; then
			inplace=true
			fnameout=$(mktemp)
		fi
		readonly fnameout

		if [[ -z "${fnamein}" ]]; then
			print "Usage: $0 <in file> [out file]"
			print -n "If [out file] is not given, encryption/decryption will be performed in-place."
			return 1
		fi

		# Make sure input file exists
		if [[ ! -f "${fnamein}" ]]; then
			print "Error: ${fnamein} doesn't exist."
			return 1
		fi

		# Warn about overwriting files and present menu for user.
		if [[ -f "${fnameout}" && ${inplace}  == false ]]; then
			print "Warning: ${fnameout} already exists, continue?"
			select answer in Yes No; do
				if [[ "${answer:l}" == "no" ]]; then
					return
				elif [[ "${answer:l}" == "yes" ]]; then
					break
				fi
			done
		fi

		case "$0" in
			encrfile)
				openssl aes-256-cbc \
					-e -salt \
					-in "${fnamein}" \
					-out "${fnameout}"
				;;
			decrfile)
				openssl aes-256-cbc \
					-d -salt \
					-in "${fnamein}" \
					-out "${fnameout}"
				;;
		esac

		# openssl command failed. Remove output file
		if (( $? )); then
			rm "${fnameout}"
			return
		fi

		# If we're operating in-place, then move the tmpfile into
		# place.
		if (( $inplace )); then
			mv "${fnameout}" "${fnamein}"
		fi
	}
fi
