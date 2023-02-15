zstyle :compinstall filename ${HOME}/.zshrc
####
# Modules
####
# Colours for prompt
autoload -Uz colors && colors

####
# ZSH Options
####
source "${HOME}/.zsh.d/zsh_options"

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

# Load broken-out configuration.
function {
    if [[ -d "${HOME}/.zsh.d" ]]; then
        local f
        # Find all readable .zsh files under ~/.zsh.d
        for f in ${HOME}/.zsh.d/**/*.zsh(.r); do
            source ${f}
        done
    fi
}

source "${HOME}/.zsh.d/zsh-syntax-highlighting"

# Finally, look for a ~/.zsh_local which can contain private variables not
# stored in Git.
if [[ -f "${HOME}/.zsh_local" ]]; then
    source "${HOME}/.zsh_local"
fi
