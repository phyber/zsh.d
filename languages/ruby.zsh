# Ruby related stuff.

# Add system ruby gems paths to PATH
# TODO: Only do this for the active version of ruby.
#_zshd_prepend_path ${HOME}/.gem/ruby/*/bin

# Add rbenv gems last so they appear in the PATH first.
if (( $+commands[rbenv] )); then
	_zshd_prepend_path "${HOME}/.rbenv/bin"
	eval "$(rbenv init -)"

	function update-rbenv {
		print "Updating rbenv"
		(
			cd "${HOME}/.rbenv"
			git pull --quiet
			return $?
		)
		if (( $? )); then
			print -u 2 "Couldn't update rbenv"
			return 1
		fi
		exec "${SHELL}"
	}
else
	function install-rbenv {
		local -r RBENV_URL='https://github.com/sstephenson/rbenv.git'

		print "Installing rbenv"

		git clone --quiet \
			"${RBENV_URL}" \
			"${HOME}/.rbenv"
		if (( $? )); then
			print -u 2 "Couldn't install rbenv"
			return 1
		fi

		print "rbenv installed."
		exec "${SHELL}"
	}
fi

# Hijack the gem command to setup rbenv shims and rehash PATH appropriately.
function gem {
	command gem $@
	if [ \
		"$1" == 'install' \
		-o "$1" == 'uninstall' \
		-o "$1" == 'update' \
	]; then
		if (( $+commands[rbenv] )); then
			rbenv rehash
		fi
		hash -r
	fi
}
