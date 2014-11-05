# ptrhost looks up the nameserver responsible for providing PTR records for a
# given IP address. It requires either the dig or host command.

# _ptrhost_find_command finds the first available DNS tool and returns its
# path.
function _ptrhost_find_command {
	local -a dnstools
	dnstools=("dig" "host")
	typeset -r dnstools
	local tool
	for i in ${dnstools}; do
		tool==${i}
		if [[ $? == 0 ]]; then
			echo "${tool}"
			return 0
		fi
	done
	return 1
}

function ptrhost {
	# :r removes the last octet, since it isn't needed.
	local -r ip="${1:r}"
	if [[ -z "${ip}" ]]; then
		print -u 2 "Usage: $0 IP-ADDRESS"
		return 1
	fi

	local -a octet
	octet=("${(s/./)ip}")
	local -r lookup="${octet[3]}.${octet[2]}.${octet[1]}.in-addr.arpa"

	local -r cmd=$(_ptrhost_find_command)
	if [[ $? != 0 ]]; then
		return 1
	fi

	$cmd -t NS "${lookup}"
}
