#!/usr/bin/env bash

function setup_environment() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
  fi

  export PATH=/usr/sbin:$PATH

  export GOPATH=$HOME/workspace/go
  export PATH=$GOPATH/bin:$PATH

  export PATH=$HOME/.npm-packages/bin:$PATH
  export NODE_PATH=$HOME/.npm-packages/lib/node_modules
}

function install_vscode_extension() {
  code=$(which code)
  if [[ -n "$(command -v code-server)" ]]; then
    code=$(which code-server)
  fi

  if [[ -n "(command -v $code)" ]]; then
    if ! $code --list-extensions | grep --silent "$1"; then
      $code --install-extension $1 --force 1> /dev/null
    fi
  fi
}

function install_vscode_extensions() {
  EXTENSIONS=(equinusocio.vsc-material-theme pkief.material-icon-theme golang.go timonwong.shellcheck)
  for extension in "${EXTENSIONS[@]}"; do
    install_vscode_extension "$extension"
  done
}

function setup_vim() {
  if [[ -n "$(command -v vim)" ]]; then
    if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
      echo "Installing Vim Plug..."
      curl -Lo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    if [[ ! -d "$HOME/.vim/plugged" ]]; then
      echo "Installing Vim plugins..."
      vim +'PlugInstall --sync' +qa
    fi
  fi
}

function setup_git() {
  git config --global user.email "tj@tjmaynes.com"
  git config --global user.name "TJ Maynes"

  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.ci commit
  git config --global alias.st status
  git config --global alias.conflicts "ls-files --unmerged | cut -f2 | sort -u"
  git config --global alias.llog "log --date=local"
  git config --global alias.flog "log --pretty=fuller --decorate"
  git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
  git config --global alias.lol "log --graph --decorate --oneline"
  git config --global alias.lola "log --graph --decorate --oneline --all"
  git config --global alias.ditch "reset --hard"
  git config --global alias.ditchall "reset --hard && git clean -fd"
  git config --global alias.d "difftool"
  git config --global alias.diffc "diff --cached"
  git config --global alias.smp "submodule foreach git pull origin master"
  git config --global alias.sgc "og --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %C(cyan)(%cr) %C(blue)<%an>%Creset' --abbrev-commit --date=relative"
  git config --global alias.patience "merge --strategy-option=patience"
  git config --global alias.aliases "config --get-regexp alias"
  git config --global alias.pushf "push --force-with-lease"
  git config --global alias.s "status -s -uno"
  git config --global alias.gl "log --oneline --graph"

  git config --global core.editor "vim"
  git config --global diff.tool "delta"
  git config --global gpg.program "gpg2"
  git config --global init.defaultBranch "main"
}

function main() {
  setup_environment
  setup_vim
  setup_git

  install_vscode_extensions
}

main
