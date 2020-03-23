DOTFILES_DIR ?= system

define check_dependency
	command -v $1
endef

ensure_stow_installed:
	$(call check_dependency,stow)

setup: ensure_stow_installed
	chmod +x ./scripts/setup_dotfiles.sh
	./scripts/setup_dotfiles.sh \
	$(DOTFILES_DIR) \
	$(HOME)

teardown:
	chmod +x ./scripts/teardown.sh
	./scripts/teardown.sh \
	$(DOTFILES_DIR) \
	$(HOME)
