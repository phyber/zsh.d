zstyle :compinstall filename ${HOME}/.zshrc
####
# Modules
####
# Colours for prompt
autoload -Uz colors && colors

####
# ZSH Options
####
## Changing directory
setopt AUTO_PUSHD		# Push directories to dirstack on cd.
setopt PUSHD_IGNORE_DUPS	# No duplicates on dirstack.
setopt PUSHD_SILENT		# Don't print dirstack after {push,pop}d.

# History
setopt BANG_HIST		# ! history at the prompt.
setopt EXTENDED_HISTORY		# Timestamped history.
setopt HIST_FCNTL_LOCK		# Better file locking while writing history.
setopt HIST_FIND_NO_DUPS	# Don't list dupes when scrolling through.
				# history, even if they aren't contiguous.
setopt HIST_IGNORE_DUPS		# No duplicates in history.
setopt HIST_IGNORE_SPACE	# Don't add commands beginning with a space to
				# history.
setopt HIST_NO_STORE		# Don't store us looking at the history.
setopt HIST_REDUCE_BLANKS	# Remove pointless blanks from history.
setopt INC_APPEND_HISTORY	# Append to history immediately.
setopt NO_HIST_BEEP		# No beeping if history is missing.

# Input/Output
setopt NO_CLOBBER		# Be explicit about destroying files with
				# redirected IO.
setopt NO_FLOW_CONTROL		# Disable ^s ^q
setopt RM_STAR_WAIT		# Never needed this, but it can't hurt.

# Job control
setopt NO_CHECK_JOBS		# Don't give status of bg-jobs on shell exit
setopt NO_HUP			# Don't kill bg-jobs when shell exits

# Prompting
setopt PROMPT_SUBST		# Prompt substitutions
setopt TRANSIENT_RPROMPT	# Hide the RPROMPT if we're typing near it

# Scripts and Functions
setopt C_BASES			# Output hex as '0xFF', etc.
setopt C_PRECEDENCES		# Precedence of arithmetic to be more C like.
setopt PIPE_FAIL		# $? set to the exit status of the first
				# command to fail in a pipe.

# Shell emulation
setopt BSD_ECHO			# More standard echo

# ZLE
setopt NO_BEEP			# No beeping on errors

# ZLE keymap
bindkey -e			# EMACS key mode
#bindkey -v			# vi key mode

# If we're started with the vi keymap, enable some extra things.
if [[ ${$(bindkey -lL main):2:1} == 'viins' ]]; then
	vi_key_mode=' -- INSERT --'
	function zle-line-init zle-line-finish zle-keymap-select {
		case "$0" in
			zle-line-init|zle-line-finish)
				vi_key_mode=' -- INSERT --';;
			zle-keymap-select)
				case "$KEYMAP" in
					vicmd)
						vi_key_mode=' -- NORMAL --';;
					viins|main)
						vi_key_mode=' -- INSERT --';;
				esac
				zle reset-prompt
				;;
		esac
	}
	zle -N zle-line-init
	zle -N zle-line-finish
	zle -N zle-keymap-select
	# Default Debian zshrc sets these to silly mode.
	bindkey -M viins "\e[A" up-line-or-history
	bindkey -M viins "\e[B" down-line-or-history
	bindkey -M viins "\eOA" up-line-or-history
	bindkey -M viins "\eOB" down-line-or-history
fi

# Adds a space after the command line when browsing up/down in history.
#function space-after-up-line-or-history {
#	# Call original
#	zle _zshrc_original_up-line-or-history
#	#zle .up-line-or-history
#	if [[ "${BUFFER[-1]}" != ' ' ]]; then
#		RBUFFER+=" "
#		zle end-of-line
#	fi
#}
#zle -A up-line-or-history _zshrc_original_up-line-or-history
#zle -N up-line-or-history space-after-up-line-or-history

# Load broken-out configuration.
if [[ -d "${HOME}/.zsh.d" ]]; then
	# Find all readable .zsh files under ~/.zsh.d
	for f in ${HOME}/.zsh.d/**/*.zsh(.r); do
		source ${f}
	done
fi

# Finally, look for a ~/.zsh_local which can contain private variables not
# stored in Git.
if [[ -f "${HOME}/.zsh_local" ]]; then
	source "${HOME}/.zsh_local"
fi
