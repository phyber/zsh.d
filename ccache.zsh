# vim:ft=zsh:

if (( ! $+commands[ccache] )); then
	return
fi

case "$OSTYPE" in
	linux*)
		PATH="/usr/lib/ccache:$PATH"
		;;
	freebsd*)
		PATH="/usr/local/libexec/ccache:$PATH"
		;;
	*)
		;;
esac
