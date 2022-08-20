omz plugin load shrink-path

setopt PROMPT_SUBST

PROMPT='$(shrink_path -f -g) %# '
unset RPROMPT
