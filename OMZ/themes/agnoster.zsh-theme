. $ZSH/themes/agnoster.zsh-theme

prompt_context() {
 prompt_segment black default ''
}

# https://shandou.medium.com/how-to-shorten-zsh-prompt-oh-my-zsh-14185f3e7ab7
prompt_dir() {
  # prompt_segment blue $CURRENT_FG '%~'
  # https://unix.stackexchange.com/a/273567
  prompt_segment blue $CURRENT_FG '%(5~|%-1~/…/%3~|%4~)'
}

RPROMPT='%F{8}%n@%m $(date +%T)%F{white}'
