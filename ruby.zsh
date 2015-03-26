# Ruby related stuff.

if (( $+commands[rbenv] )); then
	export PATH="${HOME}/.rbenv/bin:${PATH}"
	eval "$(rbenv init -)"
fi
