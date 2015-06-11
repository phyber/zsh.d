# GOPATH set to a hidden directory.
export GOPATH="${HOME}/.gocode"

# If we installed a local version of go, add that to PATH.
# And add the $GOPATH bin directory to PATH
_zshd_prepend_path "${HOME}/.local/go/bin" "${GOPATH}/bin"
