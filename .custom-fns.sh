#!/usr/bin/env bash

function kill-process-on-port() {
  PORT=$1
  if [[ ! -z "$(lsof -t -i :$PORT)" ]]; then
    (kill -9 "$(lsof -t -i:$PORT -sTCP:LISTEN)" >/dev/null 2>&1) || true
  fi
}

function convert-m4a-to-mp3() {
  DIRECTORY=$(basename "$PWD")
  mkdir -p "$DIRECTORY"

  for f in *.m4a; do
    ffmpeg -i "$f" -codec:v copy -codec:a libmp3lame -q:a 2 "$DIRECTORY/${f%.m4a}.mp3"
  done
}

function get-latest-stock-picks() {
  if [[ -z "$(command -v stock-picks-optimizer)" ]]; then
    pip install $CODE_DIRECTORY/stock-picks-optimizer/dist/*.whl --force-reinstall
  fi

  stock-picks-optimizer latest
}

function morning-paper() {
  pushd "$CODE_DIRECTORY/morning-papers"
  now=$(date +"%Y-%m-%d") 
  [[ ! -f "${now}.txt" ]] && touch "${now}.txt"
  mvim +Goyo "${now}.txt"
  popd
}

function restart-docker-compose() {
  if [[ -f "$HOME/.docker-compose.default.yml" ]]; then
    docker compose -f "$HOME/.docker-compose.default.yml" restart
  fi
}

function auto-commit() {
  if git diff-index --cached --quiet HEAD --; then
    echo "Error: unable to find staged files to commit..."
  else
    git diff --staged | mods --quiet --raw "generate a single conventional commit message based on staged changes, only the message please, no backticks surrounding the message either. Don't read whole lock files." | git commit -F -
  fi
}

function summarize-today-commits() {
  result=$(git log --since="12 hours ago" | mods --quiet --raw "summarize")
  echo $result | pbcopy

  echo $result
}
