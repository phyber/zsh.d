####
# Environment
####
## ZSH Dirstack
DIRSTACKSIZE=16

## ZSH history
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=1000
SAVEHIST=10000

# Ensure that each entry in PATH is unique
typeset -U PATH
export PATH="${HOME}/.local/bin:${PATH}"

# Ensure uniqueness of LD_LIBRARY_PATH entries.
typeset -T LD_LIBRARY_PATH ld_library_path
typeset -U LD_LIBRARY_PATH

typeset -U FPATH
fpath+="${HOME}/.zsh.d/autoload"
fpath+="${HOME}/.zsh.d/completions"
function {
    local f
    for f in ${HOME}/.zsh.d/autoload/**/*(/); do
        fpath+="${f}"
    done
}

# Pager for the null command. READNULLCMD gets trashed on Debian by
# /etc/zsh/zshrc which is read later. So we must set READNULLCMD through
# PAGER which is used in /etc/zsh/zshrc
PAGER=${PAGER:-=less}
export PAGER
READNULLCMD="${PAGER}"
