[[ -f "$HOME/.bash-fns.sh" ]] && source $HOME/.bash-fns.sh

[[ -f "$HOME/.zprezto/init.zsh" ]] && source $HOME/.zprezto/init.zsh

if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  source $HOME/.asdf/asdf.sh
fi

if [[ -f "$HOME/.post-install.sh" ]] && [[ -n "$ENABLE_POST_INSTALL" ]]; then
  source $HOME/.post-install.sh
fi