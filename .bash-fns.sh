#!/usr/bin/env bash

function pclone() {
  REPO_NAME=$1
  GIT_REPO=tjmaynes/$REPO_NAME
  WORKSPACE_DIR=$HOME/workspace/tjmaynes

  if [[ -z "$REPO_NAME" ]]; then
    echo "Please pass an argument for the repo name."
  else
    if [[ ! -d "$WORKSPACE_DIR" ]]; then
      mkdir -p "$WORKSPACE_DIR"
    fi

    if [[ ! -d "$WORKSPACE_DIR/$REPO_NAME" ]]; then
      git clone "git@github.com:$GIT_REPO.git" "$WORKSPACE_DIR/$REPO_NAME"
    fi

    cd "$WORKSPACE_DIR/$REPO_NAME"
  fi
}

# Originally found here: https://stackoverflow.com/a/32592965
function kill-process-on-port() {
  PORT=$1

  if [[ -z $PORT ]]; then
    echo "Please provide a PORT to kill process from"
  else
    kill -9 "$(lsof -t -i:$PORT)"
  fi
}

function backup-github-repos() {
  REPOS=$(curl -s "https://api.github.com/users/$HOST_GIT_USERNAME/repos" | jq 'map(.name) | join(",")')

  BACKUP_TIMESTAMP=$(date +%Y%m%d-%H%M%S)
  BACKUP_DIR=$BACKUP_DIR/github/$BACKUP_TIMESTAMP

  if [[ ! -d "$BACKUP_DIR" ]]; then
    mkdir -p "$BACKUP_DIR"
  fi

  for repo in $(echo $REPOS | sed "s/,/ /g" | tr -d '"'); do
    echo "Backing up $repo repo to $BACKUP_DIR"

    git clone https://github.com/$HOST_GIT_USERNAME/$repo.git $BACKUP_DIR/$repo

    pushd $BACKUP_DIR
    tar -czf $repo.tar.gz $repo
    rm -rf $BACKUP_DIR/$repo
    popd
  done
}

function convert-m4a-to-mp3() {
  mkdir -p tmp && for f in *.m4a; do ffmpeg -i "$f" -codec:v copy -codec:a libmp3lame -q:a 2 tmp/"${f%.m4a}.mp3"; done
}

function get-ip-address() {
  if [[ -z "$(command -v hostname)" ]]; then
    echo "Hostname is not installed on machine"
  else
    hostname -I | awk '{print $1}'
  fi
}

function generate-ssh-key() {
  if [[ ! -f "$HOME/.ssh/id_ed25519.pub" ]]; then
    echo "Generating ssh key for $HOST_EMAIL..."
    ssh-keygen -t ed25519 -C "$HOST_EMAIL"
  fi
}

function start-ssh-agent() {
  generate-ssh-key

  eval "$(ssh-agent -s)" && ssh-add "$HOME/.ssh/id_ed25519"
}

function docker-clean-all() {
  if [[ -n "$(command -v docker)" ]]; then
    docker stop "$(docker container ls -a -q)"
    docker system prune -a -f --all
    docker rm "$(docker container ls -a -q)"
  else
    echo "Please install 'docker' before running this command!"
  fi
}

function docker-stop-and-remove-image() {
  if [[ -n "$(command -v docker)" ]]; then
    docker stop "$(docker ps | grep $1 | awk '{print $1}')"
    docker rm   "$(docker ps | grep $1 | awk '{print $1}')"
    docker rmi  "$(docker images | grep $1 | awk '{print $3}')" --force
  else
    echo "Please install 'docker' before running this command!"
  fi
}

function convert-music-to-mp3() {
  if [[ -z "$(command -v ffmpeg)" ]]; then
    echo "Please install 'ffmpeg' on this machine before running this command"
  elif [[ -z "$(ls -la *.m4a)" ]]; then
    echo "No 'm4a' files were found in this directory"
  else
    rm -rf output && mkdir output

    for file in *.m4a; do
      ffmpeg -i "$file" -codec:v copy -codec:a libmp3lame -q:a 2 output/"${file%.m4a}.mp3"
    done
  fi
}


function _setup_git() {
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

function _setup_vim() {
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
