. $ZSH/themes/agnoster.zsh-theme

omz plugin load shrink-path

prompt_context() {
 prompt_segment black default ''
}

# https://shandou.medium.com/how-to-shorten-zsh-prompt-oh-my-zsh-14185f3e7ab7
prompt_dir() {
  # prompt_segment blue $CURRENT_FG '%(5~|%-1~/…/%3~|%4~)' -- lighter way
  prompt_segment blue $CURRENT_FG "$(shrink_path -f)"
}

RPROMPT='%F{8}%n@%m $(date +%T)%F{white}'
