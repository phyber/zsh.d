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

# Ensure that each entry in PATH is unique
typeset -U PATH
export PATH="${HOME}/.local/bin:${PATH}"

# Ensure uniqueness of LD_LIBRARY_PATH entries.
typeset -T LD_LIBRARY_PATH ld_library_path
typeset -U LD_LIBRARY_PATH

typeset -U FPATH
fpath+="${HOME}/.zsh.d/autoload"

# Pager for the null command. READNULLCMD gets trashed on Debian by
# /etc/zsh/zshrc which is read later. So we must set READNULLCMD through
# PAGER which is used in /etc/zsh/zshrc
PAGER=${PAGER:-=less}
export PAGER
READNULLCMD="${PAGER}"
