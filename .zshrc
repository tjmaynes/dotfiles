source ~/.bash_exports

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/tjmaynes/.sdkman"
[[ -s "/home/tjmaynes/.sdkman/bin/sdkman-init.sh" ]] && source "/home/tjmaynes/.sdkman/bin/sdkman-init.sh"
