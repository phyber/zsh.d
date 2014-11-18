# Syntax highlighting
ZSH_SYNTAX_HIGHLIGHT_DIR="${HOME}/.zshsh"

if source \
	"${ZSH_SYNTAX_HIGHLIGHT_DIR}/zsh-syntax-highlighting.zsh" \
	>/dev/null 2>&1; then
	# Can't modify this in .zshenv since we haven't loaded syntax
	# highlighting at that time.
	if [[ -n $ZSH_HIGHLIGHT_STYLES ]]; then
		ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue,bold'
		ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
	fi

	# Function for simple, quick updating of the highlighting stuff.
	function update-zsh-syntax-highlighting {
		if (( ! $+commands[git] )); then
			print -u 2 "git missing. Cannot update ZSH Syntax Highlighting."
			return 1
		fi

		print "Updating ZSH Syntax Highlighting"
		(
			cd "${ZSH_SYNTAX_HIGHLIGHT_DIR}"
			git pull --quiet
			# Subshell, so we can return $? from here
			# and be useful.
			return $?
		)
		if (( $? )); then
			print -u 2 "Couldn't update ZSH Syntax Highlighting"
			return 1
		fi
		exec "${SHELL}"
	}
else
	# If the syntax highlighting wasn't installed, create a function that
	# will install it.
	function install-zsh-syntax-highlighting {
		local -r ZSHSH_URL="https://github.com/zsh-users/zsh-syntax-highlighting.git"

		if [[ -z "${ZSH_SYNTAX_HIGHLIGHT_DIR}" ]]; then
			print -u 2 "Error: ZSH_SYNTAX_HIGHLIGHT_DIR not set."
			return 1
		fi

		if (( ! $+commands[git] )); then
			print -u 2 "git missing. Cannot install ZSH Syntax Highlighting."
			print -u 2 "Download it from ${ZSHSH_URL}"
		fi

		print "Installing ZSH Syntax Highlighting"

		git clone --quiet \
			"${ZSHSH_URL}" \
			"${ZSH_SYNTAX_HIGHLIGHT_DIR}"
		if (( $? )); then
			print -u 2 "Couldn't install ZSH Syntax Highlighting"
			return 1
		fi

		print "ZSH Syntax Highlighting installed."
		exec "${SHELL}"
	}
fi
