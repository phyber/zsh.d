# Autoloading functions.
function {
    emulate -L zsh
    setopt EXTENDED_GLOB

    # Extended globbing allows us to use ~*~ to exclude files ending with
    # *~ from the initial * glob. The qualifier (.) ensures that we only match
    # plain files.
    local f
    for f in ${HOME}/.zsh.d/autoload/**/*~*~(.); do
        autoload -Uz ${f:t:r}
    done
}
