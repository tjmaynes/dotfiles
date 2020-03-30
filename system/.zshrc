# ---- dot zshrc ----
# Author: TJ Maynes <tjmaynes at gmail dot com>
# File: .zshrc

source ~/.bash_exports
source ~/.bash_aliases
source ~/.bash_kubernetes
(touch ~/.bash_secrets || true) && source ~/.bash_secrets

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
