[[ -f $HOME/.bash_exports ]]; source $HOME/.bash_exports

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export PATH=$PATH:$HOME/workspace/bin/kubectl
export PATH=$PATH:$HOME/workspace/bin/skaffold
export PATH=$PATH:$HOME/workspace/bin/kind

export PATH=$PATH:$HOME/workspace/bin/dotnet
export DOTNET_ROOT=$HOME/workspace/bin/dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH="$PATH:$HOME/.dotnet/tools"
