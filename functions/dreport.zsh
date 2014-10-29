# vim:ft=zsh:
# EnvVars:
#	DREPORT_MAIL_TO: Address to send the report to.

zmodload -aF zsh/datetime b:strftime p:EPOCHSECONDS

function _dreport_mail {
	local mutt==mutt 2>/dev/null
	if [[ $? != 0 ]]; then
		print -u 2 "mutt not found."
		return 1
	fi
	readonly mutt
	local -r to="$1"
	local -r subject="$2"
	local -r message_file="$3"

	# If mutt isn't executable, fail.
	if [ ! -x "${mutt}" ]; then
		print -u 2 "mutt not found or not executable."
		return 1
	fi

	# If To, Subject or MessageFile not given, fail.
	if [ -z "${to}" -o -z "${subject}" -o -z "${message_file}" ]; then
		print -u 2 "Must supply To, Subject and MessageFile"
		return 1
	fi

	# If the message file doesn't exist, fail.
	if [ ! -r "${message_file}" ]; then
		print -u 2 "MessageFile '${message_file}' does not exist."
		return 1
	fi

	# Brief output on what's being sent.
	print "To: ${to}"
	print "Subject: ${subject}"
	print "MessageFile: ${message_file}"

	# Send and return with mutts status code.
	${mutt} -s "${subject}" "${to}" -i "${message_file}"
	return $?
}

function _dreport_grep {
	grep -r --include="*.txt" --context=1 $@ "${DREPORT_DIR}"
	return $?
}

function dreport {
	if [[ -z "${DREPORT_DIR}" ]]; then
		print -u 2 "DREPORT_DIR environment variable not set."
		return 1
	fi

	# Special handling for grep argument.
	if [[ $1 == "grep" ]]; then
		shift
		_dreport_grep $@
		return $?
	fi

	local -a editors
	editors=('vim' 'nano' 'pico' 'emacs')
	typeset -r editors

	# Defaults, arrays have to be declared before setting.
	local -a o_mailto
	local -a o_subject
	local -a o_mailit
	local -a o_yesterday
	local -a o_help
	o_mailto=(-t "${DREPORT_MAIL_TO}")

	zparseopts -K -D -E -- \
		m=o_mailit \
		s:=o_subject \
		t:=o_mailto \
		y=o_yesterday \
		h=o_help
	if [[ $? != 0 || -n "$o_help" ]]; then
		echo ""
		echo "Usage: ${0##*/} [-h] [-m <user@example.org>] [-y]"
		echo "   -m: Mail the report."
		echo "   -s: Set the subject."
		echo "   -t: Set the To: address. Default: ${DREPORT_MAIL_TO}"
		echo "   -y: Operate on yesterday's report."
		echo ""
		echo "Calling with no arguments will open an editor on the"
		echo "daily dreports file."
		return
	fi

	# Timestamp to use.
	local now
	if [[ -z "$o_yesterday" ]]; then
		now=$EPOCHSECONDS
	else
		# Monday's are a special case, we'll use Friday's file if we
		# use -y on a Monday.
		if [[ $(strftime "%u" $EPOCHSECONDS) == 1 ]]; then
			now=$(($EPOCHSECONDS-(86400*3)))
		else
			now=$(($EPOCHSECONDS-86400))
		fi
	fi
	readonly now

	# File location and name.
	local -r week=$(strftime "%W" $now)
	local -r week_dir="${DREPORT_DIR}/${week}"
	local -r datestamp=$(strftime "%Y%m%d" $now)
	local -r filename="${datestamp}.txt"
	local -r dreport_txt="${week_dir}/${filename}"

	# To: and Subject:
	local -r to=$o_mailto[2]
	local subject=$o_subject[2]
	if [[ -z "$subject" ]]; then
		subject="DAILY REPORT ${datestamp}"
	fi
	readonly subject

	# Mail the thing if needed.
	if [[ -n "$o_mailit" ]]; then
		_dreport_mail "${to}" "${subject}" "${dreport_txt}"
		return $?
	fi

	# Create the weekly dir if needed.
	if [ ! -d "${week_dir}" ]; then
		mkdir -p "${week_dir}"
		if [ $? != 0 ]; then
			print -u 2 "Couldn't create ${week_dir}"
			return 1
		fi
	fi

	# If no $EDITOR is found, try to use a sensible one.
	if [ -z "${EDITOR}" ]; then
		for i in ${editors}; do
			editor=$(whence -p ${i})
			if [[ $? == 0 ]]; then
				EDITOR="${editor}"
				break
			fi
		done
	fi

	# Complain if EDITOR still empty or editor not executable.
	if [ -z "${EDITOR}" -o ! -x "${EDITOR}" ]; then
		print -u 2 "dreport requires a text editor."
		return 1
	fi

	${EDITOR} "${dreport_txt}"

	# Offer to mail report right away.
	local PROMPT3="Send report via email?: "
	local answer
	select answer in Yes No; do
		if [ "${answer}" = "Yes" ]; then
			dreport -m ${o_yesterday}
			return $?
		fi
		break
	done

	return 0
}
