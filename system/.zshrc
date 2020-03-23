# ---- dot zshrc ----
# Author: TJ Maynes <tjmaynes at gmail dot com>
# File: .zshrc

source ~/.bash_exports
source ~/.bash_aliases
source ~/.bash_secrets

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/tjmaynes/.sdkman"
[[ -s "/Users/tjmaynes/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/tjmaynes/.sdkman/bin/sdkman-init.sh"
