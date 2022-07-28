#!/usr/bin/make

DOTFILES_DIR ?= system
TARGET_DIRECTORY ?= $(HOME)

setup:
	stow \
		--stow \
		--verbose \
		--target=$(TARGET_DIRECTORY) \
		$(DOTFILES_DIR)

teardown:
	stow \
		--delete \
		--verbose \
		--target=$(TARGET_DIRECTORY) \
		$(DOTFILES_DIR)
