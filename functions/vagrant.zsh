# vim:ft=zsh:

# TODO: Autocompletion.

function vacu {
	vagrant cucumber $@
}

# Forces destruction and then ups clean VMs.
function vadu {
	vakill $@ \
		&& vaup $@
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
}

function vakill {
	vagrant destroy -f $@
}

function varb {
	vagrant snapshot \
		pop \
		--no-provision \
		--no-delete \
		$@
}

function vash {
	vagrant ssh $@
}

# vast executes global-status, and removes the footer by exiting at the
# first blank line it sees.
function vast {
	local line
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
}

function vaup {
	vagrant up $@
}

# Vagrant update boxes
function vaub {
	local box
	while read -u 3 box; do
		local provider=''
		while read -u 4 provider; do
			if ! _vagrant_box_update "${box}" "${provider}"; then
				print -u 2 "Vagrant box '${box}' not updated."
			fi
		done 4< <(_vagrant_box_providers "${box}")
	done 3< <(_vagrant_box_names)
}

# Vagrant remove outdated.
function varo {
	local box
	while read -u 3 box; do
		local provider=''
		while read -u 5 provider; do
			local old=''
			while read -u 4 old; do
				if ! _vagrant_box_remove "${box}" "${old}" "${provider}"; then
					print -u 2 "Problem removing outdated box: ${box} -> ${old}"
				fi
			done 4< <(_vagrant_box_outdated "${box}" "${provider}")
		done 5< <(_vagrant_box_providers "${box}")
	done 3< <(_vagrant_box_names)
}

function _vagrant_box_update {
	local box="$1"
	local provider="$2"

	vagrant box update \
		--box "${box}" \
		--provider "${provider}"
}

function _vagrant_box_remove {
	local -r box="$1"
	local -r version="$2"
	local -r provider="$3"

	vagrant box remove \
		"${box}" \
		--box-version "${version}" \
		--provider "${provider}"
}

function _vagrant_box_providers {
	local -r box="$1"

	vagrant box list \
		| grep "^${box}" \
		| tr -s ' ' \
		| tr -d '(),' \
		| cut -d' ' -f2
}

function _vagrant_box_names {
	vagrant box list \
		| grep -v '^There are no installed boxes' \
		| cut -d' ' -f1 \
		| sort \
		| uniq
}

function _vagrant_box_latest {
	local -r box_name="$1"
	local -r provider="$2"

	vagrant box list \
		| tr -s ' ' \
		| tr -d '(),' \
		| awk "\$2 == \"${provider}\"" \
		| _vagrant_version_sort \
		| awk '!_[$1]++' \
		| grep "${box_name}" \
		| cut -d' ' -f3
}

function _vagrant_box_outdated {
	local -r box="$1"
	local -r provider="$2"
	local -r latest="$(_vagrant_box_latest "${box}" "${provider}")"

	vagrant box list \
		| tr -s ' ' \
		| tr -d '(),' \
		| awk "\$2 == \"${provider}\"" \
		| _vagrant_version_sort \
		| grep "${box}" \
		| cut -d' ' -f3 \
		| grep -v "^${latest}$"
}

function _vagrant_version_sort {
	case "$OSTYPE" in
		darwin*)
			# OS X lacks a recent sort binary, so attempt to fake
			# a version sort. Works for versions like:
			# 0.2.20, 0.2.13, a.b.cc
			# Will break if fields a or b become more than single
			# digit
			# Needs to know what the field separator is.
			sort -t" " -k3.1,1nr -k3.3,3nr -k3.5nr
			;;
		*)
			# Assume fancy sort by default
			sort -k3Vr
			;;
	esac
}
