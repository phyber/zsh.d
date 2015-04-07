# Ruby related stuff.

if (( $+commands[rbenv] )); then
	export PATH="${HOME}/.rbenv/bin:${PATH}"
	eval "$(rbenv init -)"
fi

# Add local ruby gems paths to PATH
# TODO: Only do this for the active version of ruby.
local p
for p in ${HOME}/.gem/ruby/*; do
	export PATH="$p/bin:$PATH"
done
