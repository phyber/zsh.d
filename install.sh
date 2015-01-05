#!/bin/sh
# Small shell script to link .zshrc and .zshenv into ${HOME}

HOME_ZSHRC="${HOME}/.zshrc"
HOME_ZSHENV="${HOME}/.zshenv"
ZSHD="${HOME}/.zsh.d"
ZSHD_ZSHRC="${ZSHD}/zshrc"
ZSHD_ZSHENV="${ZSHD}/zshenv"

if [ -f "${HOME_ZSHRC}" ]; then
	echo "${HOME_ZSHRC} exists, please move it out of the way."
	exit 1
fi

if [ -f "${HOME_ZSHENV}" ]; then
	echo "${HOME_ZSHENV} exists, please move it out of the way."
	exit 1
fi

if [ ! -d "${ZSHD}" ]; then
	echo "Couldn't find '$ZSHD'. Where are you running me from?"
	exit 1
fi

echo "Linking ${ZSHD_ZSHRC} to ${HOME_ZSHRC}"
ln -s "${ZSHD_ZSHRC}" "${HOME_ZSHRC}"
if [ $? != 0 ]; then
	echo "Problems linking ${ZSHD_ZSHRC} to ${HOME_ZSHRC}"
	exit 1
fi

echo "Linking ${ZSHD_ZSHENV} to ${HOME_ZSHENV}"
ln -s "${ZSHD_ZSHENV}" "${HOME_ZSHENV}"
if [ $? != 0 ]; then
	echo "Problems linking ${ZSHD_ZSHENV} to ${HOME_ZSHENV}"
	exit 1
fi

echo "All done, you should reload your shell now."
