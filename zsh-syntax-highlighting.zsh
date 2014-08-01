# Syntax highlighting
if [[ -f "${HOME}/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
	source "${HOME}/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
	# Can't modify this in .zshenv since we haven't loaded syntax
	# highlighting at that time.
	if [[ -n $ZSH_HIGHLIGHT_STYLES ]]; then
		ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue,bold'
		ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
	fi

	# Function for simple, quick updating of the highlighting stuff.
	function update-zsh-syntax-highlighting {
		if (( $+commands[git] )); then
			print "Updating ZSH Syntax Highlighting"
			(
				cd "${HOME}/.zsh-syntax-highlighting/"
				git pull --quiet
				return $?
			)
			if (( $? )); then
				print -u 2 "Couldn't update ZSH Syntax Highlighting"
				return 1
			fi
			exec "${SHELL}"
		else
			print -u 2 "git not installed. Cannot update ZSH Syntax Highlighting."
		fi
	}
else
	# If the syntax highlighting wasn't installed, create a function that
	# will install it.
	function install-zsh-syntax-highlighting {
		if (( $+commands[git] )); then
			print "Installing ZSH Syntax Highlighting"
			git clone --quiet \
				https://github.com/zsh-users/zsh-syntax-highlighting.git \
				"${HOME}/.zsh-syntax-highlighting"
			if (( $? )); then
				print -u 2 "Couldn't install ZSH Syntax Highlighting"
				return 1
			fi
			print "ZSH Syntax Highlighting installed."
			exec "${SHELL}"
		else
			print -u 2 "git not installed. Cannot automatically install ZSH Syntax Highlighting."
			print -u 2 "Download it from https://github.com/zsh-users/zsh-syntax-highlighting"
		fi
	}
fi
