#!/bin/sh

set -e

SOURCE_DIRECTORY=$1
TARGET_DIRECTORY=$2

if [[ -z $SOURCE_DIRECTORY ]]; then
  echo 'Please provide a source directory to symlink dotfiles.'
  exit 1
elif [[ -z $TARGET_DIRECTORY ]]; then
  echo 'Please provide a target directory to symlink dotfiles to.'
  exit 1
fi

install_homebrew()
{
  if [ -f "`which brew`" ]; then
    echo "Homebrew has already been installed..."
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

setup_dotfiles()
{
  if [[ ! -x "$(command -v stow)" ]]; then
    echo "Installing 'stow'..."
    brew install stow
  fi

  stow \
    --restow \
    --target=$TARGET_DIRECTORY \
    --verbose \
    $SOURCE_DIRECTORY
  }

main()
{
  install_homebrew
  setup_dotfiles
}

main
