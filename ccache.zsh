# vim:ft=zsh:

if (( ! $+commands[ccache] )); then
	return
fi

# Should be the same on most systems
export CCACHE_PATH="/usr/bin:/usr/local/bin"

# ccache libexec location changes.
case "$OSTYPE" in
	linux*)
		export PATH="/usr/lib/ccache:$PATH"
		;;
	freebsd*)
		export PATH="/usr/local/libexec/ccache:$PATH"
		;;
	*)
		;;
esac
