#!/usr/bin/env bash

function kill-process-on-port() {
  PORT=$1
  if [[ ! -z "$(lsof -t -i :$PORT)" ]]; then
    (kill -9 "$(lsof -t -i:$PORT -sTCP:LISTEN)" >/dev/null 2>&1) || true
  fi
}

function backup-workspace()
{
  if [[ -z "$WORKSPACE_DIRECTORY" ]]; then
    echo "Please set 'WORKSPACE_DIRECTORY' environment variable before running this command..."
  elif [[ -z "$BACKUPS_DIRECTORY" ]]; then
    echo "Please set 'BACKUPS_DIRECTORY' environment variable before running this command..."
  else
    NOW="$(date +'%Y%m%d-%H%M%S')"
    BACKUP_NAME="workspace_backup_${NOW}.tar.gz"

    echo "Backing up '$WORKSPACE_DIRECTORY' to '$BACKUP_NAME' now... $BACKUPS_DIRECTORY/$BACKUP_NAME"

    tar cvzf \
      "$BACKUPS_DIRECTORY/$BACKUP_NAME" --exclude "node_modules" --exclude ".cache" --exclude "gems" --exclude "Pods" --exclude "vendor" --exclude "tmp" --exclude "build" --exclude ".DS_Store" \
      -C "$WORKSPACE_DIRECTORY" .
  fi
}

function backup-all() {
  backup-workspace
}

function convert-m4a-to-mp3() {
  DIRECTORY=$(basename "$PWD")
  mkdir -p "$DIRECTORY"

  for f in *.m4a; do
    ffmpeg -i "$f" -codec:v copy -codec:a libmp3lame -q:a 2 "$DIRECTORY"/"${f%.m4a}.mp3"
  done
}
