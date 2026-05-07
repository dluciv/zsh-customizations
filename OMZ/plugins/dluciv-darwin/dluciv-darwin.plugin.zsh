if [[ $OSTYPE == darwin* ]]; then
  if false && command -v zb &>/dev/null; then
    alias upgrade='zb update'
  else
    alias upgrade='brew upgrade --greedy'
  fi
else
  >&2 echo "Darwin upgrade plugin cannot be used with '$OSTYPE' OS"
fi
