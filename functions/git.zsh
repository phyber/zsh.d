
function _zshd_git_delete_local_branch {
	local -r branch_name="$1"
	git branch -d "${branch_name}"
	return $?
}

function _zshd_git_delete_remote_branch {
	local -r remote="$1"
	local -r branch_name="$2"
	git push "${remote}" :"${branch_name}"
	return $?
}

# gitrmb: git remove branch
function gitrmb {
	local -r remote="$1"
	local -r branch_name="$2"

	if [ -z "${remote}" -o -z "${branch_name}" ]; then
		print -u 2 "Usage: $0 REMOTE BRANCH"
		return 1
	fi

	if ! git rev-parse --git-dir >/dev/null 2>&1; then
		print -u 2 "Current directory is not a git repository."
		return 1
	fi

	_zshd_git_delete_local_branch "${branch_name}"
	_zshd_git_delete_remote_branch "${remote}" "${branch_name}"
}
