# Completion
autoload -Uz compinit && compinit

####
# :completion:function:completer:command:argument:tag
####
# Use cache so that complicated completions run faster
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${HOME}/.zsh_compcache

# General completion ignores for all commands
zstyle ':completion:*:(all-|)files' ignored-patterns \
	'*\~' '(|*/)(.git|.svn|CVS)'

# Completion ignores for vim
zstyle ':completion:*:complete:vim:*' ignored-patterns \
	'*\~' \
	'(|*/)(.git|.svn|CVS)' \
	'*.pyc' '*.o'

# Ignore executable files when completing for vim.
#zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*(*)'
# Completion ignores for commands (files marked executable)
zstyle ':completion:*:complete:-command-:*' ignored-patterns '*\~'
zstyle ':completion:*:-command-:*:' verbose false

# Don't tab complete zsh _* functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# Colours during tab completion
# (s.:.) splits at the : during parameter expansion.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Menu for completions
zstyle ':completion:*' menu yes select=10

# Command used to get processes for kill command completion, etc.
#zstyle ':completion:*:processes' command \
#	'ps -U ${USER} xopid,%cpu,%mem,vsz,rss,tname,stat,start_time,time,command'
zstyle ':completion:*:processes' command 'ps ux'
