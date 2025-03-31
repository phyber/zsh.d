# Connects to an endpoint and shows the HTTPS certificate in readable format.
function show-https-cert {
    local -r host="$1"
    local -r port="$2"

    if [ "x${host}" = "x" ]; then
        echo "Usage: show-https-cert HOST <PORT>"
        return 1
    fi

    local endpoint

    if [ "x${port}" = "x" ]; then
        endpoint="${host}:443"
    else
        endpoint="${host}:${port}"
    fi

    openssl s_client \
        -showcerts \
        -servername "${host}" \
        -connect "${endpoint}" \
        <<< Q \
        2>/dev/null \
    | openssl x509 -text
}
