[[ -f "$HOME/.bash-fns.sh" ]] && source $HOME/.bash-fns.sh; _setup_git && _setup_vim

[[ -f "$HOME/.zprezto/init.zsh" ]] && source $HOME/.zprezto/init.zsh

[[ -f "$HOME/.asdf/asdf.sh" ]] && source $HOME/.asdf/asdf.sh
[[ -f "$HOME/.asdf/plugins/java/set-java-home.zsh" ]] && source $HOME/.asdf/plugins/java/set-java-home.zsh

[[ -d "/usr/sbin" ]] && export PATH=/usr/sbin:$PATH

[[ -n "$(command -v go)" ]] && {
    export GOPATH=$HOME/workspace/go
    export PATH=$GOPATH/bin:$PATH
}

[[ -n "$(command -v node)" ]] && {
    mkdir -p $HOME/.npm-packages/lib/node_modules
    export PATH=$HOME/.npm-packages/bin:$PATH
    export NODE_PATH=$HOME/.npm-packages/lib/node_modules
}

command -v colima &> /dev/null && ! colima status &> /dev/null && echo "Starting colima..." && colima start &> /dev/null

alias ls='lsd'

source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
