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
    pip install $PROJECTS_DIRECTORY/stock-picks-optimizer/dist/*.whl --force-reinstall
  fi

  stock-picks-optimizer latest
}

function morning-paper() {
  pushd "$PROJECTS_DIRECTORY/morning-papers"
  now=$(date +"%Y-%m-%d") 
  [[ ! -f "${now}.txt" ]] && touch "${now}.txt"
  vim "${now}.txt"
  popd
}
