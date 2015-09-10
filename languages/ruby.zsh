# Ruby related stuff.

# Add system ruby gems paths to PATH
# TODO: Only do this for the active version of ruby.
#_zshd_prepend_path ${HOME}/.gem/ruby/*/bin

# Add rbenv gems last so they appear in the PATH first.
if (( $+commands[rbenv] )); then
	_zshd_prepend_path "${HOME}/.rbenv/bin"
	eval "$(rbenv init -)"
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
