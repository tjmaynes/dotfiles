#!/bin/bash

set -e

DOTFILES_SOURCE_DIRECTORY=$1
DOTFILES_TARGET_DIRECTORY=$2

if [[ -z $DOTFILES_SOURCE_DIRECTORY ]]; then
  echo 'Please provide a source directory to unlink dotfiles.'
  exit 1
elif [[ -z $DOTFILES_TARGET_DIRECTORY ]]; then
  echo 'Please provide a target directory to unlink dotfiles from.'
  exit 1
fi

remove_homebrew()
{
  if [ -x "$(command -v brew)" ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
  fi 
}

unlink_dotfiles()
{
  if [ -x "$(command -v stow)" ]; then
    stow \
      --delete \
      --target=$DOTFILES_TARGET_DIRECTORY \
      --verbose \
      $DOTFILES_SOURCE_DIRECTORY

    brew uninstall stow
  fi
}

uninstall_media()
{
  MEDIA_CLI_PROGRAMS=(cmus)

	for pkg in "${MEDIA_CLI_PROGRAMS[@]}"; do
		if brew cask list -1 | grep -q "^${pkg}\$"; then
			echo "Uninstalling package '$pkg'..."
      brew uninstall pkg
		else
			echo "Package '$pkg' is not installed"
		fi
	done

	MEDIA_PROGRAMS=(google-chrome mpv bitwarden)

	for pkg in "${MEDIA_PROGRAMS[@]}"; do
		if brew cask list -1 | grep -q "^${pkg}\$"; then
			echo "Uninstalling cask package '$pkg'..."
      brew cask uninstall pkg
		else
			echo "Cask Package '$pkg' is not installed"
		fi
	done
}

uninstall_docker()
{
  if [[ -d "/Applications/Docker.app" ]]; then
    echo "Uninstalling Docker..."
    rm -rf /Applications/Docker.app
  else
    echo "Docker not installed..."
  fi
}

main()
{
  uninstall_media
  uninstall_dotfiles
  uninstall_docker
  remove_homebrew
}

main
