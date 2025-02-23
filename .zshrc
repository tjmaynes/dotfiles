export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto      # update automatically without asking

source $ZSH/oh-my-zsh.sh

plugins=(git macos kubectl asdf zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

export HIST_STAMPS="mm/dd/yyyy"
export HISTTIMEFORMAT="%F %T"

[[ -f "$HOME/.zsh_dynamic" ]] && . $HOME/.zsh_dynamic

#[[ -n "$(command -v docker)" ]] && \
#  [[ -f "$HOME/.docker-compose.default.yml" ]] && \
#  [[ -n "$(command -v docker compose)" ]] && \
#  [[ "$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:9090")" -ne 200 ]] && \
#  docker compose -f $HOME/.docker-compose.default.yml up -d
