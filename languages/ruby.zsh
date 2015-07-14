# Ruby related stuff.

# Add system ruby gems paths to PATH
# TODO: Only do this for the active version of ruby.
_zshd_prepend_path ${HOME}/.gem/ruby/*/bin

# Add rbenv gems last so they appear in the PATH first.
if (( $+commands[rbenv] )); then
	_zshd_prepend_path "${HOME}/.rbenv/bin"
	eval "$(rbenv init -)"
fi
