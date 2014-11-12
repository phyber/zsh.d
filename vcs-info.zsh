# VCS Info
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# Enable VCS Info for git and mercurial.
zstyle ':vcs_info:*' enable git hg

# Git options
zstyle ':vcs_info:git*' get-revision true
zstyle ':vcs_info:git*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks \
	git-stash \
	git-square-bracket \
	git-untracked

# vcs_info output style.
zstyle ':vcs_info:*' formats \
	":%{$fg_bold[grey]%}%m%u%c[%s:%b]%{$reset_color%}"
zstyle ':vcs_info:*' actionformats \
	":%{$fg_bold[grey]%}%m%u%c[%s:%b|%a]%{$reset_color%}"

# Hook the precmd shell function and execute vcs_info there.
add-zsh-hook precmd vcs_info

####
# VCS Info hook functions
####
# Get name of remote that we're tracking
# Not quite doing what I want yet.
function +vi-git-remote() {
	local remote
	remote=$(git remote 2>/dev/null)
	if [[ -n ${remote} ]]; then
		hook_com[branch]="${remote}/${hook_com[branch]}"
	fi
}

# Show untracked files indicator
function +vi-git-untracked {
	local untracked
	untracked=$(git ls-files --other --exclude-standard 2>/dev/null)
	if [[ -n ${untracked} ]]; then
		hook_com[misc]+="[?]"
	fi
}

# Show number of stashed changes.
function +vi-git-stash() {
	local -a stashes
	if [[ -s ${hook_com[base]}/.git/refs/stash ]]; then
		stashes=(${(@f)$(git stash list 2>/dev/null)})
		# Sometimes refs/stash exists even with 0 stashes
		# Make sure we have at least 1 stash before adding this info
		if (( ${#stashes} )); then
			hook_com[misc]+="[${#stashes}S]"
		fi
	fi
}

# Square bracketing for a few things
function +vi-git-square-bracket {
	if [[ -n ${hook_com[unstaged]} ]]; then
		hook_com[unstaged]="[${hook_com[unstaged]}]"
	fi
	if [[ -n ${hook_com[staged]} ]]; then
		hook_com[staged]="[${hook_com[staged]}]"
	fi
}
