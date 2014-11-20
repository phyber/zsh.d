# Some functions/aliases to help with being a linux user on freebsd.

if [[ "$OSTYPE" != freebsd* ]]; then
	return
fi

function {
	# Associative array of linux commands and their freebsd
	# equivalents.
	local -A equivalent
	equivalent=(
		free vmstat
		lspci pciconf
	)
	readonly equivalent

	local cmd
	local bsdcmd
	for cmd ("${(@k)equivalent}") {
		bsdcmd="${equivalent[$cmd]}"
		eval "function $cmd {
			print -u 2 'Nope: $bsdcmd'
			return 1
		}"
	}
}
