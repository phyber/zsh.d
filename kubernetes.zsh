# Kubernetes

# kubectl completions
if (( $+commands[kubectl] )); then
    source <(kubectl completion zsh)
fi
