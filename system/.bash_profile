if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/tjmaynes/.sdkman"
[[ -s "/Users/tjmaynes/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/tjmaynes/.sdkman/bin/sdkman-init.sh"
