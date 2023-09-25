#!/usr/bin/env bash

function backup_projects()
{
  if [[ -z "$PROJECTS_DIRECTORY" ]]; then
    echo "Please set 'PROJECTS_DIRECTORY' environment variable before running this command..."
  elif [[ -z "$BACKUPS_DIRECTORY" ]]; then
    echo "Please set 'BACKUPS_DIRECTORY' environment variable before running this command..."
  else
    NOW="$(date +'%Y%m%d-%H%M%S')"
    BACKUP_NAME="projects_backup_${NOW}.tar.gz"

    echo "Backing up '$PROJECTS_DIRECTORY' to '$BACKUP_NAME' now..."

    tar cvzf \
      "$BACKUPS_DIRECTORY/$BACKUP_NAME" --exclude "node_modules" --exclude "gems" --exclude "Pods" --exclude "vendor" --exclude "tmp" --exclude "build" --exclude ".DS_Store" \
       -C "$PROJECTS_DIRECTORY"
  fi
}

function backup_all() {
  backup_projects
}
