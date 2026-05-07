if [[ $OSTYPE == darwin* ]]; then
  if command -v zb &>/dev/null; then
    alias upgrade='zb upgrade'
  else
    alias upgrade='brew upgrade --greedy'
  fi
else
  >&2 echo "Darwin upgrade plugin cannot be used with '$OSTYPE' OS"
fi
