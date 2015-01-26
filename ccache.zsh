# vim:ft=zsh:

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

# If we're root, store ccache in /var.
if _zshd_is_root; then
	export CCACHE_DIR="/var/cache/ccache"
	if [[ ! -d "${CCACHE_DIR}" ]]; then
		mkdir -m 0700 "${CCACHE_DIR}"
	fi
fi
