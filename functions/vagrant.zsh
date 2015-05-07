# vim:ft=zsh:

# TODO: Autocompletion.

function vacu {
	vagrant cucumber $@
	return $?
}

# Forces destruction and then ups clean VMs.
function vadu {
	vakill $@ && \
	vaup $@
	return $?
}

# Toggles VAGRANT_CUCUMBER_FORCE_COLOUR
function vafc {
	if [ $VAGRANT_CUCUMBER_FORCE_COLOUR ]; then
		echo "Disabling forced vagrant cucumber colours."
		unset VAGRANT_CUCUMBER_FORCE_COLOUR
	else
		echo "Enabling forced vagrant cucumber colours."
		export VAGRANT_CUCUMBER_FORCE_COLOUR="on"
	fi
}

function vaha {
	vagrant halt $@
	return $?
}

function vakill {
	vagrant destroy -f $@
	return $?
}

function varb {
	vagrant snap rollback $@
	return $?
}

# vast executes global-status, and removes the footer by exiting at the
# first blank line it sees.
function vast {
	while read line; do
		if [ ${#line} -eq 0 ]; then
			break
		fi
		echo $line
	done < <(vagrant global-status $@)
	return $?
}

function vaup {
	vagrant up $@
}
