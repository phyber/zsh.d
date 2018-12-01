# List of possible places gcloud lives.
local gcloud_paths=(
    '/snap/google-cloud-sdk/current'
)

# Attempt to source gcloud completion from multiple places, loading the first
# encountered and then breaking.
local p
for p in $gcloud_paths; do
    local inc_file="${p}/completion.zsh.inc"
    if [ -f "${inc_file}" ]; then
        source "${inc_file}"
        break
    fi
done
