omz plugin load shrink-path
omz plugin load battery

prompt_char () {
  [[ $UID == 0 || $EUID == 0 ]] && echo '#' || echo '¤'
}

setopt PROMPT_SUBST

PROMPT='$(shrink_path -f -g) $(prompt_char) '
RPROMPT=$'%{\e[$color[faint]m%}%n@%m $(date +%T) $(battery_pct_prompt)%{\e[$color[none]m%}'
