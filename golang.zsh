# GOPATH set to a hidden directory.
export GOPATH="${HOME}/.gocode"

# Add the $GOPATH bin directory to PATH
export PATH="${GOPATH}/bin:${PATH}"

# If we installed a local version of go, add that to PATH.
if [[ -x "${HOME}/.local/go/bin" ]]; then
	export PATH="${HOME}/.local/go/bin:${PATH}"
fi
