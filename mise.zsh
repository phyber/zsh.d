# Mise is a tool management tool
if (( $+commands[mise] )); then
    # List of backends to disble
    local -r disable_backends=(
        "asdf"
        "dotnet"
    )

    export MISE_DISABLE_BACKENDS="$(printf "%s\n" "${disable_backends[@]}" | paste -sd,)"

    eval "$(mise activate zsh)"

    # The completions will need the `usage` tool, which can be installed with
    # mise.
    eval "$(mise completion zsh)"
fi
