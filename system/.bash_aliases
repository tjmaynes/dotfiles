#!/bin/sh

alias psx='ps -x'
alias awake='caffeinate'
alias xcode-delete-derived-data='rm -rf ~/Library/Developer/Xcode/DerivedData'
alias gen-pass='openssl rand -base64 25 | tr -d /'
alias port-usage='sudo lsof -i -P -n | grep LISTEN'
alias init-git='git init && echo ".DS_Store" > .gitignore && touch README.markdown'
alias uuid='uuidgen'
alias gocode='cd $GOPATH/src/github.com/tjmaynes'
alias gpg-force-restart='gpgconf --kill gpg-agent'
alias check-disk-space='du -shxc /*'
alias start-docker='systemctl enable --now docker'
alias stop-docker='systemctl disable docker'
alias switch_to_zsh='chsh -s $(grep /zsh$ /etc/shells | tail -1)'
alias workie='cd $HOME/workspace/tjmaynes'

gpg-easy-encrypt()
{
  gpg \
    --output $1.gpg \
    --encrypt --recipient $2 $1 
}

docker-clean-all()
{
  docker stop $(docker container ls -a -q)
  docker system prune -a -f --all
  docker rm $(docker container ls -a -q)
}

docker-stop-and-remove-image()
{
  docker stop "$(docker ps | grep $1 | awk '{print $1}')"
  docker rm   "$(docker ps | grep $1 | awk '{print $1}')"
  docker rmi  "$(docker images | grep $1 | awk '{print $3}')" --force
}

generate_test_ssl_cert()
{
  generate_ssl_cert test "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"
}

generate_ssl_cert()
{
  openssl genrsa -des3 -passout pass:x -out $1.pass.key 2048
  openssl rsa -passin pass:x -in $1.pass.key -out $1.key
  rm $1.pass.key
  openssl req -nodes -newkey rsa:2048 -keyout $1.key -out $1.csr -subj $2
  openssl x509 -req -sha256 -days 365 -in $1.csr -signkey $1.key -out $1.crt
}

convert_to_gif()
{
  ffmpeg -i $1 -s $2 -pix_fmt rgb8 -r 25 -f gif - | gifsicle --optimize=3 --delay=3 > screencast_`date +"%Y.%m.%d-%H.%M"`.gif
}

get_public_key()
{
  gpg --armor --export $1 | pbcopy  
}
