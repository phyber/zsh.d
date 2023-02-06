# Kubernetes

# kubectl completions
if (( $+commands[kubectl] )); then
    source <(kubectl completion zsh)
fi

# Helm completions
if (( $+commands[helm] )); then
    source <(helm completion zsh)
fi
