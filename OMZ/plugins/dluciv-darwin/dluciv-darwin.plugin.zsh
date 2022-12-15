if [[ $OSTYPE == darwin* ]]; then
  alias upgrade='brew upgrade --greedy'
else
  >&2 echo "Darwin upgrade plugin cannot be used with OS '$OSTYPE' OS"
fi
