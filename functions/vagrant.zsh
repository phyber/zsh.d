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

function vash {
	vagrant ssh $@
	return $?
}

# vast executes global-status, and removes the footer by exiting at the
# first blank line it sees.
function vast {
	while read line; do
		# Checks for the blank line after listing VMs.
		if [ ${#line} -eq 0 ]; then
			break
		fi

		# Checks for the "no active Vagrant" line if no running VMs.
		if grep -q "no active Vagrant" <<<"${line}"; then
			break
		fi

		# Otherwise output!
		echo $line
	done < <(vagrant global-status $@)
	return $?
}

function vaup {
	vagrant up $@
}

# Vagrant update boxes
function vaub {
	local box
	while read box; do
		if ! vagrant box update --box "${box}"; then
			print -u 2 "Vagrant box '${box}' not updated."
		fi
	done < <(_vagrant_box_names)
}

# Vagrant remove outdated.
function varo {
	local box
	while read -u 3 box; do
		local old
		while read -u 4 old; do
			if ! vagrant box remove "${box}" --box-version "${old}"; then
				print -u 2 "Problem removing outdated box: ${box} -> ${old}"
			fi
		done 4< <(_vagrant_box_outdated "${box}")
	done 3< <(_vagrant_box_names)
}

function _vagrant_box_names {
	vagrant box list \
		| cut -d' ' -f1 \
		| sort \
		| uniq
}

function _vagrant_box_latest {
	local -r box_name="$1"

	vagrant box list \
		| tr -s ' ' \
		| tr -d '(),' \
		| _vagrant_version_sort \
		| awk '!_[$1]++' \
		| grep "${box_name}" \
		| cut -d' ' -f3
}

function _vagrant_box_outdated {
	local -r box="$1"
	local -r latest=$(_vagrant_box_latest "${box}")

	vagrant box list \
		| tr -s ' ' \
		| tr -d '(),' \
		| _vagrant_version_sort \
		| grep "${box}" \
		| cut -d' ' -f3 \
		| grep -v "^${latest}$"
}

# Attempt to provide a working version sort for BSD sort, just for the
# purpose of sorting vagrant box versions.
function _vagrant_version_sort {
	case "$OSTYPE" in
		linux*)
			# Assume GNU sort extensions on Linux
			sort -k3Vr
			;;
		*)
			# Basic sort as default, assuming version numbers like
			# 0.2.20, 0.2.13, a.b.cc
			# Will break if fields a or b become more than single
			# digit
			sort -k3.1,1nr -k3.3,3nr -k3.5nr
			;;
	esac
}
