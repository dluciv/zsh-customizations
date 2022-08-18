omz plugin load shrink-path

prompt_char () {
  [[ $UID == 0 || $EUID == 0 ]] && echo '#' || echo '¤'
}

setopt PROMPT_SUBST

PROMPT='$(shrink_path -f -g) $(prompt_char) '
unset RPROMPT
