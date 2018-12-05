
function _zshd_git_delete_local_branch {
	local -r branch_name="$1"
	git branch -d "${branch_name}"
}

function _zshd_git_delete_remote_branch {
	local -r remote="$1"
	local -r branch_name="$2"
	git push "${remote}" :"${branch_name}"
}

function _zshd_git_install {
	local -r name="$1"
	local -r repo_url="$2"
	local -r install_dir="$3"

	if ! _zshd_check_cmd "git" 2>/dev/null; then
		print -u 2 "git not found. Cannot install ${name}"
		return 1
	fi

	print "Installing ${name}"

	git clone --quiet \
		"${repo_url}" \
		"${install_dir}"

	if (( $? )); then
		print -u 2 "Couldn't install ${name}"
		return 1
	fi

	print "${name} installed."
}

function _zshd_git_update {
	local -r name="$1"
	local -r install_dir="$2"

	if ! _zshd_check_cmd "git" 2>/dev/null; then
		print -u 2 "git not found. Cannot update ${name}"
		return 1
	fi

	print "Updating ${name}"
	(
		cd "${install_dir}"
		git pull --quiet
		return $?
	)
	if (( $? )); then
		print -u 2 "Couldn't update ${name}"
		return 1
	fi

	print "${name} updated."
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
