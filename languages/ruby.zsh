# Ruby related stuff.

if (( $+commands[rbenv] )); then
	_zshd_prepend_path "${HOME}/.rbenv/bin"
	eval "$(rbenv init -)"
fi

# Add local ruby gems paths to PATH
# TODO: Only do this for the active version of ruby.
local p
for p in ${HOME}/.gem/ruby/*; do
	_zshd_prepend_path $p
done
