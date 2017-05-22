# Rust

# Attempts to source the env from the default Rustup location.
if [ -f "${HOME}/.cargo/env" ]; then
    source "${HOME}/.cargo/env"
fi
