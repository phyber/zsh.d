# Environment variables.
#
HISTIGNORE='man:run-help'
typeset -gT HISTIGNORE histignore # Tied array for easily checking HISTIGNORE

# Common BSD type environment, used on BSD and OS X.
function common_bsd_environment {
    export CLICOLOR=1
    export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
    export TOP="-a -j"
    export LS_OPTIONS='-F'

    # Fix help.
    unalias run-help
    autoload run-help
}

# Handle some Linux/BSD differences here.
# # ;& in the case enables fallthrough.
case "$OSTYPE" in
    linux*)
        LS_OPTIONS='-F --group-directories-first'
        ;;
    freebsd*)
        common_bsd_environment

        export RUBY_CONFIGURE_OPTS=--with-readline-dir=/usr/local
        ;;
    darwin*)
        common_bsd_environment

        # Executes a local install of ZSH if there is one, otherwise
        # continues to use system zsh
        _zshd_exec_usr_local_bin_zsh
        ;;
    *)
        ;;
    esac

if (( $+commands[rlwrap] )); then
    RLWRAP_BINS=(bc)
fi

DREPORT_DIR="${HOME}/Docs/Reports"

# Setting this to 'vi' enables vi keybinds, anything else results in emacs.
ZSHD_KEYMAP="emacs"

# Directory where syntax highlight plugin is installed/to be installed.
ZSHD_SYNTAX_HIGHLIGHT_DIR="${HOME}/.zshsh"

# rbenv directory.
ZSHD_RBENV_DIR="${HOME}/.rbenv"

# rbenv plugins
ZSHD_RBENV_PLUGINS=(
    rbenv/ruby-build
    rbenv/rbenv-default-gems
    rbenv/rbenv-gem-rehash
    rkh/rbenv-update
)

# Sometimes we might not have vim installed. Redirect error output.
if (( $+commands[vim] )); then
    export EDITOR==vim
fi
export LC_COLLATE='C'
export LESS='-R'

# Hide disclaimers in whois where possible.
export WHOIS_OPTIONS='-H'

# Enable lesspipe if it is present.
if (( $+commands[lesspipe] )); then
    eval $(lesspipe)
fi
if (( $+commands[lesspipe.sh] )); then
    eval $(lesspipe.sh)
fi

if (( $+commands[manpath] )); then
    export MANPATH=$(manpath 2>/dev/null)
fi
