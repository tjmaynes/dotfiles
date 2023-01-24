function setup_coding_environment() {
  if [[ $OSTYPE == 'darwin'* ]]; then
    if [[ "$(uname -m)" = "arm64" ]]; then
      export PATH=/opt/homebrew/bin:$PATH
    else
      export PATH=/usr/local/bin:$PATH
    fi
  fi

  [[ -d "/usr/sbin" ]] && export PATH=/usr/sbin:$PATH

  if [[ -f "$HOME/.asdf/asdf.sh" ]]; then 
    source $HOME/.asdf/asdf.sh
    asdf install >& /dev/null
  fi

  [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc" ]] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

  if [[ -f "$HOME/.bash-fns.sh" ]]; then
    source "$HOME/.bash-fns.sh"
    _setup_git && _setup_vim
  fi

  if [[ -n "$(command -v node)" ]]; then
    mkdir -p $HOME/.npm-packages/lib/node_modules
    export PATH=$HOME/.npm-packages/bin:$PATH
    export NODE_PATH=$HOME/.npm-packages/lib/node_modules
  fi

  if [[ -n "$(command -v go)" ]]; then
    export GOPATH=$HOME/workspace/go
    export PATH=$GOPATH/bin:$PATH
  fi

  if [[ -d "$HOME/Library/Android/sdk" ]]; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/platform-tools
  fi

  command -v colima &> /dev/null && ! colima status &> /dev/null && echo "Starting colima..." && colima start &> /dev/null
}

[[ -f "$HOME/.zprezto/init.zsh" ]] && source $HOME/.zprezto/init.zsh

setup_coding_environment
