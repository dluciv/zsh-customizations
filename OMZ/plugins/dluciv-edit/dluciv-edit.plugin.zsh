if [[ -n $VISUAL ]]; then
  alias edit=$VISUAL
elif [[ -n $EDITOR ]]; then
  alias edit=$EDITOR

elif ! which edit &>/dev/null; then

  if which vim &>/dev/null; then
    alias edit=vim
  elif which vi &>/dev/null; then
    alias edit=vi
  elif which nano &>/dev/null; then
    alias edit=nano
  elif which mc &>/dev/null; then
    alias edit='mc -e'
  elif which emacs &>/dev/null; then
    alias edit='emacs -nw'
  else
    >&2 echo "Having OMZ, but no editors installed – really strange..."
  fi

fi
