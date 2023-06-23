# GOPATH set to a hidden directory.
export GOPATH="${HOME}/.gocode"

# Disable the upcoming Go telemtry stuff
export GOTELEMETRY="off"

# Disable automatic toolchain downloading
export GOTOOLCHAIN="path"

# If we installed a local version of go, add that to PATH.
# And add the $GOPATH bin directory to PATH
_zshd_prepend_path "${HOME}/.local/go/bin" "${GOPATH}/bin"

# GVM handling
if [ -f "${HOME}/.gvm/scripts/gvm" ]; then
    source "${HOME}/.gvm/scripts/gvm"
fi
