# Rust

# Unconditionally add this to PATH, anticipating that we're always going to
# install cargo.
export PATH="${HOME}/.cargo/bin:${PATH}"

# Use the sparse registry index
export CARGO_REGISTRIES_CRATES_IO_PROTOCOL="sparse"

# If sccache is installed, use as a Rust wrapper.
if _zshd_check_cmd "sccache" 2>/dev/null; then
    export RUSTC_WRAPPER="sccache"
fi
