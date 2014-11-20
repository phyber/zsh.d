# Coloured man pages

if (( ! $+commands[man] )); then
	return
fi

function man {
	emulate -L zsh
	LESS_TERMCAP_mb=$fg_bold[red] \
	LESS_TERMCAP_md=$fg_bold[red] \
	LESS_TERMCAP_me=$reset_color \
	LESS_TERMCAP_se=$reset_color \
	LESS_TERMCAP_so=$bg[blue]$fg_bold[yellow] \
	LESS_TERMCAP_ue=$reset_color \
	LESS_TERMCAP_us=$fg_bold[green] \
	command man "$@"
}
