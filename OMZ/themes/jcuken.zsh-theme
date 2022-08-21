omz plugin load shrink-path
omz plugin load battery

_prompt_char () {
  [[ $UID == 0 || $EUID == 0 ]] && echo '#' || echo '¤'
}

_batt_p_pct () {
  p=$(battery_pct_prompt)
  echo ${p//∞/oo}
}

setopt PROMPT_SUBST

PROMPT='$(shrink_path -f -g) $(_prompt_char) '
RPROMPT=$'%{\e[$color[faint]m%}%n@%m $(date +%T) $(_batt_p_pct)%{\e[$color[none]m%}'
