# Ruby related stuff.

# Add system ruby gems paths to PATH
# TODO: Only do this for the active version of ruby.
#_zshd_prepend_path ${HOME}/.gem/ruby/*/bin

# Add rbenv gems last so they appear in the PATH first.
if [ -x "${ZSHD_RBENV_DIR}/bin/rbenv" ]; then
	_zshd_prepend_path "${HOME}/.rbenv/bin"
	eval "$(rbenv init -)"
else
	function install-rbenv {
		local -r RBENV_URL='https://github.com/rbenv/rbenv.git'

		_zshd_git_install \
			'rbenv' \
			"${RBENV_URL}" \
			"${ZSHD_RBENV_DIR}"

		local plugin
		for plugin (${(@)ZSHD_RBENV_PLUGINS}) {
			install-rbenv-plugin "${plugin}"
		}

		[[ $? == 0 ]] && exec "${SHELL}"
	}
fi

function install-rbenv-plugin {
	local -r plugin="$1"

	_zshd_git_install \
		"rbenv-plugin:${plugin}" \
		"https://github.com/${plugin}.git" \
		"${ZSHD_RBENV_DIR}/plugins/${plugin##*/}"

	return $?
}
