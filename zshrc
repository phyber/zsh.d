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

# Autoloading functions.
source "${HOME}/.zsh.d/autoload.zsh"

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

# Finally, look for a ~/.zsh_local which can contain private variables not
# stored in Git.
if [[ -f "${HOME}/.zsh_local" ]]; then
    source "${HOME}/.zsh_local"
fi
