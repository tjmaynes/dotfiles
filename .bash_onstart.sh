#!/bin/bash

function setup_environment()
{
  if [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ $(uname -m) == 'arm64' ]]; then
      HOMEBREW_PATH="/opt/homebrew/bin"
    else
      HOMEBREW_PATH="/usr/local/bin"
    fi

    export PATH=$HOMEBREW_PATH:$PATH
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_ANALYTICS=1
  else
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
  fi

  export PATH=$HOME/.npm-packages/bin:$PATH
  export NODE_PATH=$HOME/.npm-packages/lib/node_modules

  export GOPATH=$HOME/workspace/go
  export PATH=$GOPATH/bin:$PATH
}

function setup_docker() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ ! -d "/Applications/Docker.app" ]]; then
      echo "Installing Docker..."

      DOCKER_VERSION=$(uname -m)
      curl -O https://desktop.docker.com/mac/main/$DOCKER_VERSION/Docker.dmg

      hdiutil attach Docker.dmg
      cp -rf /Volumes/Docker/Docker.app /Applications && rm -rf Docker.dmg
    fi
  fi
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

function pclone()
{
  REPO_NAME=$1
  GIT_REPO=$GIT_USERNAME/$REPO_NAME

  if [[ ! -d "$WORKSPACE_DIR" ]]; then
    mkdir -p "$WORKSPACE_DIR"
  fi

  if [[ -z "$REPO_NAME" ]]; then
    echo "Missing arg 1 'git repo name'"
  elif [[ ! -d "$WORKSPACE_DIR/$REPO_NAME" ]]; then
    git clone git@github.com:$GIT_REPO.git $WORKSPACE_DIR/$REPO_NAME

    [[ -d "$WORKSPACE_DIR/$REPO_NAME" ]] && cd $WORKSPACE_DIR/$REPO_NAME
  else
    cd $WORKSPACE_DIR/$REPO_NAME
  fi
}

# Originally found here: https://stackoverflow.com/a/32592965
function kill-process-on-port()
{
  PORT=$1

  if [[ -z $PORT ]]; then
    echo "Please provide a PORT to kill process from"
  else
    kill -9 $(lsof -t -i:$PORT)
  fi
}

function backup-github-repos()
{
  REPOS=$(curl -s "https://api.github.com/users/$GIT_USERNAME/repos" | jq 'map(.name) | join(",")')

  BACKUP_TIMESTAMP=$(date +%Y%m%d-%H%M%S)
  BACKUP_DIR=$BACKUP_DIR/$BACKUP_TIMESTAMP

  if [[ ! -d "$BACKUP_DIR" ]]; then
    mkdir -p "$BACKUP_DIR"
  fi

  for repo in $(echo $REPOS | sed "s/,/ /g" | tr -d '"'); do
    echo "Backing up $repo repo to $BACKUP_DIR"

    git clone https://github.com/$GIT_USERNAME/$repo.git $BACKUP_DIR/$repo

    pushd $BACKUP_DIR
    tar -czf $repo.tar.gz $repo
    rm -rf $BACKUP_DIR/$repo
    popd
  done
}

function get-ip-address()
{
  if [[ -z "$(command -v hostname)" ]]; then
    echo "Hostname is not installed on machine"
  else
    hostname -I | awk '{print $1}'
  fi
}

function start-ssh-agent()
{
  eval $(ssh-agent -s) && ssh-add $HOME/.ssh/id_rsa
}

function docker-clean-all()
{
  if [[ -n "$(command -v docker)" ]]; then
    docker stop $(docker container ls -a -q)
    docker system prune -a -f --all
    docker rm $(docker container ls -a -q)
  else
    echo "Please install 'docker' before running this command!"
  fi
}

function docker-stop-and-remove-image()
{
  if [[ -n "$(command -v docker)" ]]; then
    docker stop "$(docker ps | grep $1 | awk '{print $1}')"
    docker rm   "$(docker ps | grep $1 | awk '{print $1}')"
    docker rmi  "$(docker images | grep $1 | awk '{print $3}')" --force
  else
    echo "Please install 'docker' before running this command!"
  fi
}

function main()
{
  setup_environment

  setup_docker
  setup_vim
}

main
