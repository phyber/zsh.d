# Ruby related stuff.

# Add system ruby gems paths to PATH
# TODO: Only do this for the active version of ruby.
#_zshd_prepend_path ${HOME}/.gem/ruby/*/bin

# Add rbenv gems last so they appear in the PATH first.
if [ -x "${ZSHD_RBENV_DIR}/bin/rbenv" ]; then
	_zshd_prepend_path "${HOME}/.rbenv/bin"
	eval "$(rbenv init -)"

	function update-rbenv {
		_zshd_git_update \
			'rbenv' \
			"${ZSHD_RBENV_DIR}"

		[[ $? == 0 ]] && exec "${SHELL}"
	}
else
	function install-rbenv {
		local -r RBENV_URL='https://github.com/sstephenson/rbenv.git'

		_zshd_git_install \
			'rbenv' \
			"${RBENV_URL}" \
			"${ZSHD_RBENV_DIR}"

		[[ $? == 0 ]] && exec "${SHELL}"
	}
fi

if [ -d "${ZSHD_RUBYBUILD_DIR}" ]; then
	function update-ruby-build {
		_zshd_git_update \
			'ruby-build' \
			"${ZSHD_RUBYBUILD_DIR}"

		[[ $? == 0 ]] && exec "${SHELL}"
	}
else
	function install-ruby-build {
		local -r RUBY_BUILD_URL='https://github.com/sstephenson/ruby-build.git'

		_zshd_git_install \
			'ruby-build' \
			"${RUBY_BUILD_URL}" \
			"${ZSHD_RUBYBUILD_DIR}"

		[[ $? == 0 ]] && exec "${SHELL}"
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
