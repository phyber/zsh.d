# Kubernetes

# kubectl completions
if _zshd_check_cmd "kubectl" 2>/dev/null; then
    source <(kubectl completion zsh)
fi
