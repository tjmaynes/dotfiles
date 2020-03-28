DOTFILES_DIR ?= system

define check_dependency
	command -v $1
endef

ensure_stow_installed:
	$(call check_dependency,stow)

setup: ensure_stow_installed
	stow \
		--restow \
		--verbose \
		--target=$(HOME) \
		$(DOTFILES_DIR)

teardown: ensure_stow_installed
	stow \
		--delete \
		--verbose \
		--target=$(HOME) \
		$(DOTFILES_DIR)
