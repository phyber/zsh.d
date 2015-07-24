
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
	_zshd_git_delete_local_branch "${branch_name}"
	_zshd_git_delete_remote_branch "${remote}" "${branch_name}"
}
