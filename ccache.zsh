# vim:ft=zsh:

# Should be the same on most systems
export CCACHE_PATH="/usr/bin:/usr/local/bin"

# ccache libexec location changes.
case "$OSTYPE" in
	linux*)
		_zshd_prepend_path "/usr/lib/ccache"
		;;
	freebsd*)
		_zshd_prepend_path "/usr/local/libexec/ccache"
		;;
	darwin*)
		# ccache installed via brew.
		_zshd_prepend_path "/usr/local/opt/ccache/libexec"
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
