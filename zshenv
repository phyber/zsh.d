####
# Environment
####
## ZSH Dirstack
DIRSTACKSIZE=16

## ZSH history
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=1000
SAVEHIST=10000

## ZSH Prompt
PROMPT='%(0?,,%{$fg[red]%}%?%{$reset_color%}:)%{$fg_bold[green]%}%n@%m%{$reset_color%}${vcs_info_msg_0_}%(!.#.$) '
PROMPT3='%{$fg[yellow]%}Selection%{$reset_color%}: '
RPROMPT='%{$fg_bold[blue]%}%~%{$reset_color%}$vi_key_mode'

typeset -U PATH # Ensure that each entry in PATH is unique
export PATH="${HOME}/.local/bin:${PATH}"

typeset -U FPATH
fpath+="${HOME}/.zsh.d/autoload"

# Pager for the null command. READNULLCMD gets trashed on Debian by
# /etc/zsh/zshrc which is read later. So we must set READNULLCMD through
# PAGER which is used in /etc/zsh/zshrc
PAGER=${PAGER:-=less}
export PAGER
READNULLCMD="${PAGER}"
