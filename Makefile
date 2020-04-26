#!/usr/bin/make

DOTFILES_DIR ?= system

setup:
	stow \
		--stow \
		--verbose \
		--target=$(HOME) \
		$(DOTFILES_DIR)

teardown:
	stow \
		--delete \
		--verbose \
		--target=$(HOME) \
		$(DOTFILES_DIR)
