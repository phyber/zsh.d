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
# Exit status of previous command
PROMPT='%(0?,,%{$fg[red]%}%?%{$reset_color%}:)'
# user@host
PROMPT+='%{$fg_bold[green]%}%n@%m%{$reset_color%}'
# VCS Info
PROMPT+='${vcs_info_msg_0_}'
# $ or # depending on shell privilege.
PROMPT+='%(!.#.$) '

# Selection prompt.
PROMPT3='%{$fg[yellow]%}Selection%{$reset_color%}: '

# Prompt on right shows CWD and vi key mode if we're using vi keybinds.
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
